---
external help file: PSReleaseTools-help.xml
online version: 
schema: 2.0.0
---

# Get-PSReleaseCurrent

## SYNOPSIS
Get the current PowerShell v6 release
## SYNTAX

```
Get-PSReleaseCurrent
```

## DESCRIPTION
This command will query the GitHub repository for the latest release and write an object to the pipeline. 

If you are running v6 the LocalVersion property will reflect the GitCommitID so you can accurately compare and determine if you need to update.

## EXAMPLES

### Example 1
```
PS C:\> Get-PSReleaseCurrent
Name                                  Version         Released              LocalVersion 
----                                  -------         --------              ------------ 
v6.0.0-alpha.14 release of PowerShell v6.0.0-alpha.14 12/15/2016 2:51:53 PM 5.0.10586.117
```
This gets the current release from a Windows platform.

### Example 2
```
PS C:\> Get-PSReleaseCurrent
Name                                  Version         Released              LocalVersion 
----                                  -------         --------              ------------ 
v6.0.0-alpha.14 release of PowerShell v6.0.0-alpha.14 12/15/2016 2:51:53 PM v6.0.0-alpha.9
```
This gets the current release from an ubuntu platform.

## PARAMETERS

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseSummary]()