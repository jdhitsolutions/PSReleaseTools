---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/323JVh9
schema: 2.0.0
---

# Get-PSReleaseCurrent

## SYNOPSIS

Get the current PowerShell 7.x release.

## SYNTAX

```yaml
Get-PSReleaseCurrent [-Preview] [<CommonParameters>]
```

## DESCRIPTION

This command will query the GitHub repository for the latest stable PowerShell release and write an object to the pipeline. If you are running PowerShell 7.x the LocalVersion property will reflect the GitCommitID so you can accurately compare and determine if you need to update. Use the -Preview parameter to get the latest preview build.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReleaseCurrent

Name                            OnlineVersion  Released                  LocalVersion
----                            -------        --------                  ------------
v7.1.0 Release of PowerShell    7.1.0          11/11/2020 11:23:08 AM   5.1.19041.610
```

This gets the current release from a Windows platform running Windows PowerShell.

### Example 2

```powershell
PS C:\> Get-PSReleaseCurrent -preview | Select-Object *

Name         : v7.2.0-preview.2 Release of PowerShell
Version      : v7.2.0-preview.2
Released     : 12/15/2020 9:31:39 PM
LocalVersion : 7.1.0
URL          : https://github.com/PowerShell/PowerShell/releases/tag/v7.2.0-preview.2
Draft        : False
Prerelease   : True
```

View all properties for the latest preview release.

### Example 3

```powershell
PS /home/me> Get-PSReleaseCurrent -preview

Name                                    OnelineVersion     Released            LocalVersion
----                                    -------            --------            ------------
v7.2.0-preview.2 Release of PowerShell  7.2.0-preview.2    12/15/2020 21:31:39        7.1.0
```

This gets the current preview release from an Ubuntu platform.

## PARAMETERS

### -Preview

Get the latest preview release.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### PSReleaseStatus

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseSummary](Get-PSReleaseSummary.md)
