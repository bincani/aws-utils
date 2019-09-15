# Prerequisites

1. https://aws.amazon.com/powershell/
    Downloads -> AWS Tools for Windows Installer

2. AWS Profile (see AWS Managing Profiles) with the correct profile (see aws-iam-policy.json)

# AWS Managing Profiles (via PowerShell)

Get-AWSRegion
Set-AWSCredential -AccessKey KEY -SecretKey PASS -StoreAs ProfileName
Get-AWSCredential -ListProfileDetail
Remove-AWSCredentialProfile -ProfileName ProfileName

# Create Shortcut to Run a PS1 (Win10)

powershell.exe -File E:\projects\misc\aws-utils\powerShell\Microsoft.PowerShell_profile.ps1
OR
powershell.exe -ExecutionPolicy Bypass -File E:\projects\misc\aws-utils\powerShell\Microsoft.PowerShell_profile.ps1
OR
a bat file
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""C:\projects\aws\aws-utils\powerShell\Microsoft.PowerShell_profile.ps1""' -Verb RunAs}"

# References
https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_ec2_securitygroups-vpc.html
https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html#managing-profiles
https://winaero.com/blog/create-shortcut-ps1-powershell-file-windows-10/
https://blog.danskingdom.com/allow-others-to-run-your-powershell-scripts-from-a-batch-file-they-will-love-you-for-it/
