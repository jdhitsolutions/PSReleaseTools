---
external help file: PSReleaseTools-help.xml
online version: 
schema: 2.0.0
---

# Get-PSReleaseSummary

## SYNOPSIS
Get information on latest PowerShell v6 alpha release

## SYNTAX

```
Get-PSReleaseSummary [<CommonParameters>]
```

## DESCRIPTION
This command will query the PowerShell GitHub repository for the latest release information using the GitHub APIs. You do not need to have a GitHub account in order to use this command.

The output is a text report.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Get-PSReleaseSummary


-----------------------------------------------------------
Release  : v6.0.0-alpha.14
Published: 12/15/2016 14:51:53 
-----------------------------------------------------------
Here are the major changes:

- Moved to .NET Core 1.1
- Add Windows performance counter cmdlets to PowerShell Core
- Fix try/catch to choose the more specific exception handler
- Fix issue reloading modules that define PowerShell classes
- Add \`ValidateNotNullOrEmpty\` to approximately 15 parameters
- \`New-TemporaryFile\` and \`New-Guid\` rewritten in C#
- Enable client side PSRP on non-Windows platforms
- \`Split-Path\` now works with UNC roots
- Implicitly convert value assigned to XML property to string
- Updates to \`Invoke-Command\` parameters when using SSH remoting transport
- Fix \`Invoke-WebRequest\` with non-text responses on non-Windows platforms
- \`Write-Progress\` performance improvement from \`alpha13\` reverted because it introduced crash with a race condition

These are the SHA 256 hashes:

- powershell-6.0.0-alpha.14.pkg
  - 8fd7abc4ec1a2e4a28543b90a6ee60cd437d4b366b544c39b341a05276eb8ccf
- powershell-6.0.0_alpha.14-1.el7.centos.x86_64.rpm
  - 88e01ff76d89b8ed16468bbc8ef8fa51ecb4bb341adb878eec139319411e2da0
- powershell_6.0.0-alpha.14-1ubuntu1.14.04.1_amd64.deb
  - 402c3b6b51210b7e7700260cd5ea37f75ef56b97e4102a7ba62d431cb9879483
- powershell_6.0.0-alpha.14-1ubuntu1.16.04.1_amd64.deb
  - b5a177fda872d5af05b029b7b1071ab37b192323170e10d853ac250e69ff95da
- powershell-6.0.0-alpha.14-win10-x64.zip
  - 3F5FD873B6E3062D9741B019BC645E6F20999BE66B2FDAA4374495FEBEDD0E03
- powershell-6.0.0-alpha.14-win7-x64.zip
  - 689E59C8A97A7F6F136104A56BE397D9456D46069AA2C1121BBDA421C14852F8
- powershell-6.0.0-alpha.14-win7-x86.zip
  - DCB821299D8269989D8DCEAB5A45B4E7F959257CA5E640373C0675758C734505
- powershell-6.0.0-alpha.14-win81-x64.zip
  - F5410AA6BAC63C53B5DE5882591F11CED2772DEA5C4AD728C9F9BFDC1A5B4142
- PowerShell_6.0.0.14-alpha.14-win10-x64.msi
  - 503F3AD52223699765895D3E9615FBD7988194693BCB725BE90C9EF0CD594447
- PowerShell_6.0.0.14-alpha.14-win7-x64.msi
  - 19A94B7533A5A2292E5E8BFFAB0143AEF31867A531447EAADCAAE714121E541A
- PowerShell_6.0.0.14-alpha.14-win7-x86.msi
  - 3763A0D4E5859B16495CDA68279614E70A36FF51EA82148F302A54AC0D62E116
- PowerShell_6.0.0.14-alpha.14-win81-x64.msi
  - 9BAF5D38719C28AE98A76683647AB9161A3A151A399781C050D43942D37C096C


-------------
| Downloads |
-------------

Filename                                             Updated               SizeMB
--------                                             -------               ------
powershell-6.0.0-alpha.14-win10-x64.zip              12/14/2016 8:48:15 PM     39
powershell-6.0.0-alpha.14-win7-x64.zip               12/14/2016 8:48:09 PM     41
powershell-6.0.0-alpha.14-win7-x86.zip               12/14/2016 8:48:12 PM     37
powershell-6.0.0-alpha.14-win81-x64.zip              12/14/2016 8:48:16 PM     39
powershell-6.0.0-alpha.14.pkg                        12/14/2016 7:24:17 PM     39
powershell-6.0.0_alpha.14-1.el7.centos.x86_64.rpm    12/14/2016 9:34:43 PM     39
powershell_6.0.0-alpha.14-1ubuntu1.14.04.1_amd64.deb 12/14/2016 9:07:21 PM     40
powershell_6.0.0-alpha.14-1ubuntu1.16.04.1_amd64.deb 12/15/2016 3:26:20 AM     40
PowerShell_6.0.0.14-alpha.14-win10-x64.msi           12/14/2016 8:48:21 PM     40
PowerShell_6.0.0.14-alpha.14-win7-x64.msi            12/14/2016 8:48:26 PM     41
PowerShell_6.0.0.14-alpha.14-win7-x86.msi            12/14/2016 8:48:25 PM     37
PowerShell_6.0.0.14-alpha.14-win81-x64.msi           12/14/2016 8:48:23 PM     40
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### system.string

## NOTES
Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS
[Get-PSReleaseCurrent]()

[Invoke-Restmethod]()

