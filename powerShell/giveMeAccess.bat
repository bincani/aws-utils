@echo off

set SCRIPT=C:\projects\aws\aws-utils\powerShell\Microsoft.PowerShell_profile.ps1

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File ""%SCRIPT%""' -Verb RunAs}"