# Change Log for PSReleaseTools

## v1.6.2

+ Updated warning message for `Install-PSPreview` with a clearer error message and suppressed error output. (Issue #21)
+ Updated the same for `Install-PowerShell`
+ Added a dynamic parameter called `-Online` to `Get-PSReleaseSummary` to open the GitHub release page in the default web browser.

## v1.6.1

+ Updated `Install-PSPreview` and `Install-PowerShell` to fix errors when using `-WhatIf`. (Issue #19)

## v1.6.0

+ Updated install functions to allow options for enabling remoting and Explorer context menus.
+ Updated documentation and help to reference PowerShell 7 and not PowerShell Core. (Issue #18)
+ Fixed bug in  Get-PSReleaseAsset` that failed to label a family for CentOS assets.
+ Updated commands to recognize the LTS assets.
+ Added `-LTS` parameter to `Get-PSReleaseAsset` to limit results to LTS-related files.
+ Renamed `Install-PSCore` to `Install-PowerShell`. Kept `Install-PSCore` as a command alias.
+ Updated `README.md`

## v1.5.0

+ Fixed bug installing preview on Windows PowerShell (Issue #16)
+ Fixed regex in `Get-PSReleaseAsset` to get all preview files (Issue #17)
+ Help updates to reflect PowerShell 7
+ License update
+ Updated `README.md`

## v1.4.1

+ Merged PR from @weebsnore to fix a bug when installing from a path with an apostrophe.
+ Minor help corrections

## v1.4.0

+ Changed online help links to `bit.ly` links
+ Added `msix` as an asset format
+ Updated `Get-PSReleaseAsset` to be stricter on format matching
+ Fixed bug with `Install-PSPreview` erroring on path (Issue #15)

## v1.3.2

+ Fixed another new bug with installation commands
+ Standardized verbose output to include a timestamp

## v1.3.1

+ Fixed installation issue with spaces in filenames (Issue #13)

## v1.3.0

+ Added online help links
+ Updated `README.md`

## v1.2.0

+ Added `Install-PSCore` command for Windows only (Issue #11)
+ Reorganized module layout
+ Updated verbose messages in private functions
+ Updated help
+ Added YAML versions of help documents
+ Updated `README.md`

## v1.1.0

+ Updated asset cmdlets to include new families (Issue #10)
+ Updated `Get-PSReleaseAsset` to allow specifying a format (Issue #9)
+ Updated `Save-PSReleaseAsset` and made `Format` a formal parameter
+ Updated `README.md`
+ Added `Install-PSPreview` to install the latest 64bit PowerShell Preview build for Windows.
+ Help updates

## v1.0.0

+ There have been enough updates that this seems like a good time.

## v0.8.1

+ Raised minimum PowerShell version to 5.1 to support CompatiblePSEditions

## v0.8.0

+ Modified commands to default to most recent stable build
+ Modified commands to get preview build and related assets (Issue #7)
+ Updated the manifest to reflect support for Desktop and Core editions
+ Added an alias of `x64` to the `Only64bit` parameter in `Get-PSReleaseAsset`
+ Reorganized module file layout
+ Help updates
+ Updated `README.md`

## v0.7.0

+ Added switch parameter on `Get-PSReleaseAsset` to only get x64 versions
+ Added an option to display current release summary as a markdown document
+ help updates
+ file cleanup for the PowerShell Gallery
+ fixed license

## v0.6.1

+ Added code to fix TLS issue with GitHub (Issue #5)

## v0.6.0

+ Updated to support GA for PowerShell 6 (Issue #4)
+ Changed Save-PSReleaseAsset Name parameter to Family
+ Modified Family values
+ Updated documentation
+ Updated screen shots and README.md

## v0.5.1.0

+ added asset support for SUSE and AppImage
+ minor changes to help documentation
+ updated Pester tests

## v0.5.0.0

+ modified download to pull file hashes from summary
+ and compare them to downloaded files. This is BREAKING CHANGE.
+ Updated Get-PSReleaseAsset to include the SHA256 hash
+ Updated help
+ updated README

## v0.4.0.2

+ fixed semantic versioning in the manifest

## v0.4.0.1

+ Changed to semantic versioning

## v0.4.0

+ updated author name in manifest
+ Added Get-PSReleaseCurrent
+ Updated help

## v0.3.0

+ Renamed Save-PSRelease to Save-PSReleaseAsset for consistency (Issue #1)
+ Updated documentation
+ Updated manifest
+ Published to PSGallery

## v0.2.0

+ Added external documentation

## v0.1.0

+ Initial module release
+ updated license copyright
+ updated README
