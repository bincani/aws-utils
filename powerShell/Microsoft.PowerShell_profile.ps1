# use for testing
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

Import-Module AWSPowerShell

. "$PSScriptRoot\_Revoke-ALL-Access.ps1"
. "$PSScriptRoot\_Grant-SSH-Access.ps1"

# config aws
[string]$awsRegion = "ap-southeast-2"
Set-DefaultAWSRegion -Region $awsRegion

$host.UI.RawUI.WindowTitle = "AWS PS"

# Welcome message
"You are now entering PowerShell : " + $env:Username

[string]$awsProfile = "binca-prod"
[string]$awsSecurityGroup = "sg-86d348e3"
Set-AWSCredential -ProfileName $awsProfile

Revoke-ALL-Access $awsSecurityGroup
Grant-SSH-Access $awsSecurityGroup 22
Grant-SSH-Access $awsSecurityGroup 80
Grant-SSH-Access $awsSecurityGroup 443
Grant-SSH-Access $awsSecurityGroup 33402

[string]$awsProfile = "binca-stage"
[string]$awsSecurityGroup = "sg-4cfb6329"
Set-AWSCredential -ProfileName $awsProfile

Revoke-ALL-Access $awsSecurityGroup
Grant-SSH-Access $awsSecurityGroup 22
Grant-SSH-Access $awsSecurityGroup 80
Grant-SSH-Access $awsSecurityGroup 443
Grant-SSH-Access $awsSecurityGroup 33402

# pause script (use for testing)
#Read-Host -Prompt "Press Enter to continue"
