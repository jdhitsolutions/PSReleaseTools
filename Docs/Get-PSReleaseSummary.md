---
external help file: PSReleaseTools-help.xml
Module Name: psreleasetools
online version:
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information on latest PowerShell v6 release

## SYNTAX

```yaml
Get-PSReleaseSummary [-AsMarkdown] [<CommonParameters>]
```

## DESCRIPTION

This command will query the PowerShell GitHub repository for the latest release information using the GitHub APIs. You do not need to have a GitHub account in order to use this command, although you may still reach an API limit if you run this command repeatedly in a short time frame.

The default output is a text report but you have the the option to create a markdown version.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Get-PSReleaseSummary

-----------------------------------------------------------
Release  : v6.0.0
Published: 01/10/2018 17:21:29
-----------------------------------------------------------
### Breaking changes

- Remove `sc` alias which conflicts with `sc.exe` (#5827)
- Separate group policy settings and enable policy controlled logging in PowerShell Core (#5791)

### Engine updates and fixes

- Handle `DLLImport` failure of `libpsrpclient` in PowerShell Remoting on Unix platforms (#5622)

### Test

- Replace `lee.io` Tests with `WebListener` (#5709) (Thanks @markekraus!)
- Update the docker based release package tests due to the removal of `Pester` module and other issues (#5692)
- Replace Remaining `HttpBin.org` Tests with `WebListener` (#5665) (Thanks @markekraus!)

### Build and Packaging Improvements

- Update x86 and x64 `MSI` packages to not overwrite each other (#5812) (Thanks @bergmeister!)
- Update `Restore-PSPester` to include the fix for nested describe errors (#5771)
- Automate the generation of release change log draft (#5712)

### Documentation and Help Content

- Updated help Uri to point to latest help content for `Microsoft.PowerShell.Core` module (#5820)
- Update the installation doc for `Raspberry-Pi` about supported devices (#5773)
- Fix a typo and a Markdown linting error in the Pull Request Template (#5807) (Thanks @markekraus!)
- Update submodule documentation for pester removal (#5786) (Thanks @bergmeister!)
- Change `Github` to `GitHub` in `CONTRIBUTING.md` (#5697) (Thanks @stuntguy3000!)
- Fix incorrect release date on the changelog (#5698) (Thanks @SwarfegaGit!)
- Add instructions to deploy `win-arm` build on Windows IoT (#5682)

### SHA256 Hashes of the release artifacts

- powershell_6.0.0-1.debian.8_amd64.deb
  - 4A805E7B276646ECD4CD7A33D9B701CA9893FCB3F502E9D87207E1A017CDD7AC
- powershell_6.0.0-1.debian.9_amd64.deb
  - 14CD9082B827E987F63D1539FA5EB448DC9F5F55B927F51D331010B7C35CFD19
- powershell_6.0.0-1.ubuntu.14.04_amd64.deb
  - 690DD94132C841C379A0456E89A7F494379C790E873B55FA3DB2C2E6108447D2
- powershell_6.0.0-1.ubuntu.16.04_amd64.deb
  - A1C4981BB8059D7052DD723BA40F1FF4AD1F8ED3CB037A7D20699FB47AAE9CEE
- powershell_6.0.0-1.ubuntu.17.04_amd64.deb
  - 5A316C60E1D8FB4673D1374BF641CF42D3EC8274D3B606A35AF937198C374F3F
- powershell-6.0.0-1.rhel.7.x86_64.rpm
  - BA625BA77D6E75550E227BF408325BFF25CFFBA1911AC74A8DC11154AEB8314F
- powershell-6.0.0-linux-arm32.tar.gz
  - 65831535A136FFE53077864D55D2F7E51E7DD1CB52CA38E9000032F09B244E86
- powershell-6.0.0-linux-x64.tar.gz
  - 2CCC89CC6C99FF607FF5D82F2DBBEC05C60E0494C75DC500CD46F2EDCC7624FE
- powershell-6.0.0-x86_64.AppImage
  - B1E1E435EC3BEC5BBC350F6E6B9110B4A98D56CC5DA203B234C386139B1477E5
- PowerShell-6.0.0-win-arm32.zip
  - 05C3BD906ECBDD87B2799F720172FA9B5AB5BCF17127DA9DF44765BA76FF310B
- PowerShell-6.0.0-win-arm64.zip
  - 2B308C2435270C1429146B3D309167C7B9BAF3524D3665DA9A703091171FDA2A
- PowerShell-6.0.0-win-x64.msi
  - A1155D0F9D697B3EBF51C03D328886F9000709C1C4688DA42FF9C234AF02A63F
- PowerShell-6.0.0-win-x64.zip
  - FE6C17E9829FFD0503917A1A4ACC3E75A203A80B28E2D9EFFDD7F0AB576F7D5D
- PowerShell-6.0.0-win-x86.msi
  - 494DF01BFF5A007F98761A5088E6E4AA6754808DEE0CBF096FFF171D1233E8FC
- PowerShell-6.0.0-win-x86.zip
  - 8E32785547FDD90412FA3A8FA4703D272933999F3D29CAE9FEDA19119B3A2D46
- powershell-6.0.0-osx-x64.tar.gz
  - B23BDB6A89238C64D7C7A125EB28554693502D6203A9E8EFA84E583F63E44B11
- powershell-6.0.0-osx.10.12-x64.pkg
  - 396BBB5907FD0EC0BDFBFE0BF01961B52B4F1F1CEDDC95467DD9ECD4FA5281DF

-------------
| Downloads |
-------------

Filename                                  Updated              SizeMB
--------                                  -------              ------
powershell-6.0.0-1.rhel.7.x86_64.rpm      1/10/2018 1:28:46 PM     49
powershell-6.0.0-linux-arm32.tar.gz       1/10/2018 1:28:49 PM     24
powershell-6.0.0-linux-x64.tar.gz         1/10/2018 1:28:54 PM     50
powershell-6.0.0-osx-x64.tar.gz           1/10/2018 1:39:22 PM     48
powershell-6.0.0-osx.10.12-x64.pkg        1/10/2018 1:39:13 PM     48
PowerShell-6.0.0-win-arm32.zip            1/10/2018 1:28:58 PM     31
PowerShell-6.0.0-win-arm64.zip            1/10/2018 1:29:02 PM     31
PowerShell-6.0.0-win-x64.msi              1/10/2018 1:29:09 PM     48
PowerShell-6.0.0-win-x64.zip              1/10/2018 1:29:19 PM     49
PowerShell-6.0.0-win-x86.msi              1/10/2018 1:29:24 PM     44
PowerShell-6.0.0-win-x86.zip              1/10/2018 1:29:30 PM     46
powershell-6.0.0-x86_64.AppImage          1/10/2018 1:29:39 PM     73
powershell_6.0.0-1.debian.8_amd64.deb     1/10/2018 1:28:10 PM     50
powershell_6.0.0-1.debian.9_amd64.deb     1/10/2018 1:28:17 PM     50
powershell_6.0.0-1.ubuntu.14.04_amd64.deb 1/10/2018 1:28:23 PM     50
powershell_6.0.0-1.ubuntu.16.04_amd64.deb 1/10/2018 1:28:29 PM     50
powershell_6.0.0-1.ubuntu.17.04_amd64.deb 1/10/2018 1:28:40 PM     50
```

### EXAMPLE 2

```powershell
PS /home/jeff> get-psreleasesummary -AsMarkdown | show-markdown
```

Get the current release summary as markdown and use the Show-Markdown command in PowerShell Core to render the markdown in the console. Note that Show-Markdown may not render tables correctly.

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
