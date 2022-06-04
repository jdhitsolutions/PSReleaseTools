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
                    _DownloadAsset -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
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
                        _DownloadAsset -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
                    } #foreach asset
                } #foreach family name
            } #Family
            "File" {
                Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] ...$($asset.filename) [$($asset.Hash)]"
                $target = Join-Path -Path $path -ChildPath $asset.fileName
                _DownloadAsset -source $asset.URL -Destination $Target -Hash $asset.Hash -passthru:$passthru
            } #file
        } #switch parameter set name

    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end
}
