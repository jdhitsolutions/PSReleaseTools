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
Get-PSReleaseAsset [[-Family] <String[]>] [-Format <String[]>] [-Only64Bit] [-Preview] [-LTS]
 [<CommonParameters>]
```

## DESCRIPTION

Use this command to get details about the different PowerShell release assets. The default is to get all assets for the most recent stable release but you can limit results to a particular family like Windows or Ubuntu or get assets from the latest preview build.

This command will not download the file but allow you to look at the details. You can pipe these results to Save-PSReleaseAsset to download.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseAsset -Family Rhel


FileName      : powershell-7.0.0-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 55
Hash          : 09EB0F49F91FC5DA569DE9F8FCADA36CDF79846A1AEA0679D357D316453B2838
Created       : 3/3/2020 10:55:11 PM
Updated       : 3/3/2020 10:55:13 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-1.rhel.7.x86_64.rpm
DownloadCount : 601

FileName      : powershell-lts-7.0.0-1.rhel.7.x86_64.rpm
Family        : Rhel
Format        : rpm
SizeMB        : 58
Hash          : EF6D8728FDE0226A715B85FB199352D9EDE2ECC88CFF890846713CCA34099D82
Created       : 3/3/2020 10:56:50 PM
Updated       : 3/3/2020 10:56:52 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-lts-7.0.0-1.rhel.7.x86_64.rpm
DownloadCount : 346
```

Getting the latest Red Hat related assets for the stable build.

### EXAMPLE 2

```powershell
PS C:\> Get-PSReleaseAsset -Family Windows -Only64Bit -Preview


FileName      : PowerShell-7.0.0-rc.3-win-x64.msi
Family        : Windows
Format        : msi
SizeMB        : 87
Hash          : 26ECB13EAD40B006B74C6A901A9F9CF08AE12F9D9E3C77A07CB8D0CFA8C7024C
Created       : 2/21/2020 11:43:55 PM
Updated       : 2/21/2020 11:43:57 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.3/PowerShell-7.0.0-rc.3-win-x64.msi
DownloadCount : 17953

FileName      : PowerShell-7.0.0-rc.3-win-x64.msix
Family        : Windows
Format        : msix
SizeMB        : 90
Hash          : 6E75503E0F026D9065FDE35885015645E7AA82E376F68A9E98A8892FC987D1E5
Created       : 2/21/2020 11:43:57 PM
Updated       : 2/21/2020 11:43:59 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.3/PowerShell-7.0.0-rc.3-win-x64.msix
DownloadCount : 1558

FileName      : PowerShell-7.0.0-rc.3-win-x64.zip
Family        : Windows
Format        : zip
SizeMB        : 89
Hash          : C8448F44619517C24DF8F392D6AC9E3A1F9589F2C74A3C9EB8CC94B902D78835
Created       : 2/21/2020 11:43:59 PM
Updated       : 2/21/2020 11:44:01 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0-rc.3/PowerShell-7.0.0-rc.3-win-x64.zip
DownloadCount : 1763
```

Get the preview build assets for Windows.

### EXAMPLE 3

```powershell
PS C:\> Get-PSReleaseAsset -Family ubuntu -lts | Save-PSReleaseAsset -Path D:\PS -whatif

What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb" on target "D:\PS\powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb" on target "D:\PS\powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb".
```

Run the command without -Whatif to actually download the Ubuntu related files that are also part of the LTS channel, and save to D:\PS.

## PARAMETERS

### -Family

Limit search to a particular platform.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:
Accepted values: Rhel, Raspbian, Ubuntu, Debian, Windows, AppImage, Arm, MacOS, Alpine, FXDependent, CentOS, Linux

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
Accepted Values: deb, gz, msi, pkg, rpm, zip, msix

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

### -LTS

Only get LTS release-related assets.

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

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Save-PSReleaseAsset](Save-PSReleaseAsset.md)
