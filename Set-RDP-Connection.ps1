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
#	Enable/Disable Remote Desktop Connection and set Allow/Block firewall rule.
# 
# Instructions: 
#	Copy/Paste the line below into PowerShell for default settings (Toggle Enable/Disable)
#		iex ((New-Object System.Net.WebClient).DownloadString(''))
#	or Download script:
#		Running from a Run or cmd.exe prompt: powershell -ExecutionPolicy Bypass -File ".\Set-RDP-Connection.ps1"
#	OR to change the default arguments
#		$installScript=((New-Object System.Net.WebClient).DownloadString(''))
#		$ScriptBlock = [System.Management.Automation.ScriptBlock]::Create($installScript)
#		$ScriptArgs=@($False,$True")
#		Invoke-Command $ScriptBlock -ArgumentList $ScriptArgs
#	or Download script:
#		Running from a PowerShell prompt: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
#										.\Install-NetskopeClient-IDP.ps1 -Toggle $False -Enable $False
#
#
# Tested with: Microsoft Windows [Version 10.0.19042.804], PowerShell [Version 5.1.19041.610]
# Arguments: -Toggle (True/False, Default True) -Enable (True/False, Default False)
# Output: Hostname, IP Address and Status
#
# Notes:  
# --------------------------------------------------------------------------------------------

Param (
	[bool]$Toggle=$True,
	[bool]$Enable=$False
)

function isAdmin {
	$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
	return $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Enable-RDP {
	Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 0
	Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

function Disable-RDP {
	Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 1
	Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
}

function Get-RDP-Status {
	$Status=(Get-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections).fDenyTSConnections
	Switch ($Status) {
		0 {return $True}
		1 {return $False}
	}
}

function Write-ConnectionInfo {
	$IpAddress=(Get-NetIPConfiguration | Where-Object {$_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected"}).IPv4Address.IPAddress

	Switch (Get-RDP-Status) {
		True {
			Write-Host "Remote Connection to" $(hostname) "on $IpAddress is: Enabled" -ForegroundColor Green
		}
		False {
			Write-Host "Remote Connection to" $(hostname) "on $IpAddress is: Disabled" -ForegroundColor Yellow
		}
	}
}



##Main
If (isAdmin) {
	If ($Toggle) {
		Switch (Get-RDP-Status) {
			True {Disable-RDP}
			False {Enable-RDP}
		}
		Write-ConnectionInfo 
	}
	Else {
		If ($Enable) {Enable-RDP}
		Else {Disable-RDP}
		Write-ConnectionInfo 
	}
}
Else {
	Write-Error -Message "
ERROR: Administrator permissions are required to make requested change." -Category PermissionDenied
}
##End Main

