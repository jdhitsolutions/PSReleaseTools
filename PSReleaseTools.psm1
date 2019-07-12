#load functions
. $PSScriptRoot\functions\private.ps1
. $PSScriptRoot\functions\public.ps1

#configure TLS settings for GitHub
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12