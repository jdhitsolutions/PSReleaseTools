---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/325hHm8
schema: 2.0.0
---

# Get-PSReleaseAsset

## SYNOPSIS

Get PowerShell release assets.

## SYNTAX

```yaml
Get-PSReleaseAsset [[-Family] <String[]>] [-Format <String[]>] [-Only64Bit] [-Preview] [<CommonParameters>]
```

## DESCRIPTION

Use this command to get details about the different PowerShell release assets. The default is to get all assets for the most recent stable release but you can limit results to a particular family like Windows or Ubuntu or get assets from the latest preview build.

This command will not download the file but allow you to look at the details. You can pipe these results to Save-PSReleaseAsset to download.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseAsset -Family Rhel

FileName      : powershell-6.2.1-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 55
Hash          : 1CDF5E804A2FC84E91999E46231B00B8A8635D3595218E9709ADAA8208D02C4D
Created       : 5/21/2019 5:08:40 PM
Updated       : 5/21/2019 5:08:52 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.2.1/powershell-6.2.1-1.rhel.7.x86_64.rpm
DownloadCount : 3225
```

Getting the latest Red Hat related assets for the stable build.

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseAsset -Family Windows -Only64Bit -Preview
FileName      : PowerShell-7.0.0-preview.1-win-x64.msi
Family        : Windows
Format        : msi
SizeMB        : 78
Hash          : D4B6D58B0BFA791E3D613BEC89062579E58951EA07EEDAA54038F317EBBBAD0A
Created       : 5/30/2019 9:13:01 PM
Updated       : 5/30/2019 9:13:16 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.1/PowerShell-7.0.0-preview.1-
                win-x64.msi
DownloadCount : 25063

FileName      : PowerShell-7.0.0-preview.1-win-x64.zip
Family        : Windows
Format        : zip
SizeMB        : 80
Hash          : D3A8926C19B264A1A6CC8F983B04A2C1E70F78EEA8054E00D45ABD216F7907C7
Created       : 5/30/2019 9:13:17 PM
Updated       : 5/30/2019 9:13:28 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-preview.1/PowerShell-7.0.0-preview.1-
                win-x64.zip
DownloadCount : 3641
```

Get the preview build assets for Windows.

### EXAMPLE 3

```powershell
PS C:\> Get-PSReleaseAsset -Family ubuntu | Save-PSReleaseAsset -Path D:\PS6 -whatif
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.2.1/powershell_6.2.1-1.ubuntu.16.04_amd64.deb" on target "D:\PS6\powershell_6.2.1-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.2.1/powershell_6.2.1-1.ubuntu.18.04_amd64.deb" on target "D:\PS6\powershell_6.2.1-1.ubuntu.18.04_amd64.deb".
```

Run the command without -Whatif to actually download the Ubuntu related files and save to D:\PS6

## PARAMETERS

### -Family

Limit search to a particular platform.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Rhel, Raspbian, Ubuntu, Debian, Windows, AppImage, Arm, MacOS, Alpine, FXDependent

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

### -Format

Limit results to a given format. The default is all formats.

```yaml
Type: String[]
Parameter Sets: (All)
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
