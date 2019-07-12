---
external help file: PSReleaseTools-help.xml
Module Name: PSReleaseTools
online version:
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS

Get information on latest PowerShell [Core] release

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
v6.2.1 Release of PowerShell Core
Published: 05/21/2019 17:58:45
-----------------------------------------------------------
## v6.2.1 - 05/21/2019

### Engine Updates and Fixes

- Re-enable tab completion for functions (#9383)
- Disable debugger in System Lock down mode (Internal 8428)

### Code Cleanup

- Update repo for Ubuntu 14.04 EOL (#9324)

### Tests

- Fix skipping of tests in `RemoteSession.Basic.Tests.ps1` (#9304)
- Update tests to account for when `$PSHOME` is read only (#9279)
- Mark tests in macOS CI which use `applescript` as pending/inconclusive (#9352)
- Make sure non-Windows CI fails when a test fails (#9303)

### Build and Packaging Improvements

- Partially revert "Fix the failed test and update `Publish-TestResults` to make `AzDO` fail the task when any tests failed (#9457)"
- Bump `Markdig.Signed` from `0.16.0` to `0.17.0` (#9595)
- Bump `Microsoft.PowerShell.Archive` from `1.2.2.0` to `1.2.3.0` in `/src/Modules` (#9594)
- Enable building on Kali Linux (#9471)
- Fix the failed test and update `Publish-TestResults` to make `AzDO` fail the task when any tests failed (#9457)
- Add Preview assets for `msix` (#9375)
- Create code coverage and test packages for non-windows (#9373)
- Fix publishing daily `nupkg` to MyGet (#9269)
- Bump `PackageManagement` from `1.3.1` to `1.3.2` in `/src/Modules` (#9568)
- Bump `NJsonSchema` from `9.13.27` to `9.13.37` (#9524)
- Bump `gulp` from `4.0.0` to `4.0.2` in `/test/common/markdown` (#9443)
- Bump `Newtonsoft.Json` from `12.0.1` to `12.0.2` (#9433)
- Bump `System.Net.Http.WinHttpHandler` from `4.5.2` to `4.5.3` (#9367)
- Add `AccessToken` variable to jobs that perform signing (#9351)
- Create test package for macOS on release builds (#9344)
- Add component detection to all jobs (#8964)
- Move artifacts to artifact staging directory before uploading (#9273)

### SHA256 Hashes of the release artifacts

- powershell_6.2.1-1.debian.9_amd64.deb
  - 8F82DA9935196C420B82F5AAD731FC2992043668F49275E6955611440780C6F7
- powershell_6.2.1-1.ubuntu.16.04_amd64.deb
  - D2AF5AC877098ED4A2F86987C5F4D74DC2CFECF9E75805ECD04521EE2E4B25D0
- powershell_6.2.1-1.ubuntu.18.04_amd64.deb
  - B3FE1E5E03B566DE81EDB3C1B767BCBA76715D6FF9CA37BF3692B1711F076306
- powershell-6.2.1-1.rhel.7.x86_64.rpm
  - 1CDF5E804A2FC84E91999E46231B00B8A8635D3595218E9709ADAA8208D02C4D
- powershell-6.2.1-linux-alpine-x64.tar.gz
  - F1AB8E64706858190355AA41C5E481E0074A8E485DB4687E5BA5D1F1595726D9
- powershell-6.2.1-linux-arm32.tar.gz
  - 1C1ED1C764980C98092FAF8DABAA4C635AD9ED9BA43F5D1872DC27C47C7FD923
- powershell-6.2.1-linux-arm64.tar.gz
  - 7605F347F543880A90C1F67305C802562384A4DCDA9E797D501E7BBF674645AC
- powershell-6.2.1-linux-x64.tar.gz
  - E8287687C99162BF70FEFCC2E492F3B54F80BE880D86B9A0EC92C71B05C40013
- powershell-6.2.1-linux-x64-fxdependent.tar.gz
  - 36F70A4D79094FEEA7BA21527531C0A4C3F2691EFA554AEA012E73285C2E9841
- powershell-6.2.1-osx-x64.pkg
  - F490DC74E47467BD171E0F6B0496900F094467B34F85498DE043D15572D6B35B
- powershell-6.2.1-osx-x64.tar.gz
  - 264AF97471D42795F61DAAE52746FF08AB701892EC58B34669DD15B11FC1041E
- PowerShell-6.2.1-win-arm32.zip
  - 7BC3852DF425571C6C33AF96CA3418360C5EBD798E52E0471552260331A525AE
- PowerShell-6.2.1-win-arm64.zip
  - E0ABA4E85ADAA1325B4BCD3037C4C1916F6CD1FA1E439DEC134BCE46424D1BD2
- PowerShell-6.2.1-win-fxdependent.zip
  - 541008A6F968AE13727428F939089F3B0430E47C2772272F58621874002ADB2B
- PowerShell-6.2.1-win-x64.msi
  - C24406CA8F65440FA0381E417B05A16161227276EB3B77091FDB9D174B7F3144
- PowerShell-6.2.1-win-x64.zip
  - 6BCC0F80CA549A8ADB317B2EC1294F103C4BF75CC29EFA8AC03A27F9A860B1F4
- PowerShell-6.2.1-win-x86.msi
  - 0FE4EA7B87A948C4C42551AB68E22FCD12BFF593954DD4483CFFDF541C23A5E4
- PowerShell-6.2.1-win-x86.zip
  - F8A713A2614603267683F463B75CE9A81756107F0C927F198BBDD747ACB10AC0


-------------
| Downloads |
-------------

Filename                                      Updated              SizeMB
--------                                      -------              ------
powershell-6.2.1-1.rhel.7.x86_64.rpm          5/21/2019 5:08:52 PM     55
powershell-6.2.1-linux-alpine-x64.tar.gz      5/21/2019 5:09:23 PM     42
powershell-6.2.1-linux-arm32.tar.gz           5/21/2019 5:09:29 PM     42
powershell-6.2.1-linux-arm64.tar.gz           5/21/2019 5:09:42 PM     41
powershell-6.2.1-linux-x64-fxdependent.tar.gz 5/21/2019 5:09:49 PM     25
powershell-6.2.1-linux-x64.tar.gz             5/21/2019 5:09:47 PM     55
powershell-6.2.1-osx-x64.pkg                  5/21/2019 5:10:09 PM     54
powershell-6.2.1-osx-x64.tar.gz               5/21/2019 5:10:15 PM     54
PowerShell-6.2.1-win-arm32.zip                5/21/2019 5:10:27 PM     39
PowerShell-6.2.1-win-arm64.zip                5/21/2019 5:10:31 PM     39
PowerShell-6.2.1-win-fxdependent.zip          5/21/2019 5:10:35 PM     27
PowerShell-6.2.1-win-x64.msi                  5/21/2019 5:11:08 PM     55
PowerShell-6.2.1-win-x64.zip                  5/21/2019 5:11:12 PM     56
PowerShell-6.2.1-win-x86.msi                  5/21/2019 5:11:14 PM     50
PowerShell-6.2.1-win-x86.zip                  5/21/2019 5:11:18 PM     51
powershell_6.2.1-1.debian.9_amd64.deb         5/21/2019 5:08:31 PM     55
powershell_6.2.1-1.ubuntu.16.04_amd64.deb     5/21/2019 5:08:36 PM     55
powershell_6.2.1-1.ubuntu.18.04_amd64.deb     5/21/2019 5:08:39 PM     55

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
