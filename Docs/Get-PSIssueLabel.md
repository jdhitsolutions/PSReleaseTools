---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://bit.ly/3lMpNgK
schema: 2.0.0
---

# Get-PSIssueLabel

## SYNOPSIS

Get PowerShell issue labels.

## SYNTAX

```yaml
Get-PSIssueLabel [[-Name] <String>] [<CommonParameters>]
```

## DESCRIPTION

The GitHub issues for the PowerShell repository have numerous labels defined. You can run this command to get a list of these labels.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSIssueLabel

Name                         Description
----                         -----------
.NET                         Pull requests that update .net code
Area-Build
Area-Cmdlets
Area-Cmdlets-Archive
Area-Cmdlets-Core
...
```

## PARAMETERS

### -Name

Specify a label name.
You can use wildcards.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSIssue](Get-PSIssue.md)
