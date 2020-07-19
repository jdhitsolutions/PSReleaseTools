#These are public functions for the PSReleaseTools module
Function Get-PSReleaseCurrent {
    [cmdletbinding()]
    [OutputType("PSCustomObject")]
    Param(
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.Mycommand)"
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
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.Mycommand)"
    } #end

}

Function Get-PSReleaseSummary {
    [cmdletbinding(DefaultParameterSetName = "default")]
    [OutputType([System.String[]])]
    Param(
        [Parameter(HelpMessage = "Display as a markdown document", ParameterSetName = "md")]
        [switch]$AsMarkdown,
        [Parameter(ParameterSetName = "md")]
        [Parameter(ParameterSetName = "online")]
        [Parameter(ParameterSetName = "default")]
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )
    DynamicParam {
        if ($IsWindows -OR $PSEdition -eq 'Desktop') {

            #define a parameter attribute object
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ParameterSetName = "online"
            $attributes.HelpMessage = "Open GitHub release page in your browser"

            #define a collection for attributes
            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($attributes)

            #define the dynamic param
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("Online", [switch], $attributeCollection)

            #create array of dynamic parameters
            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("Online", $dynParam1)
            #use the array
            return $paramDictionary

        } #if
    } #dynamic parameter


    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using parameter set $($pscmdlet.ParameterSetName)"
        $PSBoundParameters | Out-String | Write-Verbose
        if ($Preview) {
            $data = GetData -Preview
        }
        else {
            $data = GetData
        }

        if ($PSBoundParameters.ContainsKey("online")) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Opening $($data.html_url)"
            Start-Process $data.html_url
        }
        else {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Displaying locally"
            $dl = $data.assets |
            Select-Object @{Name = "Filename"; Expression = {$_.name}},
            @{Name = "Updated"; Expression = {$_.updated_at -as [datetime]}},
            @{Name = "SizeMB"; Expression = {$_.size / 1MB -as [int]}}

            if ($AsMarkdown) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Formatting as markdown"
                #create a markdown table from download data
                $tbl = (($DL | ConvertTo-Csv -notypeInformation -delimiter "|").Replace('"', '') -Replace '^', "|") -replace "$", "|`n"

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
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.Mycommand)"
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
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS", "Alpine", "FXDependent", "CentOS", "Linux")]
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
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using Parameter set $($PSCmdlet.ParameterSetName)"

        if ($PSCmdlet.ParameterSetName -match "All|Family") {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting latest releases from $uri"
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
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Downloading all releases to $Path"
                foreach ($asset in $data) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($Asset.filename) [$($asset.hash)]"
                    $target = Join-Path -Path $path -ChildPath $asset.filename
                    DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
                }
            } #all
            "Family" {
                #download individual release files
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Downloading releases for $($family -join ',')"
                $assets = @()
                Foreach ($item in $Family) {

                    Switch ($item) {
                        "Windows" { $assets += $data.where( {$_.filename -match 'win-x\d{2}'})}
                        "Rhel" { $assets += $data.where( {$_.filename -match 'rhel'})}
                        "Raspbian" { $assets += $data.where( {$_.filename -match 'linux-arm'})}
                        "Debian" { $assets += $data.where( {$_.filename -match 'debian'})}
                        "MacOS" { $assets += $data.where( {$_.filename -match 'osx'}) }
                        "CentOS" { $assets += $data.where( {$_.filename -match 'centos'}) }
                        "Linux" { $assets += $data.where( {$_.filename -match 'linux-x64'}) }
                        "Ubuntu" { $assets += $data.where( {$_.filename -match 'ubuntu'})}
                        "Arm" { $assets += $data.where( {$_.filename -match '-arm\d{2}'})}
                        "AppImage" { $assets += $data.where( {$_.filename -match 'appimage'})}
                        "FXDependent" { $assets += $data.where( {$_.filename -match 'fxdependent'})}
                        "Alpine" {$assets += $data.where( {$_.filename -match 'alpine' })}
                    } #Switch

                    if ($PSBoundParameters.ContainsKey("Format")) {
                        $type = $PSBoundParameters["format"] -join "|"
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Limiting download to $type files"
                        $assets = $assets.Where( {$_.filename -match "$type$"})
                    }

                    foreach ($asset in $Assets) {
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($Asset.filename) [$($asset.hash)]"
                        $target = Join-Path -Path $path -ChildPath $asset.fileName
                        DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
                    } #foreach asset
                } #foreach family name
            } #Family
            "File" {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($asset.filename) [$($asset.hash)]"
                $target = Join-Path -Path $path -ChildPath $asset.fileName
                DL -source $asset.url -Destination $Target -hash $asset.hash -passthru:$passthru
            } #file
        } #switch parameter set name

    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

