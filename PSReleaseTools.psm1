#load functions

# Trivial change.

Get-ChildItem -Path $PSScriptRoot\functions\*.ps1 |
ForEach-Object {
    . $_.fullname
}

#configure TLS settings for GitHub
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#cache issue labels
$global:PSIssueLabel = Get-PSIssueLabel

#define an autocompleter for Get-PSIssue
Register-ArgumentCompleter -CommandName Get-PSIssue -ParameterName Label -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameter)

    Try {
        Get-Variable PSIssuleLabel -Scope global -ErrorAction stop
    }
    Catch {
        $global:PSIssueLabel = Get-PSIssueLabel
    }
    #PowerShell code to populate $wordtoComplete
    ($global:psissuelabel).where( { $_.name -like "*$wordToComplete*" }) | ForEach-Object {
        # completion text,listitem text,result type,Tooltip
        if (-not $_.description) {
            $_.description = "no description"
        }
        [System.Management.Automation.CompletionResult]::new($_.name, $_.name, 'ParameterValue', $_.description)
    }
}