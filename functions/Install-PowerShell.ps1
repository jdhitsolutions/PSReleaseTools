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
        [Parameter(HelpMessage = "Add 'Open Here' context menus to Explorer.")]
        [switch]$EnableContextMenu,
        [Parameter(HelpMessage = "Add 'Run with PowerShell 7` context menu for PowerShell files")]
        [switch]$EnableRunContext
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
                    EnableRunContext  = $EnableRunContext
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

}
