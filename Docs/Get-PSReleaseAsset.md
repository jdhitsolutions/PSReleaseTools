---
external help file: PSReleaseTools-help.xml
online version: 
schema: 2.0.0
---

# Get-PSReleaseAsset

## SYNOPSIS
Get PowerShell release assets.

## SYNTAX

```
Get-PSReleaseAsset [[-Family] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Use this command to get details about the different PowerShell release assets. The default is to get all assets but you can limit results to a particular family like Windows or Ubuntu.

This command will not download the file but allow you to look at the details. You can pipe these results to Save-PSReleaseAsset to download.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Get-PSReleaseAsset -Family MacOS

FileName      : powershell-6.0.0-alpha.14.pkg
Family        : MacOS
Format        : pkg
size          : 40461050
Created       : 12/14/2016 7:24:10 PM
Updated       : 12/14/2016 7:24:17 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.14/powershell-6
                .0.0-alpha.14.pkg
DownloadCount : 2362
```

### -------------------------- EXAMPLE 2 --------------------------
```
PS C:\> Get-PSReleaseAsset -Family Windows | Where format -eq 'zip' | Save-PSReleaseAsset -path F:\PS6 -whatif

What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/downloa
d/v6.0.0-alpha.14/powershell-6.0.0-alpha.14-win10-x64.zip" on target "F:\PS6\powershell-6.0.0-alpha.14-w
in10-x64.zip".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/downloa
d/v6.0.0-alpha.14/powershell-6.0.0-alpha.14-win7-x64.zip" on target "F:\PS6\powershell-6.0.0-alpha.14-wi
n7-x64.zip".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/downloa
d/v6.0.0-alpha.14/powershell-6.0.0-alpha.14-win7-x86.zip" on target "F:\PS6\powershell-6.0.0-alpha.14-wi
n7-x86.zip".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/downloa
d/v6.0.0-alpha.14/powershell-6.0.0-alpha.14-win81-x64.zip" on target "F:\PS6\powershell-6.0.0-alpha.14-w
in81-x64.zip".
```

Run the command without -Whatif to actually download the files and save to F:\PS6

## PARAMETERS

### -Family
Limit search to a particular platform.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 
Accepted values: Windows, Ubuntu, MacOS, CentOS

Required: False
Position: 0
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
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Save-PSReleaseAsset]()
