---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/325USis
schema: 2.0.0
---

# Save-PSReleaseAsset

## SYNOPSIS

Download the latest PowerShell v6.x  releases

## SYNTAX

### All (Default)

```yaml
Save-PSReleaseAsset [[-Path] <String>] [-All] [-Passthru] [-Preview] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Family

```yaml
Save-PSReleaseAsset [[-Path] <String>] -Family <String[]> [-Format <String[]>] [-Passthru] [-Preview] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### file

```yaml
Save-PSReleaseAsset [[-Path] <String>] [-Asset <Object>] [-Passthru] [-Preview] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

This command will download the latest stable PowerShell Core releases from the GitHub repository. You can download everything or limit the download to specific platforms. Use -Preview to get the latest preview build.


## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Save-PSReleaseAsset C:\PS6 -all
```

### EXAMPLE 2

```powershell
PS C:\> Save-PSReleaseAsset -path C:\PS6 -family Windows -format msi
```

Download and save Windows MSI packages.

### EXAMPLE 3

```powershell
PS C:\> Save-PSReleaseAsset -path C:\PS6 -name Ubuntu,Debian
```

Download and save Ubuntu and Debian packages.

### EXAMPLE 4

```powershell
PS C:\> Get-PSReleaseAsset -Family rhel -preview | Save-PSReleaseAsset -path D:\Temp -passthru

    Directory: D:\Temp


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         7/10/2019 11:33 AM       52896509 powershell-preview-7.0.0_preview.1-1.rhel.7.x86_64.rpm
```

Get the RedHat assets for the latest preview build and save them to D:\Temp

## PARAMETERS

### -Path

The destination folder for all downloads.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -All

Download all files to the destination path. This is the default behavior.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Passthru

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Asset

An asset object piped from Get-PSReleaseAsset.

```yaml
Type: Object
Parameter Sets: file
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Family

The platform you wish to download.

```yaml
Type: String[]
Parameter Sets: Family
Aliases:
Accepted values: Rhel, Raspbian, Ubuntu, Debian, Windows, AppImage, Arm, MacOS, Alpine, FXDependent

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

Limit results to a given format. The default is all formats.

```yaml
Type: String[]
Parameter Sets: Family
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

### system.string

## OUTPUTS

### System.IO.FileInfo

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WebRequest]()

[Get-PSReleaseAsset]()
