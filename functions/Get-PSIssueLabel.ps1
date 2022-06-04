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
