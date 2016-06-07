Set-ExecutionPolicy RemoteSigned

Import-Module AWSPowerShell

$host.UI.RawUI.WindowTitle = "AWS PS"

# Welcome message
"You are now entering PowerShell : " + $env:Username

. "$PSScriptRoot\_Revoke-ALL-Access.ps1"
Revoke-ALL-Access "sg-1f863c7b"

. "$PSScriptRoot\_Grant-SSH-Access.ps1"
Grant-SSH-Access "sg-1f863c7b"