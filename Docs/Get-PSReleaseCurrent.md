---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version:
schema: 2.0.0
---

# Get-PSReleaseCurrent

## SYNOPSIS

Get the current PowerShell v6 release

## SYNTAX

```yaml
Get-PSReleaseCurrent [<CommonParameters>]
```

## DESCRIPTION

This command will query the GitHub repository for the latest release and write an object to the pipeline. If you are running v6 the LocalVersion property will reflect the GitCommitID so you can accurately compare and determine if you need to update.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReleaseCurrent

Name                              Version Released             LocalVersion
----                              ------- --------             ------------
v6.1.0 Release of PowerShell Core v6.1.0  9/13/2018 9:49:59 PM 6.1.0
```

This gets the current release from a Windows platform.

### Example 2

```powershell
PS /home/me> Get-PSReleaseCurrent

Name                              Version Released           LocalVersion
----                              ------- --------           ------------
v6.1.0 Release of PowerShell Core v6.1.0  9/13/18 9:49:59 PM 6.1.0
```

This gets the current release from an Ubuntu platform.

## PARAMETERS

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseSummary]()