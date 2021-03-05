#powershell.exe


# Written by: Aaron Wurthmann
#
# You the executor, runner, user accept all liability.
# This code comes with ABSOLUTELY NO WARRANTY.
# You may redistribute copies of the code under the terms of the GPL v3.
#
# --------------------------------------------------------------------------------------------
# Name: Set-RDP-Connection.ps1
# Version: 2021.03.05.123501
# Description: 
# 
# Instructions: 
#
# Tested with: Microsoft Windows [Version 10.0.19042.804], PowerShell [Version 5.1.19041.610]
# Arguments: -Enable (True/False)
# Output: None
#
# Notes:  
# --------------------------------------------------------------------------------------------




Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

(Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress
hostname

#Disable-RDP.ps1
#Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 1
#Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