Function Get-PSReleaseAsset {

    [cmdletbinding()]
    [OutputType("PSCustomObject")]
    Param(
        [Parameter(HelpMessage = "Limit results to a given platform. The default is all platforms.")]
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS", "Alpine", "FXDependent", "CentOS", "Linux")]
        [string[]]$Family,
        [ValidateSet('deb', 'gz', 'msi', 'pkg', 'rpm', 'zip', 'msix')]
        [Parameter(HelpMessage = "Limit results to a given format. The default is all formats.")]
        [string[]]$Format,
        [alias("x64")]
        [switch]$Only64Bit,
        [Parameter(HelpMessage = "Get the latest preview release.")]
        [switch]$Preview,
        [Parameter(HelpMessage = "Only get LTS release-related assets.")]
        [switch]$LTS
    )

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    } #begin

    Process {
        Try {
            if ($Preview) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting preview assets"
                $data = GetData -Preview -ErrorAction stop
            }
            else {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting normal assets"
                $data = GetData -ErrorAction stop
            }
            #parse out file names and hashes
            #updated pattern 10 March 2020 to capture LTS assets
            [regex]$rx = "(?<file>[p|P]ower[s|S]hell((-preview)|(-lts))?[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            # pre GA pattern
            #"(?<file>[p|P]ower[s|S]hell(-preview)?[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            # original regex pattern
            #"(?<file>[p|P]ower[s|S]hell[-|_]\d.*)\s+-\s+(?<hash>\w+)"
            $r = $rx.Matches($data.body)
            $r | ForEach-Object -Begin {
                $h = @{}
            } -process {
                #if there is a duplicate entry, assume it is part of a Note
                $f = $_.groups["file"].value.trim()
                $v = $_.groups["hash"].value.trim()
                if (-not ($h.ContainsKey($f))) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Adding $f [$v]"
                    $h.add($f, $v )
                }
                else {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Ignoring duplicate asset: $f [$v]"
                }
            }

            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $($data.assets.count) downloads"

            $assets = $data.assets |
            Select-Object @{Name = "FileName"; Expression = {$_.Name}},
            @{Name = "Family"; Expression = {
                    Switch -regex ($_.name) {
                        "Win-x\d{2}" {"Windows" ; break}
                        "arm\d{2}.zip" {"Arm" ; break}
                        "Ubuntu" {"Ubuntu"; break}
                        "osx" {"MacOS"; break}
                        "debian" {"Debian"; break}
                        "appimage" {"AppImage"; break}
                        "rhel" {"Rhel"; break}
                        "linux-arm" {"Raspbian"; break}
                        "alpine" {"Alpine" ; break}
                        "fxdepend" {"FXDependent"; break}
                        "centos" {"CentOS"; break}
                        "linux-x64" {"Linux" ; break}
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
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering by family"
                $assets = $assets.where( {$_.family -match $($family -join "|")})
            }
            if ($Only64Bit) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for 64bit"
                $assets = ($assets).where( {$_.filename -match "(x|amd)64"})
            }

            if ($Format) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for format"
                $assets = $assets.where( {$_.format -match $("^$format$" -join "|")})
            }

            If ($LTS) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for LTS assets"
                $assets = $assets.where( {$_.filename -match "LTS"})
            }
            #write the results to the pipeline
            if ($assets.filename) {
                $assets
            }
            else {
                Write-Warning "Get-PSReleaseAsset Failed to find any release assets using the specified criteria."
            }
        } #Try
        catch {
            Throw $_
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.Mycommand)"
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
        [string]$Mode = "Full",
        [Parameter(HelpMessage = "Enable PowerShell Remoting over WSMan.")]
        [switch]$EnableRemoting,
        [Parameter(HelpMessage = "Enable the PowerShell context menu in Windows Explorer.")]
        [switch]$EnableContextMenu
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        #only run on Windows
        if (($psedition -eq 'Desktop') -OR ($PSVersionTable.platform -eq 'Win32NT')) {
            if ($PSBoundParameters.ContainsKey("WhatIf")) {
                #create a dummy file name is using -Whatif
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a dummy file for WhatIf purposes"
                $filename = Join-Path -path $Path -ChildPath "whatif-PS7Preview.msi"
            }
            else {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Saving download to $Path"
                $msi = Get-PSReleaseAsset -Preview -Family Windows -Only64Bit -Format msi
                if ($msi) {
                    $install = $msi | Save-PSReleaseAsset -Path $Path -Passthru
                    $filename = $install.fullname

                } #if msi found
                else {
                    Write-Warning "No preview MSI file found to download and install."
                }
            }

            if ($filename) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using $filename"

                #call the internal helper function
                $inParams = @{
                    Path              = $filename
                    Mode              = $Mode
                    EnableRemoting    = $EnableRemoting
                    EnableContextMenu = $EnableContextMenu
                    ErrorAction       = "stop"
                }
                if ($pscmdlet.ShouldProcess($filename, "Install PowerShell Preview using $mode mode")) {
                    InstallMSI @inParams
                }
            }
        } #if Windows
        else {
            Write-Warning "This command will only work on Windows platforms."
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Install-PSPreview

Function Install-PowerShell {
    [cmdletbinding(SupportsShouldProcess)]
    [alias("Install-PSCore")]
    Param(
        [Parameter(HelpMessage = "Specify the path to the download folder")]
        [string]$Path = $env:TEMP,
        [Parameter(HelpMessage = "Specify what kind of installation you want. The default if a full interactive install.")]
        [ValidateSet("Full", "Quiet", "Passive")]
        [string]$Mode = "Full",
        [Parameter(HelpMessage = "Enable PowerShell Remoting over WSMan.")]
        [switch]$EnableRemoting,
        [Parameter(HelpMessage = "Enable the PowerShell context menu in Windows Explorer.")]
        [switch]$EnableContextMenu
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin

    Process {
        #only run on Windows
        if (($psedition -eq 'Desktop') -OR ($PSVersionTable.platform -eq 'Win32NT')) {
            if ($PSBoundParameters.ContainsKey("WhatIf")) {
                #create a dummy file name is using -Whatif
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a dummy file for WhatIf purposes"
                $filename = Join-Path -path $Path -ChildPath "whatif-ps7.msi"
            }
            else {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Saving download to $Path "
                $msi = Get-PSReleaseAsset -Family Windows -Only64Bit -Format msi
                if ($msi) {
                    $install = $msi | Save-PSReleaseAsset -Path $Path -Passthru
                    $filename = $install.fullname
                } #if msi found
                else {
                    Write-Warning "No MSI file found to download and install."
                }
            }

            if ($filename) {
                Write-Verbose "[$((Get-Date).TimeOfDay) PROCESS] Using $filename"
                #call the internal helper function
                $inParams = @{
                    Path              = $filename
                    Mode              = $Mode
                    EnableRemoting    = $EnableRemoting
                    EnableContextMenu = $EnableContextMenu
                    ErrorAction       = "stop"
                }
                if ($pscmdlet.ShouldProcess($filename, "Install PowerShell using $mode mode")) {
                    InstallMSI @inParams
                }
            }
        } #if Windows
        else {
            Write-Warning "This will only work on Windows platforms."
        }
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Install-PSCore