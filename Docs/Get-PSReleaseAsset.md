---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version:
schema: 2.0.0
---

# Get-PSReleaseAsset

## SYNOPSIS

Get PowerShell release assets.

## SYNTAX

```yaml
Get-PSReleaseAsset [[-Family] <String[]>] [-Only64Bit] [-Preview] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get details about the different PowerShell release assets. The default is to get all assets for the most recent stable release but you can limit results to a particular family like Windows or Ubuntu or get assets from the latest preview build.

This command will not download the file but allow you to look at the details. You can pipe these results to Save-PSReleaseAsset to download.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseAsset -Family Rhel

FileName      : powershell-6.1.2-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 55
Hash          : DACA3BB4C868667024281D6668ED877234C05F96A49E97E7A7F3619629B84075
Created       : 1/14/2019 8:44:20 PM
Updated       : 1/14/2019 8:44:35 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/powershell-6.1.2-1.rhel.7.x86_64.rpm
DownloadCount : 2736

PS C:\> Get-PSReleaseAsset -Family Rhel -preview

FileName      : powershell-preview-6.2.0_preview.4-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 55
Hash          :
Created       : 1/25/2019 2:51:03 PM
Updated       : 1/25/2019 2:51:43 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.2.0-preview.4/powershell-preview-6.2.0_preview.4-1.rhel.7.x86_64.rpm
DownloadCount : 897

```

Getting the latest Red Hat related assets for both the stable and preview build.

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseAsset -Family ubuntu | Save-PSReleaseAsset -Path D:\PS6 -whatif
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/powershell_6.1.2-1.ubuntu.14.04_amd64.deb" on target "D:\PS6\powershell_6.1.2-1.ubuntu.14.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/powershell_6.1.2-1.ubuntu.16.04_amd64.deb" on target "D:\PS6\powershell_6.1.2-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/powershell_6.1.2-1.ubuntu.17.10_amd64.deb" on target "D:\PS6\powershell_6.1.2-1.ubuntu.17.10_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/powershell_6.1.2-1.ubuntu.18.04_amd64.deb" on target "D:\PS6\powershell_6.1.2-1.ubuntu.18.04_amd64.deb".
```

Run the command without -Whatif to actually download the Ubuntu related files and save to D:\PS6

### EXAMPLE 3

```powershell
PS C:\> Get-PSReleaseAsset -Family Windows -Only64Bit


FileName      : PowerShell-6.1.2-win-x64.msi
Family        : Windows
Format        : msi
SizeMB        : 55
Hash          : 271195A099D9D3E906B523B6A40BA6F1E61D962559F408321651C551D5A45EC6
Created       : 1/14/2019 8:48:45 PM
Updated       : 1/14/2019 8:49:03 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/PowerShell-6.1.2-win-x64.msi
DownloadCount : 46109

FileName      : PowerShell-6.1.2-win-x64.zip
Family        : Windows
Format        : zip
SizeMB        : 56
Hash          : EE7C46F2ABD1CDD775C727719C12A428D47AA1C087BC849A09AE18E89982D420
Created       : 1/14/2019 8:49:05 PM
Updated       : 1/14/2019 8:49:42 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.1.2/PowerShell-6.1.2-win-x64.zip
DownloadCount : 5799
```

Get the latest 64bit Windows related assets.

## PARAMETERS

### -Family

Limit search to a particular platform.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Rhel, Raspbian, Ubuntu, Debian, Windows, AppImage, Arm, MacOS

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Only64Bit

Only display 64bit assets.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: x64

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Save-PSReleaseAsset]()
