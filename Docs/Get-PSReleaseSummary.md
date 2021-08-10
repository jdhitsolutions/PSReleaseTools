---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/32aTXxf
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information about the latest PowerShell 7.x release.

## SYNTAX

### default (Default)

```yaml
Get-PSReleaseSummary [-Preview] [<CommonParameters>]
```

### md

```yaml
Get-PSReleaseSummary [-AsMarkdown] [-Preview] [<CommonParameters>]
```

### online

```yaml
Get-PSReleaseSummary [-Preview] [-Online] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PowerShell GitHub repository for the latest stable release information using the GitHub APIs. Use -Preview to get information about the latest preview build. You do not need to have a GitHub account to use this command, although you may still reach an API limit if you run this command repeatedly in a short time frame.

The default output is a text report but you have the option to create a markdown version.

Use the -Online parameter to open the GitHub release page in your browser. This parameter only works in Windows.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> PS C:\> Get-PSReleaseSummary

-----------------------------------------------------------
v7.1.0 Release of PowerShell
Published: 11/11/2020 11:23:08
-----------------------------------------------------------
## [7.1.0] - 2020-11-11

- [Diff from 7.1.0-rc.2][7.1.0]
- [Diff from 7.0.0][7.1.0-full]

### Engine Updates and Fixes

- Fix a logic bug in `MapSecurityZone` (#13921) (Thanks @iSazonov!)

### General Cmdlet Updates and Fixes

- Update `pwsh -?` output to match docs (#13748)

### Tests

- `markdownlint` security updates (#13730)

### Build and Packaging Improvements

<details>
<summary>
Bump .NET to version <code>5.0.100-rtm.20526.5</code> (#13920)
</summary>
<ul>
<li>Fixes to release pipeline for GA release (Internal 13410)</li>
<li>Change PkgES Lab to unblock build (Internal 13376)</li>
<li>Add validation and dependencies for <code>Ubuntu 20.04</code> distribution to packaging script (#13993)</li>
<li>Add .NET install workaround for RTM (#13991)</li>
...
```

### EXAMPLE 2

```powershell
PS /home/jeff> get-psreleasesummary -AsMarkdown -preview | Show-Markdown
```

Get the latest preview release summary as markdown and use the Show-Markdown command in PowerShell Core to render the markdown in the console. Note that Show-Markdown may not render tables correctly.

## PARAMETERS

### -AsMarkdown

Create a markdown version of the report.

```yaml
Type: SwitchParameter
Parameter Sets: md
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -Online

Open the GitHub release page in your browser. This parameter only works on Windows systems.

```yaml
Type: SwitchParameter
Parameter Sets: online
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseCurrent](Get-PSReleaseCurrent.md)
