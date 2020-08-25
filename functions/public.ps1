#These are public functions for the PSReleaseTools module

# Added a class for GitHub issues - August 24, 2020 JDH
Class GitHubIssue {
    [datetime]$Created
    [datetime]$Updated
    [string]$SubmittedBy
    [string]$State = "open"
    [string]$Title
    [string]$Body
    [string[]]$Labels
    [int32]$CommentCount = 0
    [string]$Milestone
    [string]$Url
    [boolean]$IsPullRequest = $False

    [void]Show() {
        Start-Process $this.url
    }

    GitHubIssue([string]$Title, [string]$url, [datetime]$Created, [datetime]$Updated, [string]$Body) {
        $this.Title = $Title
        $this.url = $url
        $this.Created = $Created
        $this.updated = $Updated
        $this.body = $Body
    }
}

Function Open-PSIssue {
    [cmdletbinding()]
    [outputtype("None")]
    Param(
        [Parameter(ValueFromPipelineByPropertyName,HelpMessage = "You can optionally specify the issue URL")]
        [ValidateNotNullOrEmpty()]
        [string]$Url = "https://github.com/powershell/powershell/issues"
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
    } #begin
    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Opening $url"
        start-process $url
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end
}
Function Get-PSIssue {
    [cmdletbinding()]
    [outputtype("GitHubIssue")]
    Param(
        [Parameter(HelpMessage = "Display issues updated since this time.")]
        [datetime]$Since,
        [Parameter(HelpMessage = "Specify a comma separated list of labels to filter with. If you select multiple labels, the issue must have all of them.")]
        [string[]]$Label,
        [Parameter(HelpMessage = "The number of results to return.")]
        [ValidateSet(25, 50, 75, 100, 150, 200)]
        [int]$Count = 25

    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"

        #number of results per page is 25 so calculate how many pages are needed.
        [int]$m = $count/25
        if ($m -ne 1) {
            [int]$PageCount = $m + 1
        }
        else {
            [int]$PageCount = 1
        }

        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Getting $pageCount page(s)."
        $uri = "https://api.github.com/repos/PowerShell/PowerShell/issues?&state=open&sort=updated&direction=desc&per_page=25"

        $header = @{ accept = "application/vnd.github.v3+json" }

        if ($since) {
            $dt = "{0:u}" -f $since
            $uri += "&since=$dt"
        }

        if ($Label) {
            $Labelstring = $Label -join ","
            $uri += "&labels=$Labelstring"
            Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Filtering for labels $Labelstring"
        }

        $irm = @{
            uri              = $uri
            headers          = $header
            DisableKeepAlive = $True
            UseBasicParsing  = $True
        }

        $results = [System.Collections.Generic.List[object]]::new()
        #set a flag to indicate we should keep getting pages
        $run = $True
    } #begin
    Process {

        1..$pageCount | ForEach-Object {
            if ($run) {
                $irm.uri = "$uri&page=$_"
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting recent PowerShell issues: $($irm.uri)"
                #filter out pull requests
                $r = (Invoke-RestMethod @irm).ForEach({ $_ | NewGHIssue })
                if ($r.title) {
                    $results.AddRange($r)
                }
                else {
                    Write-Warning "No matching issues found."
                    $run = $False
                }
            } #if $run
        } #foreach page
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Returned $($results.count) matching issues"
        $results
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end
}

Function Get-PSIssueLabel {
    [cmdletbinding()]
    Param(
        [Parameter(HelpMessage = "Specify a label name. You can use wildcards.")]
        [string]$Name
    )
    Write-Verbose "Starting $($myinvocation.mycommand)"

    $Label = [System.Collections.Generic.list[object]]::new()

    $header = @{ accept = "application/vnd.github.v3+json" }
    $irm = @{
        uri              = ""
        headers          = $header
        DisableKeepAlive = $true
        UseBasicParsing  = $True
    }
    $page = 0
    do {
        Write-Verbose "Processing Page $page"
        $page++
        $irm.uri = "https://api.github.com/repos/powershell/powershell/labels?per_page=50&page=$Page"
        Write-Verbose $irm.uri
        $r = Invoke-RestMethod @irm
        $Label.Addrange( $r.ForEach( { $_ | Select-Object -Property Name, Description }))
    } until ($r.count -eq 0 -or $page -ge 4)

    Write-Verbose "Found $($Label.count) labels"
    if ($Name) {
        Write-Verbose "Filtering for $Name"
        ($label).where( { $_.name -like $Name })
    }
    else {
        $Label
    }$p
    Write-Verbose "Ending $($myinvocation.mycommand)"
}
function Get-PSReleaseCurrent {
    [CmdletBinding()]
    [OutputType("PSCustomObject")]
    param(
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    process {

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

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}

function Get-PSReleaseSummary {
    [CmdletBinding(DefaultParameterSetName = "default")]
    [OutputType([System.String[]])]
    param(
        [Parameter(HelpMessage = "Display as a markdown document", ParameterSetName = "md")]
        [switch]$AsMarkdown,
        [Parameter(ParameterSetName = "md")]
        [Parameter(ParameterSetName = "online")]
        [Parameter(ParameterSetName = "default")]
        [Parameter(HelpMessage = "Get the latest preview release")]
        [switch]$Preview
    )
    dynamicparam {
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


    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using parameter set $($PSCmdlet.ParameterSetName)"
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
                Select-Object @{Name = "Filename"; Expression = { $_.Name } },
                @{Name = "Updated"; Expression = { $_.updated_at -as [datetime] } },
                @{Name = "SizeMB"; Expression = { $_.size / 1MB -as [int] } }

            if ($AsMarkdown) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Formatting as markdown"
                #create a markdown table from download data
                $tbl = (($DL | ConvertTo-Csv -NoTypeInformation -Delimiter "|").Replace('"', '') -Replace '^', "|") -replace "$", "|`n"

                $out = @"
# $($data.name.Trim())

$($data.body.Trim())

## Downloads

$($tbl[0])|---|---|---|
$($tbl[1..$($tbl.Count)])
Published: $($data.published_at -as [datetime])
"@

            }
            else {

                #create a here string for the details
                $out = @"

-----------------------------------------------------------
$($data.name)
Published: $($data.published_at -as [datetime])
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

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}

function Save-PSReleaseAsset {

    [CmdletBinding(DefaultParameterSetName = "All", SupportsShouldProcess)]
    [OutputType([System.IO.FileInfo])]

    param(
        [Parameter(Position = 0, HelpMessage = "Where do you want to save the files?")]
        [ValidateScript( {
                if (Test-Path $_) {
                    $true
                }
                else {
                    throw "Cannot validate path $_"
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


    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Using Parameter set $($PSCmdlet.ParameterSetName)"

        if ($PSCmdlet.ParameterSetName -match "All|Family") {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting latest releases from $uri"
            try {
                $data = Get-PSReleaseAsset -Preview:$Preview -ErrorAction Stop
            }
            catch {
                Write-Warning $_.exception.message
                #bail out
                return
            }
        }

        switch ($PSCmdlet.ParameterSetName) {
            "All" {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Downloading all releases to $Path"
                foreach ($asset in $data) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($asset.filename) [$($asset.Hash)]"
                    $target = Join-Path -Path $path -ChildPath $asset.filename
                    DL -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
                }
            } #all
            "Family" {
                #download individual release files
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Downloading releases for $($family -join ',')"
                $assets = @()
                foreach ($item in $Family) {

                    switch ($item) {
                        "Windows" { $assets += $data.where( { $_.filename -match 'win-x\d{2}' }) }
                        "Rhel" { $assets += $data.where( { $_.filename -match 'rhel' }) }
                        "Raspbian" { $assets += $data.where( { $_.filename -match 'linux-arm' }) }
                        "Debian" { $assets += $data.where( { $_.filename -match 'debian' }) }
                        "MacOS" { $assets += $data.where( { $_.filename -match 'osx' }) }
                        "CentOS" { $assets += $data.where( { $_.filename -match 'centos' }) }
                        "Linux" { $assets += $data.where( { $_.filename -match 'linux-x64' }) }
                        "Ubuntu" { $assets += $data.where( { $_.filename -match 'ubuntu' }) }
                        "Arm" { $assets += $data.where( { $_.filename -match '-arm\d{2}' }) }
                        "AppImage" { $assets += $data.where( { $_.filename -match 'appimage' }) }
                        "FXDependent" { $assets += $data.where( { $_.filename -match 'fxdependent' }) }
                        "Alpine" { $assets += $data.where( { $_.filename -match 'alpine' }) }
                    } #switch

                    if ($PSBoundParameters.ContainsKey("Format")) {
                        $type = $PSBoundParameters["format"] -join "|"
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Limiting download to $type files"
                        $assets = $assets.Where( { $_.filename -match "$type$" })
                    }

                    foreach ($asset in $Assets) {
                        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($Asset.filename) [$($asset.Hash)]"
                        $target = Join-Path -Path $path -ChildPath $asset.fileName
                        DL -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
                    } #foreach asset
                } #foreach family name
            } #Family
            "File" {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($asset.filename) [$($asset.Hash)]"
                $target = Join-Path -Path $path -ChildPath $asset.fileName
                DL -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
            } #file
        } #switch parameter set name

    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}

function Get-PSReleaseAsset {

    [CmdletBinding()]
    [OutputType("PSCustomObject")]
    param(
        [Parameter(HelpMessage = "Limit results to a given platform. The default is all platforms.")]
        [ValidateSet("Rhel", "Raspbian", "Ubuntu", "Debian", "Windows", "AppImage", "Arm", "MacOS", "Alpine", "FXDependent", "CentOS", "Linux")]
        [string[]]$Family,
        [ValidateSet('deb', 'gz', 'msi', 'pkg', 'rpm', 'zip', 'msix')]
        [Parameter(HelpMessage = "Limit results to a given format. The default is all formats.")]
        [string[]]$Format,
        [Alias("x64")]
        [switch]$Only64Bit,
        [Parameter(HelpMessage = "Get the latest preview release.")]
        [switch]$Preview,
        [Parameter(HelpMessage = "Only get LTS release-related assets.")]
        [switch]$LTS
    )

    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting: $($MyInvocation.MyCommand)"
    } #begin

    process {
        try {
            if ($Preview) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting preview assets"
                $data = GetData -Preview -ErrorAction Stop
            }
            else {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Getting normal assets"
                $data = GetData -ErrorAction Stop
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
                $h = @{ }
            } -Process {
                #if there is a duplicate entry, assume it is part of a Note
                $f = $_.Groups["file"].Value.Trim()
                $v = $_.Groups["hash"].Value.Trim()
                if (-not ($h.ContainsKey($f))) {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Adding $f [$v]"
                    $h.Add($f, $v )
                }
                else {
                    Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Ignoring duplicate asset: $f [$v]"
                }
            }

            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Found $($data.assets.count) downloads"

            $assets = $data.assets |
                Select-Object @{Name = "FileName"; Expression = { $_.Name } },
                @{Name = "Family"; Expression = {
                        switch -regex ($_.name) {
                            "Win-x\d{2}" { "Windows" ; break }
                            "arm\d{2}.zip" { "Arm" ; break }
                            "Ubuntu" { "Ubuntu"; break }
                            "osx" { "MacOS"; break }
                            "debian" { "Debian"; break }
                            "appimage" { "AppImage"; break }
                            "rhel" { "Rhel"; break }
                            "linux-arm" { "Raspbian"; break }
                            "alpine" { "Alpine" ; break }
                            "fxdepend" { "FXDependent"; break }
                            "centos" { "CentOS"; break }
                            "linux-x64" { "Linux" ; break }
                        }
                    }
                },
                @{Name = "Format"; Expression = {
                        $_.name.Split(".")[-1]
                    }
                },
                @{Name = "SizeMB"; Expression = { $_.size / 1MB -as [int32] } },
                @{Name = "Hash"; Expression = { $h.Item($_.name) } },
                @{Name = "Created"; Expression = { $_.created_at -as [datetime] } },
                @{Name = "Updated"; Expression = { $_.updated_at -as [datetime] } },
                @{Name = "URL"; Expression = { $_.browser_download_Url } },
                @{Name = "DownloadCount"; Expression = { $_.download_count } }

            if ($Family) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering by family"
                $assets = $assets.where( { $_.family -match $($family -join "|") })
            }
            if ($Only64Bit) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for 64bit"
                $assets = ($assets).where( { $_.filename -match "(x|amd)64" })
            }

            if ($Format) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for format"
                $assets = $assets.where( { $_.format -match $("^$format$" -join "|") })
            }

            If ($LTS) {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Filtering for LTS assets"
                $assets = $assets.where( { $_.filename -match "LTS" })
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
            throw $_
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
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
function Install-PSPreview {
    [CmdletBinding(SupportsShouldProcess)]
    param(
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
    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    process {
        #only run on Windows
        if (($PSEdition -eq 'Desktop') -OR ($PSVersionTable.Platform -eq 'Win32NT')) {
            if ($PSBoundParameters.ContainsKey("WhatIf")) {
                #create a dummy file name is using -Whatif
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a dummy file for WhatIf purposes"
                $filename = Join-Path -Path $Path -ChildPath "whatif-PS7Preview.msi"
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
                    ErrorAction       = "Stop"
                }
                if ($PSCmdlet.ShouldProcess($filename, "Install PowerShell Preview using $mode mode")) {
                    InstallMSI @inParams
                }
            }
        } #if Windows
        else {
            Write-Warning "This command will only work on Windows platforms."
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Install-PSPreview

function Install-PowerShell {
    [CmdletBinding(SupportsShouldProcess)]
    [Alias("Install-PSCore")]
    param(
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
    begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($MyInvocation.MyCommand)"
    } #begin

    process {
        #only run on Windows
        if (($PSEdition -eq 'Desktop') -OR ($PSVersionTable.Platform -eq 'Win32NT')) {
            if ($PSBoundParameters.ContainsKey("WhatIf")) {
                #create a dummy file name is using -Whatif
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Creating a dummy file for WhatIf purposes"
                $filename = Join-Path -Path $Path -ChildPath "whatif-ps7.msi"
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
                    ErrorAction       = "Stop"
                }
                if ($PSCmdlet.ShouldProcess($filename, "Install PowerShell using $mode mode")) {
                    InstallMSI @inParams
                }
            }
        } #if Windows
        else {
            Write-Warning "This will only work on Windows platforms."
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($MyInvocation.MyCommand)"
    } #end

} #close Install-PSCore