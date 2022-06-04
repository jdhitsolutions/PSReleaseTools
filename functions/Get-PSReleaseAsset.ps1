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
