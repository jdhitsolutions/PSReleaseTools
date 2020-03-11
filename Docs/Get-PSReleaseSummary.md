---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version: http://bit.ly/32aTXxf
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information on latest PowerShell 7.x release.

## SYNTAX

```yaml
Get-PSReleaseSummary [-AsMarkdown] [-Preview] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PowerShell GitHub repository for the latest stable release information using the GitHub APIs. Use -Preview to get information about the latest preview build. You do not need to have a GitHub account in order to use this command, although you may still reach an API limit if you run this command repeatedly in a short time frame.

The default output is a text report but you have the the option to create a markdown version.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseSummary


-----------------------------------------------------------
v7.0.0 Release of PowerShell
Published: 03/04/2020 17:00:08
-----------------------------------------------------------
## 7.0.0 - 2020-03-04

- [Diff from 7.0.0-rc.3][7.0.0]
- [Diff from 6.2.0][7.0.0-full]

**Note:** The snap package is segfault after launching on Ubuntu 16.04.  We are investigating with the .NET team.  The workaround for not is to use the `DEB` or `tar.gz` package.

### General Cmdlet Updates and Fixes

- Enable `Ctrl+C` to work for global tool (#11959)
- Fix `ConciseView` to not show the line information within the error messages (#11952)

### Build and Packaging Improvements

- Publish PowerShell into the Windows engineering system package format (#11960)
- Bump .NET core framework to `3.1.2` (#11963)
- Ensure the man page `gzip` has the correct name for LTS release (#11956)
- Bump `Microsoft.ApplicationInsights` from `2.13.0` to `2.13.1` (#11925)

### SHA256 Hashes of the release artifacts

- powershell_7.0.0-1.debian.10_amd64.deb
  - 58B2F022B909C8BC96B288384024B58EF6CF8D2724F1C7425C7745E0AC84A8C5
- powershell_7.0.0-1.debian.11_amd64.deb
  - 3ED567A3107DC8319E8BAB9C9A01A00B3344BD2DB6F92BF0ECE4E49FA77BD87D
- powershell_7.0.0-1.debian.9_amd64.deb
  - 53D3B358A0B98B674E329C7D43860F747AAF77747AEAD8F667B8594D21C8CE53
- powershell_7.0.0-1.ubuntu.16.04_amd64.deb
  - 245A55BBFF2BEA43F501EEB511C317DB62774298F5310EF3357307899FF3B091
- powershell_7.0.0-1.ubuntu.18.04_amd64.deb
  - A28C95B376E6DD7EF0BF523B6BD329485948A53E27FD2E8B3DDED6981471214C
- powershell-7.0.0-1.centos.8.x86_64.rpm
  - 3F5EEEF95F24B1804034B29036F6C3D7951F7B995E637713DEFF3088EED7BF65
- powershell-7.0.0-1.rhel.7.x86_64.rpm
  - 09EB0F49F91FC5DA569DE9F8FCADA36CDF79846A1AEA0679D357D316453B2838
- powershell-7.0.0-linux-alpine-x64.tar.gz
  - 5D04337A8B18494DF242F68DD4C960EFBE491AE127901CA15007993F1983CCDF
- powershell-7.0.0-linux-arm32.tar.gz
  - CBB6ACBB40F73CCF83920F4729DC86EBF3566BB9A01CA68E0698D33FDBE6D7B0
- powershell-7.0.0-linux-arm64.tar.gz
  - C361C1440012A59DAC02B3B36744B728AE2409356876C0845C5CA2DAFA8E6153
- powershell-7.0.0-linux-x64.tar.gz
  - 3E80A662A5DEFB283185961330C4A44D5D5179F9EB2A2EE74AC7E1D3CAF16B2C
- powershell-7.0.0-linux-x64-fxdependent.tar.gz
  - 1B232E7704BB128534FED670D17617E1E34558398B4E6227A5E5F28FDA003E95
- powershell-7.0.0-osx-x64.tar.gz
  - 7EA2A539CB33F3C1C62280EEA1D3B55CBD84C86676437A390E81C0AE374483E6
- PowerShell-7.0.0-win-arm32.zip
  - BA260EBA7AC2FFBD7E63570738AAC92440D434DD84ACAA1E70C58649461718D4
- PowerShell-7.0.0-win-arm64.zip
  - 2FD04091F7AACF2BBBA470EDC92A28034CD6F54999F7A880404AD17954476ABF
- PowerShell-7.0.0-win-fxdependent.zip
  - 8A96806066C0BC2AFED53C1A5B5167BCC6D75E9600EC1D69CDEF242B3920F5E3
- PowerShell-7.0.0-win-fxdependentWinDesktop.zip
  - 3BF3898D97610F1ACDFBA819399A876DCE2B5788184C7FF3BE017522E71B47EF
- PowerShell-7.0.0-win-x64.msi
  - 876F4A64012A1FB024DCCEA696DB00C5CD1A37C8DC9DFA2431C58CDF9F82950B
- PowerShell-7.0.0-win-x64.zip
  - CDA2CA2227FBEC2C753AA760859667B02007D14646A831BD908B8F749CBCC687
- PowerShell-7.0.0-win-x86.msi
  - C0E8CBE16EDA134385D499881E6E0F2784BCB4D26CBE42ED5B81E29EEC37B3DA
- PowerShell-7.0.0-win-x86.zip
  - F33E852F7721E61FF3BAE9FC04F1DFA48CE7B10CD59D649126D5BA9BFAD9AECD
- powershell-lts_7.0.0-1.debian.10_amd64.deb
  - 54CBB3915CC01B215AAB0E260C73131DDDE410CFC50440BC8C4D2E336992882A
- powershell-lts_7.0.0-1.debian.11_amd64.deb
  - 974BB634616B4FD1B4A9E024580C1936410D1C267E23BFD34164F1853428BFBF
- powershell-lts_7.0.0-1.debian.9_amd64.deb
  - F49DDA694DA791CEE0F0B456FAB0A2818079102ED9D51B89E1F1879654BA62E1
- powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb
  - 54B39CCB64D84DEF03D2C216757D53B233B3D5F74636675C7DFFEEAA72E8B1CA
- powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb
  - AB4B7E104CAD9DC7D43AD18F335EA14919CF4A930B55348D6601C99A12D9A4FC
- powershell-lts-7.0.0-1.centos.8.x86_64.rpm
  - 1CD5DA84E398A216B2D37F7B1361601B0EF4D79D33A1219C70BB8C083D9CD191
- powershell-lts-7.0.0-1.rhel.7.x86_64.rpm
  - EF6D8728FDE0226A715B85FB199352D9EDE2ECC88CFF890846713CCA34099D82
- powershell-lts-7.0.0-osx-x64.pkg
  - 28321A96A8630E3BFD9E8858645D5D35B3E9D7918A63F557924E97414D303C76
- powershell-7.0.0-osx-x64.pkg
  - 80F75903E9F33B407A7F15C087A2C2B12A93DC153469E091D18048D01080085E

[7.0.0]: https://github.com/PowerShell/PowerShell/compare/v7.0.0-rc.3...v7.0.0
[7.0.0-full]: https://github.com/PowerShell/PowerShell/compare/v6.2.0...v7.0.0



-------------
| Downloads |
-------------

Filename                                       Updated              SizeMB
--------                                       -------              ------
powershell-7.0.0-1.centos.8.x86_64.rpm         3/3/2020 10:55:10 PM     55
powershell-7.0.0-1.rhel.7.x86_64.rpm           3/3/2020 10:55:13 PM     55
powershell-7.0.0-linux-alpine-x64.tar.gz       3/3/2020 10:55:14 PM     45
powershell-7.0.0-linux-arm32.tar.gz            3/3/2020 10:55:18 PM     46
powershell-7.0.0-linux-arm64.tar.gz            3/3/2020 10:55:20 PM     44
powershell-7.0.0-linux-x64-fxdependent.tar.gz  3/3/2020 10:55:24 PM     19
powershell-7.0.0-linux-x64.tar.gz              3/3/2020 10:55:22 PM     58
powershell-7.0.0-osx-x64.pkg                   3/4/2020 6:13:08 PM      55
powershell-7.0.0-osx-x64.tar.gz                3/3/2020 10:55:25 PM     55
PowerShell-7.0.0-win-arm32.zip                 3/3/2020 10:55:29 PM     49
PowerShell-7.0.0-win-arm64.zip                 3/3/2020 10:55:35 PM     49
PowerShell-7.0.0-win-fxdependent.zip           3/3/2020 10:55:36 PM     21
PowerShell-7.0.0-win-fxdependentWinDesktop.zip 3/3/2020 10:55:37 PM     20
PowerShell-7.0.0-win-x64.msi                   3/3/2020 10:55:39 PM     87
PowerShell-7.0.0-win-x64.zip                   3/3/2020 10:55:53 PM     89
PowerShell-7.0.0-win-x86.msi                   3/3/2020 10:56:01 PM     79
PowerShell-7.0.0-win-x86.zip                   3/3/2020 10:56:17 PM     80
powershell-lts-7.0.0-1.centos.8.x86_64.rpm     3/3/2020 10:56:50 PM     58
powershell-lts-7.0.0-1.rhel.7.x86_64.rpm       3/3/2020 10:56:52 PM     58
powershell-lts-7.0.0-osx-x64.pkg               3/3/2020 10:56:54 PM     55
powershell-lts_7.0.0-1.debian.10_amd64.deb     3/3/2020 10:56:21 PM     58
powershell-lts_7.0.0-1.debian.11_amd64.deb     3/3/2020 10:56:25 PM     58
powershell-lts_7.0.0-1.debian.9_amd64.deb      3/3/2020 10:56:27 PM     58
powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb  3/3/2020 10:56:36 PM     58
powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb  3/3/2020 10:56:42 PM     58
powershell_7.0.0-1.debian.10_amd64.deb         3/3/2020 10:54:44 PM     56
powershell_7.0.0-1.debian.11_amd64.deb         3/3/2020 10:54:51 PM     56
powershell_7.0.0-1.debian.9_amd64.deb          3/3/2020 10:54:57 PM     56
powershell_7.0.0-1.ubuntu.16.04_amd64.deb      3/3/2020 10:55:02 PM     56
powershell_7.0.0-1.ubuntu.18.04_amd64.deb      3/3/2020 10:55:08 PM     56
```

### EXAMPLE 2

```powershell
PS /home/jeff> get-psreleasesummary -AsMarkdown -preview | show-markdown
```

Get the latest preview release summary as markdown and use the Show-Markdown command in PowerShell Core to render the markdown in the console. Note that Show-Markdown may not render tables correctly.

## PARAMETERS

### -AsMarkdown

Create a markdown version of the report.

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

### System.String

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseCurrent]()

[Invoke-Restmethod]()
