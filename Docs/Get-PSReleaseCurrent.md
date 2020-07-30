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


Name                         Version Released            LocalVersion
----                         ------- --------            ------------
v7.0.0 Release of PowerShell v7.0.0  3/4/2020 5:00:08 PM 7.0.0
```

This gets the current release from a Windows platform.

### Example 2

```powershell
PS /home/me> Get-PSReleaseCurrent -preview

Name                              Version     Released            LocalVersion
----                              -------     --------            ------------
v7.0.0-rc.2 Release of PowerShell v7.0.0-rc.2 1/16/20 11:35:38 PM 6.2.4
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

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseSummary](Get-PSReleaseSummary.md)
