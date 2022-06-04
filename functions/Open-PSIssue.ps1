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
