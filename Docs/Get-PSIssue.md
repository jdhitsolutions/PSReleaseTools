---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://github.com/jdhitsolutions/PSReleaseTools/blob/master/Docs/Get-PSIssue.md
schema: 2.0.0
---

# Get-PSIssue

## SYNOPSIS

Get PowerShell issues from GitHub.

## SYNTAX

```yaml
Get-PSIssue [[-Since] <DateTime>] [[-Label] <String[]>] [[-Count] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

This function will query the Issues section of the PowerShell repository on GitHub. You can filter for issues updates since a given date. You can filter based on labels. You can also limit how many items to return. The minimum is 25.

NOTE: The function uses the GitHub API which has rate limits. If you attempt to run this command repeatedly, in a short period of time, you might exceed the rate limits. At which point you will have to wait for the limits to reset.

## EXAMPLES

### Example 1

```powershell
PS C:\> Get-PSIssue

  Title: Write better error message if config file is broken

Updated     : 8/24/2020 11:07:02 PM
SubmittedBy : iSazonov
Labels      : {CL-General}
Comments    : 0
Url         : https://github.com/PowerShell/PowerShell/pull/13496
body        : PR Summary

              Fix #11964

              Write better error message if config file is broken.

              PR Context

              PR Checklist

              - [x] "PR has a meaningful title"  - Use the present tense and imperative mood when describing
              your changes
              - [x] "Summarized changes"- [x] "Make sure all "- [x] This PR is ready to merge and is not "Work
              in Progress".
              ...
```

The command has a default list view. If you are running PowerShell 7, the body will be displayed as formatted markdown.

### Example 2

```powershell
PS C:\> Get-PSIssue | Format-Table -view summary

Updated               Comments Title
-------               -------- -----
8/24/2020 11:07:02 PM        0 Write better error message if config file is broken
8/24/2020 10:53:10 PM        3 Linux - Powershell 7 - linux commands should not truncate results by default
8/24/2020 8:26:23 PM         7 Distribution Support Request: Alpine 3.11 arm64
8/24/2020 8:19:14 PM         1 Feature Request: Support PowerShell Core
8/24/2020 7:00:48 PM         0 Remove unused usings
8/24/2020 6:51:58 PM         2 Use boolean instead of bitwise operators on bools
8/24/2020 6:48:54 PM         0 Run dotnet-format
8/24/2020 6:41:46 PM         1 Use uint instead of long for PDH constants
...
```

Display issues using a custom table view.

### Example 3

```powershell
PS C:\> Get-PSIssue -Label First-Time-Issue


   Title: IsReservedDeviceName does not recognize CONIN$, CONOUT$

Updated     : 8/23/2020 10:01:40 PM
SubmittedBy : KalleOlaviNiemitalo
Labels      : {Area-Engine, First-Time-Issue, Issue-Enhancement, Up-for-Grabs}
Comments    : 1
Url         : https://github.com/PowerShell/PowerShell/issues/13046
body        : Steps to reproduce

              "hello" > world
              Move-Item world CONOUT$

              Expected behavior

              Move-Item: Cannot process path 'C:\Temp\u\CONOUT$' because the target represents a reserved device
              name.
              ...
```

### Example 4

```Powershell
PS C:\> Get-PSIssue -count 150 | Sort-Object -property milestone | Format-Table -view milestone
```

Get 150 of the most recently updated issues and display the result in a formatted table grouped by milestone. Be sure to sort on the Milestone property before piping to Format-Table.

## PARAMETERS

### -Count

The number of results to return. The actual number of results you get back may vary depending on other parameters and how the GitHub API pages results. Think of this parameter value as more of an approximation instead of a hard count.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 25, 50, 75, 100, 150, 200

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Label

Specify a comma separated list of labels to filter with.
If you select multiple labels, the issue must have all of them. When the PSReleaseTools module loads, it should define a global variable called PSIssueLabel. This parameter has an auto-completer that uses this variable. If the variable isn't defined, if will be created by running Get-PSIssueLabel.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since

Display issues updated since this time.

```yaml
Type: DateTime
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

### GitHubIssue

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSIssueLabel](Get-PSIssueLabel.md)

[Open-PSIssue](Open-PSIssue.md)
