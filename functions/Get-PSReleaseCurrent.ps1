function Get-PSReleaseCurrent {
    [CmdletBinding()]
    [OutputType("PSReleaseStatus")]
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
            #create a custom object. This object has a custom format file.
            [pscustomobject]@{
                PSTypeName   = "PSReleaseStatus"
                Name         = $data.name
                Version      = $data.tag_name
                Released     = $($data.published_at -as [datetime])
                LocalVersion = $local
                URL          = $data.html_url
                Draft        = If ($data.draft -eq 'True') {$True} else {$false}
                Prerelease   = If ($data.prerelease -eq 'True') { $True } else { $false }
             }
        }
    } #process

    end {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending: $($MyInvocation.MyCommand)"
    } #end

}
