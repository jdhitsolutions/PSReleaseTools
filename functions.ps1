


#region private functions

#define an internal function to download the file
Function DL {
    [cmdletbinding(SupportsShouldProcess)]
    Param([string]$Source, [string]$Destination, [string]$hash, [switch]$Passthru)

    Write-Verbose "[DL] $Source to $Destination"

    if ($pscmdlet.ShouldProcess($Destination, "Downloading $source")) {
        Invoke-Webrequest -Uri $source -UseBasicParsing -DisableKeepAlive -OutFile $Destination
        Write-Verbose "[DL] Comparing file hash to $hash"
        $f = Get-FileHash -Path $Destination -Algorithm SHA256
        if ($f.hash -ne $hash) {
            Write-Warning "Hash mismatch. $Destination may be incomplete."
        }

        if ($passthru) {
            Get-Item $Destination
        }
    } #should process
} #DL

Function GetData {
    [cmdletbinding()]
    Param(
        [switch]$Preview
    )

    $uri = "https://api.github.com/repos/powershell/powershell/releases"

    Write-Verbose "[PROCESS] Getting current release information from $uri"
    $get = Invoke-Restmethod -uri $uri -Method Get -ErrorAction stop

    if ($Preview) {
        Write-Verbose "[PROCESS] Getting latest preview"
        ($get).where( {$_.prerelease}) | Select-Object -first 1
    }
    else {
        Write-Verbose "[PROCESS] Getting latest stable release"
        ($get).where( { -NOT $_.prerelease}) | Select-Object -first 1
    }
}

#endregion

