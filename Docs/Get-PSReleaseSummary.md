---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version:
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information on latest PowerShell v6 release

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
v6.1.2 Release of PowerShell Core
Published: 01/15/2019 15:02:39
-----------------------------------------------------------
## v6.1.2 - 2019-01-15

### Tests

- Fix test failures (Internal 6310)

### Build and Packaging Improvements

- Moved the cleanup logic to `Restore-PSModuleToBuild` (Internal 6442)
- Update dependency versions (Internal 6421)
- Create unified release build for macOS and Linux packages (#8399)
- Build Alpine `tar.gz` package in release builds (Internal 6027)

### Documentation and Help Content

- Update version for README, Alpine docker file and hosting tests (Internal 6438)

### SHA256 Hashes of the release artifacts

- powershell-6.1.2-1.rhel.7.x86_64.rpm
  - DACA3BB4C868667024281D6668ED877234C05F96A49E97E7A7F3619629B84075
- powershell-6.1.2-linux-alpine-x64.tar.gz
  - 6A619BDA0611ABF415524C203A0FC47A80CBB63EAE8BEDDB45916A803030EF42
- powershell-6.1.2-linux-arm32.tar.gz
  - 4C2722C6E7B41D49229BD7E85C2A428D5E4BE77B77B026201FA748B2835AB3A1
- powershell-6.1.2-linux-x64.tar.gz
  - 17CB0DEDCA726BF6CB6C47B513BA1B0977A2BCA9E041AC34AE7F1CE2BB174BDA
- powershell-6.1.2-osx-x64.pkg
  - 23E90DBFD00BF1B4C82DFEF0FBDDA7AA1B2CE5C544FCA0D1CDEF657EF7398689
- powershell-6.1.2-osx-x64.tar.gz
  - 5568DDF50EA071F7D6BB61002EBEAFED9D449AC4950F4C387F779382D03A34D2
- PowerShell-6.1.2-win-arm32.zip
  - A2A3C6F66F20239B3F118F334D6512214995720BFC5902AF6582BE5E981B7659
- PowerShell-6.1.2-win-arm64.zip
  - CDFACB350A8756B43BB6556587C84C19CBACBCBAED4C8EA15F9527D34C0A77D6
- PowerShell-6.1.2-win-x64.msi
  - 271195A099D9D3E906B523B6A40BA6F1E61D962559F408321651C551D5A45EC6
- PowerShell-6.1.2-win-x64.zip
  - EE7C46F2ABD1CDD775C727719C12A428D47AA1C087BC849A09AE18E89982D420
- PowerShell-6.1.2-win-x86.msi
  - D6EE3E941989556D5A5EF3AB940A297387AF7A427B3F4779C0ACDC2BB44C0232
- PowerShell-6.1.2-win-x86.zip
  - 2D6228F4F5FE9A78188286EEF51267F5DE4F2C5F0FF84CD67654AF4F30AEDB37
- powershell_6.1.2-1.debian.8_amd64.deb
  - 43BD89C112B436B262BA6418DD6FE567ECD1836D72591E6425E57EF9F6613EFE
- powershell_6.1.2-1.debian.9_amd64.deb
  - 3D49A399D90A91B50E4978C00489CA3C24B347DBC0E106FC65812B2F8A74B84B
- powershell_6.1.2-1.ubuntu.14.04_amd64.deb
  - D5B14ECC35C30B34871E60909E442F561FE16BBB34F80F024D8B5BD7E44125A7
- powershell_6.1.2-1.ubuntu.16.04_amd64.deb
  - 3ACDE9FE1FEB35EC290270B4F579CE54BCC0D49ACB0C9A5F79BA0ED5FC3C1D6F
- powershell_6.1.2-1.ubuntu.17.10_amd64.deb
  - 797295B4973607C95B79ED1FFB48C3AE2E3BC4C4265FEF7BF313CADE8D535193
- powershell_6.1.2-1.ubuntu.18.04_amd64.deb
  - BA1DE884775766EAADD795BDEF96232D724487E1BFA8B774EB164AD3D16712BA


-------------
| Downloads |
-------------

Filename                                  Updated              SizeMB
--------                                  -------              ------
powershell-6.1.2-1.rhel.7.x86_64.rpm      1/14/2019 8:44:35 PM     55
powershell-6.1.2-linux-alpine-x64.tar.gz  1/14/2019 8:44:56 PM     43
powershell-6.1.2-linux-arm32.tar.gz       1/14/2019 8:45:25 PM     43
powershell-6.1.2-linux-x64.tar.gz         1/14/2019 8:46:21 PM     55
powershell-6.1.2-osx-x64.pkg              1/14/2019 8:47:04 PM     54
powershell-6.1.2-osx-x64.tar.gz           1/14/2019 8:47:37 PM     54
PowerShell-6.1.2-win-arm32.zip            1/14/2019 8:48:02 PM     39
PowerShell-6.1.2-win-arm64.zip            1/14/2019 8:48:29 PM     39
PowerShell-6.1.2-win-x64.msi              1/14/2019 8:49:03 PM     55
PowerShell-6.1.2-win-x64.zip              1/14/2019 8:49:42 PM     56
PowerShell-6.1.2-win-x86.msi              1/14/2019 8:50:21 PM     50
PowerShell-6.1.2-win-x86.zip              1/14/2019 8:50:50 PM     52
powershell_6.1.2-1.debian.8_amd64.deb     1/14/2019 8:51:31 PM     55
powershell_6.1.2-1.debian.9_amd64.deb     1/14/2019 8:52:40 PM     55
powershell_6.1.2-1.ubuntu.14.04_amd64.deb 1/14/2019 8:53:19 PM     55
powershell_6.1.2-1.ubuntu.16.04_amd64.deb 1/14/2019 8:53:53 PM     55
powershell_6.1.2-1.ubuntu.17.10_amd64.deb 1/14/2019 8:54:21 PM     55
powershell_6.1.2-1.ubuntu.18.04_amd64.deb 1/14/2019 8:55:06 PM     55
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

### system.string

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Get-PSReleaseCurrent]()

[Invoke-Restmethod]()
