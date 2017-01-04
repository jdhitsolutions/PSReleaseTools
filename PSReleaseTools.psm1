#requires -version 5.0

#region Main

Function Get-PSReleaseSummary {
<#
.Synopsis
Get information on latest PowerShell v6 alpha release
.Description
This command will query the PowerShell GitHub repository for the latest release information. 
.Example
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
- Add `ValidateNotNullOrEmpty` to approximately 15 parameters
- `New-TemporaryFile` and `New-Guid` rewritten in C#
- Enable client side PSRP on non-Windows platforms
- `Split-Path` now works with UNC roots
- Implicitly convert value assigned to XML property to string
- Updates to `Invoke-Command` parameters when using SSH remoting transport
- Fix `Invoke-WebRequest` with non-text responses on non-Windows platforms
- `Write-Progress` performance improvement from `alpha13` reverted because it introduced crash with a race condition

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


#>

[cmdletbinding()]
Param()

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    
    $uri = "https://api.github.com/repos/powershell/powershell/releases/latest"

} #begin

Process {
    Write-Verbose "[PROCESS] Getting latest release information from $uri"
    $data = Invoke-Restmethod -uri $uri -Method Get
    $dl = $data.assets | 
    Select @{Name="Filename";Expression={$_.name}},
    @{Name="Updated";Expression = {$_.updated_at -as [datetime]}},
    @{Name="SizeMB";Expression = {$_.size/1MB -as [int]}} | Out-String
    

    #create a here string for the details
    $out = @"

-----------------------------------------------------------
Release  : $($data.Tag_Name)
Published: $($data.Published_At -as [datetime]) 
-----------------------------------------------------------
$($data.body)

-------------
| Downloads |
-------------
$DL

"@

#write the string to the pipeline
$out

} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

}