#region public functions
Function Get-PSReleaseCurrent {
    [cmdletbinding()]
    [OutputType("PSCustomObject")]
    Param(
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"

    } #begin

    Process {

        $data = GetData @PSBoundParameters

        #get the local version from the GitCommitID on v6 platforms
        #or PSVersion table for everything else
        if ($PSVersionTable.ContainsKey("GitCommitID")) {
            $local = $PSVersionTable.GitCommitID
        }
        else {
            $Local = $PSVersionTable.PSVersion
        }

        if ($data.tag_name) {
            [pscustomobject]@{
                Name         = $data.name
                Version      = $data.tag_name
                Released     = $($data.published_at -as [datetime])
                LocalVersion = $local
            }
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}

Function Get-PSReleaseSummary {

    [cmdletbinding()]
    [OutputType([System.String[]])]
    Param(
        [Parameter(HelpMessage = "Display as a markdown document")]
        [switch]$AsMarkdown,
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {

        if ($Preview) {
            $data = GetData -Preview
        }
        else {
            $data = GetData
        }

        $dl = $data.assets |
            Select-Object @{Name = "Filename"; Expression = {$_.name}},
        @{Name = "Updated"; Expression = {$_.updated_at -as [datetime]}},
        @{Name = "SizeMB"; Expression = {$_.size / 1MB -as [int]}}

        if ($AsMarkdown) {
            #create a markdown table from download data
            $tbl = (($DL | Convertto-CSV -notypeInformation -delimiter "|").Replace('"', '') -Replace '^', "|") -replace "$", "|`n"

            $out = @"
# $($data.Name.trim())

$($data.body.trim())

## Downloads

$($tbl[0])|---|---|---|
$($tbl[1..$($tbl.count)])
Published: $($data.Published_At -as [datetime])
"@

        }
        else {

            #create a here string for the details
            $out = @"

-----------------------------------------------------------
$($data.Name)
Published: $($data.Published_At -as [datetime])
-----------------------------------------------------------
$($data.body)

-------------
| Downloads |
-------------
$($DL | Out-String)

"@
        }

        #write the string to the pipeline
        $out

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}

Function Save-PSReleaseAsset {

    [cmdletbinding(DefaultParameterSetName = "All", SupportsShouldProcess)]
    [OutputType([System.IO.FileInfo])]

    Param(
        [Parameter(Position = 0, HelpMessage = "Where do you want to save the files?")]
        [ValidateScript( {
                if (Test-Path $_) {
                    $True
                }
                else {
                    Throw "Cannot validate path $_"
                }
            })]
        [string]$Path = ".",
        [Parameter(ParameterSetName = "All")]
        [switch]$All,

        [Parameter(ParameterSetName = "Family", Mandatory, HelpMessage = "Limit results to a given platform. The default is all platforms.")]
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS", "Alpine", "FXDependent")]
        [string[]]$Family,

        [Parameter(ParameterSetName = "Family", HelpMessage = "Limit results to a given format. The default is all formats.")]
        [ValidateSet('deb', 'gz', 'msi', 'pkg', 'rpm', 'zip')]
        [string[]]$Format,

        [Parameter(ParameterSetName = "file", ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [object]$Asset,

        [switch]$Passthru,

        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview

    )


    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Write-Verbose "[PROCESS] Using Parameter set $($PSCmdlet.ParameterSetName)"

        if ($PSCmdlet.ParameterSetName -match "All|Family") {
            Write-Verbose "[PROCESS] Getting latest releases from $uri"
            Try {
                $data = Get-PSReleaseAsset -Preview:$Preview -ErrorAction Stop
            }
            Catch {
                Write-Warning $_.exception.message
                #bail out
                Return
            }
        }

        Switch ($PSCmdlet.ParameterSetName) {
            "All" {
                Write-Verbose "[PROCESS] Downloading all releases to $Path"
                foreach ($asset in $data) {
                    Write-Verbose "[PROCESS] ...$($Asset.filename) [$($asset.hash)]"
                    $target = Join-Path -Path $path -ChildPath $asset.filename
                    DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
                }
            } #all
            "Family" {
                #download individual release files
                Write-Verbose "[PROCESS] Downloading releases for $($family -join ',')"
                $assets = @()
                Foreach ($item in $Family) {

                    Switch ($item) {
                        "Windows" { $assets += $data.where( {$_.filename -match 'win-x\d{2}'})}
                        "Rhel" { $assets += $data.where( {$_.filename -match 'rhel'})}
                        "Raspbian" { $assets += $data.where( {$_.filename -match 'linux'})}
                        "Debian" { $assets += $data.where( {$_.filename -match 'debian'})}
                        "MacOS" { $assets += $data.where( {$_.filename -match 'osx'}) }
                        "Ubuntu" { $assets += $data.where( {$_.filename -match 'ubuntu'})}
                        "Arm" { $assets += $data.where( {$_.filename -match '-arm\d{2}'})}
                        "AppImage" { $assets += $data.where( {$_.filename -match 'appimage'})}
                        "FXDependent" { $assets += $data.where( {$_.filename -match 'fxdependent'})}
                        "Alpine" {$assets += $data.where( {$_.filename -match 'alpine' })}
                    } #Switch

                    if ($PSBoundParameters.ContainsKey("Format")) {
                        $type = $PSBoundParameters["format"] -join "|"
                        Write-Verbose "[PROCESS] Limiting download to $type files"
                        $assets = $assets.Where( {$_.filename -match "$type$"})
                    }

                    foreach ($asset in $Assets) {
                        Write-Verbose "[PROCESS] ...$($Asset.filename) [$($asset.hash)]"
                        $target = Join-Path -Path $path -ChildPath $asset.fileName
                        DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
                    } #foreach asset
                } #foreach family name
            } #Family
            "File" {
                Write-Verbose "[PROCESS] ...$($asset.filename) [$($asset.hash)]"
                $target = Join-Path -Path $path -ChildPath $asset.fileName
                DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
            } #file
        } #switch parameter set name

    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-PSReleaseAsset {
    [cmdletbinding()]
    [OutputType("PSCustomObject")]
    Param(
        [Parameter(HelpMessage = "Limit results to a given platform. The default is all platforms.")]
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS", "Alpine", "FXDependent")]
        [string[]]$Family,
        [ValidateSet('deb', 'gz', 'msi', 'pkg', 'rpm', 'zip')]
        [Parameter(HelpMessage = "Limit results to a given format. The default is all formats.")]
        [string[]]$Format,
        [alias("x64")]
        [switch]$Only64Bit,
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Try {
            if ($Preview) {
                $data = GetData -Preview -ErrorAction stop
            }
            else {
                $data = GetData -ErrorAction stop
            }
            #parse out file names and hashes
            [regex]$rx = "(?<file>[p|P]ower[s|S]hell[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            $r = $rx.Matches($data.body)
            $r | ForEach-Object -Begin {
                $h = @{}
            } -process {
                $h.add($_.groups["file"].value.trim(), $_.groups["hash"].value.trim())
            }

            Write-Verbose "[PROCESS] Found $($data.assets.count) downloads"

            $assets = $data.assets |
                Select-Object @{Name = "FileName"; Expression = {$_.Name}},
            @{Name = "Family"; Expression = {
                    Switch -regex ($_.name) {
                        "Win-x\d{2}" {"Windows"}
                        "arm\d{2}.zip" {"Arm"}
                        "Ubuntu" {"Ubuntu"}
                        "osx" {"MacOS"}
                        "debian" {"Debian"}
                        "appimage" {"AppImage"}
                        "rhel" {"Rhel"}
                        "linux" {"Raspbian"}
                        "alpine" {"Alpine"}
                        "fxdepend" {"FXDependent"}
                    }
                }
            },
            @{Name = "Format"; Expression = {
                    $_.name.split(".")[-1]
                }
            },
            @{Name = "SizeMB"; Expression = {$_.size / 1MB -as [int32]}},
            @{Name = "Hash"; Expression = {$h.item($_.name)}},
            @{Name = "Created"; Expression = {$_.Created_at -as [datetime]}},
            @{Name = "Updated"; Expression = {$_.Updated_at -as [datetime]}},
            @{Name = "URL"; Expression = {$_.browser_download_Url}},
            @{Name = "DownloadCount"; Expression = {$_.download_count}}

            if ($Family) {
                Write-Verbose "[PROCESS] Filtering by family"
                $assets = $assets.where( {$_.family -match $($family -join "|")})
            }
            if ($Only64Bit) {
                Write-Verbose "[PROCESS] Filtering for 64bit"
                $assets = ($assets).where( {$_.filename -match "(x|amd)64"})
            }

            if ($Format) {
                Write-Verbose "[PROCESS] Filtering for format"
                $assets = $assets.where( {$_.format -match $($format -join "|")})
            }
            #write the results to the pipeline
            $assets

        } #Try
        catch {
            Throw $_
        }
    } #process

    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

<#
Display Options
	/quiet
		Quiet mode, no user interaction
	/passive
		Unattended mode - progress bar only
	/q[n|b|r|f]
		Sets user interface level
		n - No UI
		b - Basic UI
		r - Reduced UI
		f - Full UI (default)
#>
Function Install-PSPreview {
    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(HelpMessage = "Specify the path to the download folder")]
        [string]$Path = $env:TEMP,
        [Parameter(HelpMessage = "Specify what kind of installation you want. The default if a full interactive install.")]
        [ValidateSet("Full", "Quiet", "Passive")]
        [string]$Mode = "Full"
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        #only run on Windows
        if (($psedition -eq 'Desktop') -OR ($PSVersionTable.platform -eq 'Win32NT')) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Saving download to $Path "
            $install = Get-PSReleaseAsset -Preview -Family Windows -Only64Bit -Format msi | Save-PSReleaseAsset -Path $Path -Passthru
            if ($PSBoundParameters.ContainsKey("WhatIf")) {
                #create a dummy file name is using -Whatif
                $filename = Join-path -path $Path -ChildPath "whatif-preview.msi"
            }
            else {
                $filename = $install.fullname
            }
            $cmd = "$filename"

            if ($Mode -eq "quiet") {
                $cmd += " /quiet"
            }
            elseif ($Mode -eq "Passive") {
                $cmd += " /passive"
            }
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using $Mode mode"
            $sb = [scriptblock]::Create($cmd)

            if ($pscmdlet.ShouldProcess($sb)) {
                Invoke-Command -scriptblock $sb
            }
        } #if Windows
        else {
            Write-Warning "This will only work on Windows platforms."
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Install-PSPreview

#endregion



