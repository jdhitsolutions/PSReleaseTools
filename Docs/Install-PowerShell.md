---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/325i1Bm
schema: 2.0.0
---

# Install-PowerShell

## SYNOPSIS

Install the latest PowerShell 7.x version on Windows.

## SYNTAX

```yaml
Install-PowerShell [[-Path] <String>] [[-Mode] <String>] [-EnableRemoting] [-EnableContextMenu] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

This command is intended to make it easy to download and install the latest PowerShell (7.x) *stable* release on Windows platforms. The command will download the 64bit MSI package and initiate the installation process. You can control how much of the installation you want to interact with. The default is the full, interactive installer. Previous versions will either be removed or overwritten based on the MSI package. You also have options to enable PowerShell remoting over WSMan as well as enable a context menu in Windows Explorer to open current location in a PowerShell session.

This command will only work on Windows platforms. Non-Windows platforms have better native installation tools.

This command has an alias of Install-PSCore for backwards compatibility.

## EXAMPLES

### Example 1

```powershell
PS C:\> Install-PowerShell -mode Passive -EnableRemoting -EnableContextMenu
```

Download and install using the passive mode which will only display a progress bar.
PowerShell remoting will be enabled as well as the "Open in PowerShell" context menu in Windows Explorer.

## PARAMETERS

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

### -EnableContextMenu

Enable the PowerShell context menu in Windows Explorer.

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

### -EnableRemoting

Enable PowerShell Remoting over WSMan.

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

### -Mode

Specify what kind of installation you want.

- Quiet is no interaction at all.
- Passive will display a progress bar.
- Full is the complete interactive experience.

The default is a full interactive install.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Full, Quiet, Passive

Required: False
Position: 1
Default value: Full
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specify the path to the download folder.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: $env:\temp
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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Save-PSReleaseAsset]()

[Install-PSPreview]()
