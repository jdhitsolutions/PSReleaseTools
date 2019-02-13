#load functions
. $PSScriptRoot\functions.ps1

#configure TLS settings for GitHub
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12