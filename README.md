# PSReleaseTools

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSReleaseTools.png?style=for-the-badge&logo=powershell&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSReleaseTools/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSReleaseTools.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSReleaseTools/)

![PSAvatar](images/Powershell_avatar.ico)

This PowerShell module provides a set of commands for working with the latest releases from the [PowerShell GitHub repository](https://github.com/PowerShell/PowerShell). The module contains commands to get summary information about the most current PowerShell version as well as functions to download some or all of the release files.

These commands utilize the GitHub API, which is subject to rate limits. It is recommended that you save results of commands like `Get-PSReleaseAsset` to a variable. If you encounter an error message for `Invoke-RestMethod` like "Server Error" then you have likely exceeded the API limit. You will need to wait a bit and try again.

## Cross-Platform

This module should work cross-platform on both Windows PowerShell and PowerShell 7.x.

## Notes

The module currently has 6 commands:

- [Get-PSReleaseSummary](Docs/Get-PSReleaseSummary.md)
- [Get-PSReleaseCurrent](Docs/Get-PSReleaseCurrent.md)
- [Get-PSReleaseAsset](Docs/Get-PSReleaseAsset.md)
- [Save-PSReleaseAsset](Docs/Save-PSReleaseAsset.md)
- [Install-PowerShell](Docs/Install-PowerShell.md)
- [Install-PSPreview](Docs/Install-PSPreview.md)

All of the functions take advantage of the [GitHub API](https://developer.github.com/v3/ "learn more about the API") which in combination with either [Invoke-RestMethod](http://go.microsoft.com/fwlink/?LinkID=217034) or [Invoke-WebRequest](http://go.microsoft.com/fwlink/?LinkID=217035), allow you to programmatically interact with GitHub.

The first command, `Get-PSReleaseSummary`, queries the PowerShell repository release page and constructs a text summary. You can also have the command write the report text as markdown.

![get-psreleasesummary.png](/images/get-psreleasesummary.png)

I put the release name and date right at the top so you can quickly check if you need to download something new. In GitHub, each release file is referred to as an *asset*. The `Get-PSReleaseAsset` command will query GitHub about each file and write a custom object to the pipeline.

```powershell
PS C:\> Get-PSReleaseAsset

FileName      : PowerShell-7.0.0-win-x64.msi
Family        : Windows
Format        : msi
SizeMB        : 87
Hash          : 876F4A64012A1FB024DCCEA696DB00C5CD1A37C8DC9DFA2431C58CDF9F82950B
Created       : 3/3/2020 10:55:37 PM
Updated       : 3/3/2020 10:55:39 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/PowerShell-7.0.0-win-x64.msi
DownloadCount : 46253
...
```

By default it will display assets for all platforms, but I added a `-Family` parameter if you want to limit yourself to a single entry like MacOS.

```powershell
PS C:\> Get-PSReleaseAsset -Family MacOS

FileName      : powershell-7.0.0-osx-x64.pkg
Family        : MacOS
Format        : pkg
SizeMB        : 55
Hash          : 80F75903E9F33B407A7F15C087A2C2B12A93DC153469E091D18048D01080085E
Created       : 3/4/2020 6:13:06 PM
Updated       : 3/4/2020 6:13:08 PM
URL           : https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-7.0.0-osx-x64.pkg
DownloadCount : 7995
...
```

Of course, you will want to download these files, which is the job of the last command. By default, `Get-PSReleaserAsset` will save all files to the current directory unless you specify a different path. You can limit the selection to a specific platform with the `-Family` parameter, which uses a validation set.

```powershell
PS C:\> Save-PSReleaseAsset -Family Ubuntu -Path D:\PS\ -WhatIf
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb" on target "D:\PS\powershell-lts_7.0.0-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb" on target "D:\PS\powershell-lts_7.0.0-1.ubuntu.18.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell_7.0.0-1.ubuntu.16.04_amd64.deb" on target "D:\PS\powershell_7.0.0-1.ubuntu.16.04_amd64.deb".
What if: Performing the operation "Downloading https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell_7.0.0-1.ubuntu.18.04_amd64.deb" on target "D:\PS\powershell_7.0.0-1.ubuntu.18.04_amd64.deb".
```

You can select multiple names. If you choose Windows, there is a dynamic parameter called `-Format` where you can select ZIP or MSI. `Save-PSReleaseAsset` supports `-WhatIf`.

I also realized you might run `Get-PSReleaseAsset`, perhaps to examine details before downloading. Since you have those objects, why not be able to pipe them to the save command?

```powershell
PS C:\> Get-PSReleaseAsset -Family Debian -LTS | Save-PSReleaseAsset -Path D:\PS\ -Passthru


    Directory: D:\PS

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a---           3/11/2020 12:44 PM       61101934 powershell-lts_7.0.0-1.debian.10_amd64.deb
-a---           3/11/2020 12:44 PM       61101718 powershell-lts_7.0.0-1.debian.11_amd64.deb
-a---           3/11/2020 12:44 PM       61100218 powershell-lts_7.0.0-1.debian.9_amd64.deb
```

The current version of this module uses regular expression named captures to pull out the file name and corresponding SHA256 hashes. The save command then calls `Get-FileHash` to get the current file hash and compares them.

## Preview Builds

Beginning with v0.8.0 of this module, command functions have a `-Preview` parameter, which will get the latest preview build. Otherwise, the commands will use the latest stable release.

## Installing a Build

On Windows, it is pretty easy to install a new build with a one-line command like this:

```powershell
 Get-PSReleaseAsset -Family Windows -Only64Bit -Format msi | Save-PSReleaseAsset -Path d:\temp -Passthru | Invoke-Item
```

Or you can use one of two newer functions to install the latest 64bit release. You can specify the interaction level.

 [Install-PSPreview](/Docs/Install-PSPreview.md) will download the latest 64-bit _*preview*_ build for Windows and kick off the installation.

 ```powershell
Install-PSPreview -Mode Passive
 ```

 [Install-PowerShell](/Docs/Install-PowerShell.md) will do the same thing but for the latest stable release.

```powershell
PS C:\> Install-PowerShell -Mode Quiet -EnableRemoting -EnableContextMenu
```

The functionality of these commands could have been combined, but I decided to leave this as separate commands, so there is no confusion about what you are installing.

Non-Windows platforms have existing command-line installation tools that don't need to be replaced. Plus, I don't have the resources to develop and test installation techniques for all of the non-Windows options. That is why install-related commands in this module are limited to Windows.

## PowerShell Issues

A new set of commands have been introduced in v1.8.0. These commands are intended to make it easier for you to look at [issues from the PowerShell GitHub repository](https://github.com/PowerShell/PowerShell/issues). The idea is that you can take a peek at open issues from your PowerShell session and then open the issue in your browser to learn more or contribute.

### Get-PSIssue

`Get-PSIssue` is intended to get open PowerShell issues from Github. With no parameters, you can get the 25 most recent issues. Use the `-Count` parameter to increase that value using one of the possible values. The actual number of issues returned may vary depending on the rest of your command and how GitHub pages results.

You can also fine-tune your search to get issues that have been updated since a given date. Finally, you can also limit your search to issues tagged with a specific label.

![Get-PSIssue](images/get-psissue.png)

The function write a custom object to the pipeline and includes a default formatted view. If you are running PowerShell 7, the issue body will be rendered as formatted markdown.

Here is another way you might use the command.

![Get-PSIssue Summary](images/get-psissue-summary.png)

__Note:__ The issue commands use the GitHub API and anonymous connections. The API has rate limits. If you run one of these commands excessively in a short period of time, you might see an error about exceeding the rate limit. If this happens, all you can do is wait an hour and try again. You can read more about GitHub rate limiting [here](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#rate-limiting).

### Get-PSIssueLabel

To make it easier to search for issues based on labels, you can use `Get-PSIssueLabel` to list available labels from the PowerShell repository. However, you most likely won't need to run this command often. When you import the `PSReleaseTools` module, it will create a global variable called `$PSIssueLabel`.

```powershell
PS C:\> $PSIssueLabel

name                         description
----                         -----------
.NET                         Pull requests that update .net code
Area-Build
Area-Cmdlets
Area-Cmdlets-Archive
Area-Cmdlets-Core
Area-Cmdlets-Management
Area-Cmdlets-Utility
Area-Console
Area-DSC
...
```

This variable is used as part of an argument completer for the `Labels` parameter on `Get-PSIssue`.

### Open-PSIssue

Finally, you may want to respond to an issue. If you run `Open-PSIssue` without any parameters, it should open the Issues section of the PowerShell repository in your browser. Or you can pipe an issue object to the command, as long as you include the `Url` property.

```powershell
Get-PSIssue | Select-Object Updated,Labels,Title,Url | Out-GridView -PassThru | Open-PSIssue
```

There are no plans to add a command to open a new issue from a PowerShell session. You can use `Open-PSIssue` to get to GitHub and then use your browser to submit a new issue.

## PowerShell Gallery

You can find this module in the PowerShell Gallery. You should be able to run these commands to find and install it.

```powershell
Install-Module PSReleaseTools
```

On PowerShell you might need to run:

```powershell
Install-Module PSReleaseTools [-Scope CurrentUser]
```

## Support

If you have suggestions or encounter problems, please post an issue in this GitHub repository. If you find this project useful, or any of my work, please consider a small support donation.[<kbd>:heart:Sponsor</kbd>](https://paypal.me/jdhitsolutions?locale.x=en_US)

Last Updated *2020-08-25 11:19:04Z*
