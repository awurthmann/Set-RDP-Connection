# Set-RDP-Connection
Enable/Disable Remote Desktop Connection and set Allow/Block firewall rule.

## Legal:
	You the executor, runner, user accept all liability.
	This code comes with ABSOLUTELY NO WARRANTY.
	You may redistribute copies of the code under the terms of the GPL v3.
	
## Instructions:
Copy/Paste the line below into PowerShell for default settings (Toggle Enable/Disable)
```powershell
	iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/awurthmann/Set-RDP-Connection/main/Set-RDP-Connection.ps1'))
```
or Download script:
	Running from a Run or cmd.exe prompt:
	```powershell
	powershell -ExecutionPolicy Bypass -File ".\Set-RDP-Connection.ps1"
	```
	OR to change the default arguments
	```powershell
		$installScript=((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/awurthmann/Set-RDP-Connection/main/Set-RDP-Connection.ps1'))
		$ScriptBlock = [System.Management.Automation.ScriptBlock]::Create($installScript)
		$ScriptArgs=@($False,$True)
		Invoke-Command $ScriptBlock -ArgumentList $ScriptArgs
	```
	or Download script:
		Running from a PowerShell prompt: 
		```powershell
		Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
		.\Install-NetskopeClient-IDP.ps1 -Toggle $False -Enable $False
		```
