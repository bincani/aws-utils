# use for testing
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

# confi aws
[string]$awsProfile = "profile"
[string]$awsRegion = "region"
[string]$awsSecurityGroup = "security-group"

Import-Module AWSPowerShell

Set-AWSCredential -ProfileName $awsProfile
Set-DefaultAWSRegion -Region $awsRegion

$host.UI.RawUI.WindowTitle = "AWS PS"

# Welcome message
"You are now entering PowerShell : " + $env:Username

. "$PSScriptRoot\_Revoke-ALL-Access.ps1"
Revoke-ALL-Access $awsSecurityGroup

. "$PSScriptRoot\_Grant-SSH-Access.ps1"
Grant-SSH-Access $awsSecurityGroup

# pause script (use for testing)
#Read-Host -Prompt "Press Enter to continue"
