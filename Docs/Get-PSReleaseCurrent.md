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

```
Get-PSReleaseCurrent [<CommonParameters>]
```

## DESCRIPTION
This command will query the GitHub repository for the latest release and write an object to the pipeline. 

If you are running v6 the LocalVersion property will reflect the GitCommitID so you can accurately compare and determine if you need to update.

## EXAMPLES

### Example 1
```
PS C:\> Get-PSReleaseCurrent

Name                              Version Released             LocalVersion
----                              ------- --------             ------------
v6.0.0 release of PowerShell Core v6.0.0  1/10/2018 5:21:29 PM 5.1.16299.98
```

This gets the current release from a Windows platform.

### Example 2
```
PS /home/me> Get-PSReleaseCurrent
Name                              Version Released            LocalVersion
----                              ------- --------            ------------
v6.0.0 release of PowerShell Core v6.0.0  1/10/18 10:21:29 PM v6.0.0
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
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseSummary]()