


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

        [Parameter(ParameterSetName = "Family", Mandatory)]
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS")]
        [ValidateNotNullorEmpty()]
        [string[]]$Family,

        [Parameter(ParameterSetName = "file", ValueFromPipeline)]
        [object]$Asset,

        [switch]$Passthru,

        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview

    )
    DynamicParam {
        if ($Family -match 'Windows') {
            #define a parameter attribute object
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributes.ValueFromPipelineByPropertyName = $True
            $attributes.HelpMessage = "Select a download format"
            $attributes.ParameterSetName = "Family"
            $attributes.DontShow = $False

            $validate = [System.Management.Automation.ValidateSetAttribute]::New("zip", "msi")

            #define a collection for attributes
            $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($attributes)
            $attributeCollection.Add($validate)

            #define the dynamic param
            $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("Format", [string], $attributeCollection)

            #create array of dynamic parameters
            $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("Format", $dynParam1)
            #use the array
            return $paramDictionary

        } #if
    } #dynamic parameter


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
                    #"Rhel","Raspbian","Ubuntu","Debian","Windows","AppImage","Arm","MacOS"
                    Switch ($item) {
                        "Windows" { $assets += $data.where( {$_.filename -match 'win-x\d{2}'})}
                        "Rhel" { $assets += $data.where( {$_.filename -match 'rhel'}) }
                        "Raspbian" { $assets += $data.where( {$_.filename -match 'linux'})}
                        "Debian" { $assets += $data.where( {$_.filename -match 'debian'}) }
                        "MacOS" { $assets += $data.where( {$_.filename -match 'osx'}) }
                        "Ubuntu" { $assets += $data.where( {$_.filename -match 'ubuntu'})  }
                        "Arm" { $assets += $data.where( {$_.filename -match '-arm\d{2}'}) }
                        "AppImage" { $assets += $data.where( {$_.filename -match 'appimage'}) }
                    } #Switch

                    if (($assets.family -eq 'Windows') -AND ($PSBoundParameters.ContainsKey("Format"))) {
                        $type = $PSBoundParameters["format"]
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
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS")]
        [string[]]$Family,
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
                $assets = $assets.where({$_.family -match $($family -join "|")})
            }
            if ($Only64Bit) {
                Write-Verbose "[PROCESS] Filtering for 64bit"
                $assets = ($assets).where({$_.filename -match "(x|amd)64"})
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

#endregion



