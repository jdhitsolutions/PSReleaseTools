---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version:
schema: 2.0.0
---

# Save-PSReleaseAsset

## SYNOPSIS
Download the latest PowerShell v6 beta releases

## SYNTAX

### All (Default)
```
Save-PSReleaseAsset [[-Path] <String>] [-All] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Family
```
Save-PSReleaseAsset [[-Path] <String>] -Family <String[]> [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### file
```
Save-PSReleaseAsset [[-Path] <String>] [-Asset <Object>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This command will download the latest PowerShell v6 alpha releases from the GitHub repository. You can download everything or limit the download to specific platforms.

If you select Windows files you can use the -Format dynamic parameter to download only MSI or ZIP files. Note that this will not work if you specify a combination of Windows and non-Windows platforms.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Save-PSReleaseAsset C:\PS6 -all
```

### EXAMPLE 2
```
PS C:\> Save-PSReleaseAsset -path C:\PS6 -family Windows -format msi
```
Download and save Windows MSI packages.
### EXAMPLE 3
```
PS C:\> Save-PSReleaseAsset -path C:\PS6 -name Ubuntu,Debian
```
Download and save Ubuntu and Debian packages.
### EXAMPLE 4
```
PS C:\> Get-PSReleaseAsset -Family Ubuntu | Save-PSReleaseAsset -path D:\Temp
```

Get the Ubuntu assets and save them to D:\Temp

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
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

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
An asset object piped from Get-PSReleaseAsset

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
Accepted values: Rhel,Raspbian,Ubuntu,Debian,Windows,AppImage,Arm,MacOS

Required: True
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

### system.io.fileinfo

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Invoke-WebRequest]()

[Get-PSReleaseAsset]()
