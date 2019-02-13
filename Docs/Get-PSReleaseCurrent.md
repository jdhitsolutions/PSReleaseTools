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
Get-PSReleaseCurrent [-Preview] [<CommonParameters>]
```

## DESCRIPTION

This command will query the GitHub repository for the latest stable release and write an object to the pipeline. If you are running v6 the LocalVersion property will reflect the GitCommitID so you can accurately compare and determine if you need to update. Use the -Preview parameter to get the latest preview build.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSReleaseCurrent


Name                              Version Released             LocalVersion
----                              ------- --------             ------------
v6.1.2 Release of PowerShell Core v6.1.2  1/15/2019 3:02:39 PM 5.1.17763.134
```

This gets the current release from a Windows platform.

### Example 2

```powershell
PS /home/me> Get-PSReleaseCurrent -preview

Name                                        Version          Released           LocalVersion
----                                        -------          --------           ------------
v6.2.0-preview.4 Release of PowerShell Core v6.2.0-preview.4 1/28/19 9:28:01 PM 6.1.2
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

[Get-PSReleaseSummary]()