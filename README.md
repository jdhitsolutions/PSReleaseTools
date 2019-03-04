# PSReleaseTools

[![PSGallery Version](https://img.shields.io/powershellgallery/v/PSReleaseTools.png?style=for-the-badge&logo=powershell&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/PSReleaseTools/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/PSReleaseTools.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/PSReleaseTools/)


This PowerShell module provides a set of commands for working with the latest releases from the PowerShell [GitHub repository](https://github.com/PowerShell/PowerShell). The module contains commands to get summary information about the most current release as well as commands to download some or all of the release files.

These commands utilize the GitHub API which is subject to rate limits. It is recommended that you save results of commands like `Get-PSReleaseAsset` to a variable. If you encounter an error message for `Invoke-RestMethod` like "Server Error" then you have likely exceeded the API limit. You will need to wait a bit and try again.

## Cross-Platform

This module should work cross-platform on both Windows PowerShell and PowerShell Core.

## Notes

The module currently has 4 commands:

- [Get-PSReleaseSummary](/Docs/Get-PSReleaseSummary.md)
- [Get-PSReleaseCurrent](/Docs/Get-PSReleaseCurrent.md)
- [Get-PSReleaseAsset](/Docs/Get-PSReleaseAsset.md)
- [Save-PSReleaseAsset](/Docs/Save-PSReleaseAsset.md)

All of the functions take advantage of the [GitHub API](https://developer.github.com/v3/ "learn more about the API") which in combination with either <a title="Read online help for this command" href="http://go.microsoft.com/fwlink/?LinkID=217034" target="_blank">Invoke-RestMethod</a> or <a title="Read online help for this command" href="http://go.microsoft.com/fwlink/?LinkID=217035" target="_blank">Invoke-WebRequest</a>, allow you to programmatically interact with GitHub.

The first command, `Get-PSReleaseSummary` queries the PowerShell repository release page and constructs a text summary. You can also have the command write the report text as markdown.

![get-psreleasesummary.png](/images/get-psreleasesummary.png)

I put the release name and date right at the top so you can quickly check if you need to download something new. In GitHub, each release file is referred to as an <em>asset</em>. The `Get-PSReleaseAsset` command will query GitHub about each file and write a custom object to the pipeline.

![get-psreleaseasset.png](/images/get-psreleaseasset.png)

By default it will display assets for all platforms, but I added a `-Family` parameter if you want to limit yourself to a single entry like MacOS.

![get-psreleaseasset-macos.png](/images/get-psreleaseasset-macos.png)

Of course, you will want to download these files which is the job of the last command. By default the command will save all files to the current directory unless you specify a different path. You can limit the selection to a specific platform via the `-Family` parameter which uses a validation set.

![save-psreleaseasset-ubunutpng](/images/save-psreleaseasset-ubuntu.png)

You can select multiple names. If you select only Window, then there is a dynamic parameter called `-Format` where you can select ZIP or MSI. And the command supports `-WhatIf`.

I also realized you might run `Get-PSReleaseAsset`, perhaps to examine details before downloading. Since you have those objects, why not be able to pipe them to the save command?

![pipelinesave.png](/images/pipelinesave.png)

The current version of this module uses regular expression named captures to pull out the file name and corresponding SHA256 hashes. The save command then calls `Get-FileHash` to get the current hash and compares them.

## Preview Builds

Starting in v0.8.0, command modules have a `-Preview` parameter which will get the latest preview build. Otherwise, the commands will use the latest stable release.

## PowerShell Gallery

This module has been published to the PowerShell Gallery. You should be able to run these commands to find and install it.

```powershell
Install-Module PSReleaseTools
```

On PowerShell Core you might need to run:

```powershell
Install-Module PSReleaseTools -scope currentuser
```

## Roadmap

I have a few other ideas for commands I might add to this module. If you have suggestions or encounter problems, please post an issue in the GitHub repository.

*Last updated 13 February 2019*
