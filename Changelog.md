# Change Log for PSReleaseTools

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