Function Save-PSRelease {
<#
.Synopsis
Download the latest PowerShell v6 alpha releases
.Description
This command will download the latest PowerShell v6 alpha releases from the GitHub repository. You can download everything or limit the download to specific platforms.

If you select Windows files you can use the -Format dynamic parameter to download only MSI or ZIP files. Note that this will not work if you specify a combination of Windows and non-Windows platforms.

.Parameter Path
The destination folder for all downloads.

.Parameter All
Download all files to the destination path. This is the default behavior.

.Parameter Name
Select one or more platforms.

.Parameter Format
If you only select Windows-related names, you can also specify if you want to download MSI or ZIP files.

.Parameter Filename
The local filename for the download.

.Parameter URL
The URL for the download release.

.Parameter Size
The target size for the download release. If the actual download does not match this value you will get a warning.

.Example
PS C:\> Save-PSRelease F:\PS6 -all

.Example
PS C:\> Save-PSRelease -path F:\PS6 -name Win10 -format msi

.Example
PS C:\> Save-PSRelease -path F:\PS6 -name Ubuntu14,Ubuntu16,CentOS

.Example
PS C:\> Get-PSReleaseAsset -Family Ubuntu | Save-PSRelease -path D:\Temp 

Get the Ubuntu assets and save them to D:\Temp

#>

[cmdletbinding(DefaultParameterSetName="All",SupportsShouldProcess)]
Param(
[Parameter(Position = 0, HelpMessage="Where do you want to save the files?")]
[ValidateScript({
if (Test-Path $_) {
   $True
}
else {
   Throw "Cannot validate path $_"
}
})]    
[string]$Path = ".",
[Parameter(ParameterSetName="All")]
[switch]$All,
[Parameter(ParameterSetName="Name",Mandatory)]
[ValidateSet("Win7-x86","Win7-x64","Win81","Win10","MacOS","Ubuntu14","Ubuntu16","CentOS")]
[ValidateNotNullorEmpty()]
[string[]]$Name,
[Parameter(ParameterSetName="File",Mandatory,ValueFromPipelineByPropertyName)]
[string]$Filename,
[Parameter(ParameterSetName="File",Mandatory,ValueFromPipelineByPropertyName)]
[string]$Size,
[Parameter(ParameterSetName="File",Mandatory,ValueFromPipelineByPropertyName)]
[string]$URL,
[switch]$Passthru
)
DynamicParam {    if ($Name -match 'Win') {        #define a parameter attribute object        $attributes = New-Object System.Management.Automation.ParameterAttribute        $attributes.ValueFromPipelineByPropertyName= $True        $attributes.HelpMessage = "Select a download format"        $attributes.ParameterSetName = "Name"        $attributes.DontShow = $False        $validate = [System.Management.Automation.ValidateSetAttribute]::New("zip","msi")                #define a collection for attributes        $attributeCollection = New-Object -Type System.Collections.ObjectModel.Collection[System.Attribute]
        $attributeCollection.Add($attributes)        $attributeCollection.Add($validate)        #define the dynamic param        $dynParam1 = New-Object -Type System.Management.Automation.RuntimeDefinedParameter("Format", [string], $attributeCollection)                #create array of dynamic parameters        $paramDictionary = New-Object -Type System.Management.Automation.RuntimeDefinedParameterDictionary
        $paramDictionary.Add("Format", $dynParam1)
        #use the array
        return $paramDictionary         } #if  } #dynamic parameter


Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    #display PSBoundparameters formatted nicely for Verbose output  
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n" 
    
    $uri = "https://api.github.com/repos/powershell/powershell/releases/latest"

    #define an internal function to download the file
    Function DL {
    [cmdletbinding(SupportsShouldProcess)]
    Param([string]$Source,[string]$Destination,[int32]$Size,[switch]$Passthru)

        Write-Verbose "[DL] $Source to $Destination"
        
        if ($pscmdlet.ShouldProcess($Destination,"Downloading $source")) {
            Invoke-Webrequest -Uri $source -UseBasicParsing -DisableKeepAlive -OutFile $Destination
            $f = get-item -Path $Destination
            if ($f.Length -ne $size) {
                Write-Warning "$Destination may be incomplete"
            }

            if ($passthru) {
                $f
            }
        } #should process
    } #DL

} #begin

Process {
    Write-Verbose "[PROCESS] Using Parameter set $($PSCmdlet.ParameterSetName)"
    Write-Verbose "[PROCESS] Getting latest releases from $uri"
    Try {
        $data = Invoke-Restmethod -uri $uri -Method Get -ErrorAction Stop
    }
    Catch {
        Write-Warning $_.exception.message
        #bail out
        Return
    }

    if ($data.assets) {
      Switch ($PSCmdlet.ParameterSetName) {
      "All" {
        Write-Verbose "[PROCESS] Downloading all releases to $Path"
        foreach ($asset in $data.assets) {
            Write-Verbose "[PROCESS] ...$($Asset.name)"
            $target = Join-Path -Path $path -ChildPath $asset.Name
            DL -source $asset.browser_download_url -Destination $Target -Size $asset.size -passthru:$passthru
        } 
      }
      "Name" {
        #download individual release files
        Foreach ($item in $name) {

            Switch ($item) {
            "Win7-x86"  { $assets = $data.assets.where({$_.name -match 'Win7-x86'})}
            "Win7-x64" { $assets = $data.assets.where({$_.name -match 'Win7-x64'}) }
            "Win81" { $assets = $data.assets.where({$_.name -match 'Win81'})}
            "Win10" { $assets = $data.assets.where({$_.name -match 'Win10'}) }
            "MacOS" { $assets = $data.assets.where({$_.name -match 'pkg'}) }
            "Ubuntu14" { $assets = $data.assets.where({$_.name -match 'ubuntu.*14'})  }
            "Ubuntu16" { $assets = $data.assets.where({$_.name -match 'ubuntu.*16'}) }
            "CentOS" { $assets = $data.assets.where({$_.name -match 'centos'}) }
            } #Switch

            
            if (($assets.name -match "Win") -AND ($PSBoundParameters.ContainsKey("Format"))) {
                $type = $PSBoundParameters["format"]
                Write-Verbose "[PROCESS] Limiting download to $type files"
                $assets = $assets.Where({$_.name -match $type})
            }

            foreach ($asset in $Assets) {
                Write-Verbose "[PROCESS] ...$($asset.name)"
                $target = Join-Path -Path $path -ChildPath $asset.Name
                DL -source $asset.browser_download_url -Destination $Target -Size $asset.size -passthru:$passthru
            } #foreach asset
        } #foreach name
      }
      "File" {
                Write-Verbose "[PROCESS] ...$($filename)"
                $target = Join-Path -Path $path -ChildPath $fileName
                DL -source $url -Destination $Target -Size $size -passthru:$passthru
             }
      } #switch parameter set name
    } else {
        Write-Warning "No release information was found"
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end

}

Function Get-PSReleaseAsset {
[cmdletbinding()]
Param(
[ValidateSet("Windows","Ubuntu","MacOS","CentOS")]
[string[]]$Family
)

Begin {
    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"  
    
    $uri = "https://api.github.com/repos/powershell/powershell/releases/latest"

} #begin

Process {
    Write-Verbose "[PROCESS] Getting latest release information from $uri"
    Try {
        $data = Invoke-Restmethod -uri $uri -Method Get -ErrorAction Stop
        
        Write-Verbose "[PROCESS] Found $($data.assets.count) downloads"
        $assets = $data.assets | Select @{Name="FileName";Expression={$_.Name}},
        @{Name="Family";Expression={
         Switch -regex ($_.name) {
          "Win" {"Windows"}
          "Ubuntu" {"Ubuntu"}
          "pkg" {"MacOS"}
          "centos" {"CentOS"}
         }
        }},
        @{Name="Format";Expression={
          $_.name.split(".")[-1]
        }},
        Size,
        @{Name="Created";Expression={$_.Created_at -as [datetime]}},
        @{Name="Updated";Expression={$_.Updated_at -as [datetime]}},
        @{Name="URL";Expression={$_.browser_download_Url}},
        @{Name="DownloadCount";Expression={$_.download_count}} 

        if ($Family) {
            $assets.where({$_.family -match $($family -join "|")})
        }
        else {
            $assets
        }
    } #Trye
    catch {
        Throw $_
    }
} #process

End {
    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
} #end
}

#endregion

