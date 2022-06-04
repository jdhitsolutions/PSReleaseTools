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
