---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: https://bit.ly/3Aw48h0
schema: 2.0.0
---

# Open-PSIssue

## SYNOPSIS

Open a PowerShell issue in your browser.

## SYNTAX

```yaml
Open-PSIssue [[-Url] <String>] [<CommonParameters>]
```

## DESCRIPTION

This command makes it easy to open the Issues section of the PowerShell GitHub repository. You can run the command by itself to open the Issues section in your browser. Or you can specify an issue URL from Get-PSIssue.

## EXAMPLES

### Example 1

```powershell
PS C:\> Open-PS-Issue
```

Open PowerShell issues in your default browser.

### Example 2

```powershell
PS C:\> $a = Get-PSIssue -since "1/1/2021"
PS C:\> $a[1] | Open-PSSIssue
```

The first command gets all issues since 1/1/2021. The second command opens the issue in your web browser. The objects from Get-PSIssue also have a Show() method which will achieve the same result.

## PARAMETERS

### -Url

You can optionally specify the issue URL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSIssue](Get-PSIssue.md)
