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


FileName      : powershell-6.2.4-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 54
Hash          : 1AB9C1EB4A213966E25D8448754D4207C1020B3A282710A1981492C08BF2EEFE
Created       : 1/23/2020 7:11:13 PM
Updated       : 1/23/2020 7:11:17 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v6.2.4/powershell-6.2.4-1.rhel.7.x86_64.rpm
DownloadCount : 929
```

Getting the latest Red Hat related assets for the stable build.

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseAsset -Family Windows -Only64Bit -Preview


FileName      : PowerShell-7.0.0-rc.2-win-x64.msi
Family        : Windows
Format        : msi
SizeMB        : 87
Hash          : A903B63F27882B726E81E7A6EE3E52CE3979036A372DDF4F4D62DF8CE5523345
Created       : 1/16/2020 6:18:21 PM
Updated       : 1/16/2020 6:18:28 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.2/PowerShell-7.0.0-rc.2-win-x64.msi
DownloadCount : 20687

FileName      : PowerShell-7.0.0-rc.2-win-x64.msix
Family        : Windows
Format        : msix
SizeMB        : 90
Hash          : C10DC9A253FAD9AF058D3B9C58DBF533C0831379F60E74F1D873AE8A02356ED2
Created       : 1/16/2020 6:18:28 PM
Updated       : 1/16/2020 6:18:31 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.2/PowerShell-7.0.0-rc.2-win-x64.msix
DownloadCount : 2054

FileName      : PowerShell-7.0.0-rc.2-win-x64.zip
Family        : Windows
Format        : zip
SizeMB        : 89
Hash          : 58C76BF77E206494E1FD82F96B65FC4BF240092DCB247C78077B63976262AF41
Created       : 1/16/2020 6:18:31 PM
Updated       : 1/16/2020 6:18:35 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.2/PowerShell-7.0.0-rc.2-win-x64.zip
DownloadCount : 2153
```

Get the preview build assets for Windows.

### EXAMPLE 3

```powershell
PS C:\> Get-PSReleaseAsset -Family ubuntu | Save-PSReleaseAsset -Path D:\PS6 -whatif

What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.2.4/powershell_6.2.4-1.ubuntu.16.04_amd64.deb" on target "D:\PS6\powershell_6.2.4-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v6.2.4/powershell_6.2.4-1.ubuntu.18.04_amd64.deb" on target "D:\PS6\powershell_6.2.4-1.ubuntu.18.04_amd64.deb".
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
