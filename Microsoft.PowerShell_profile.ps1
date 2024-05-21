# Shows navigable menu of all options when hitting Tab

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

#Adds dig as an Alias for Resolve-DnsName

New-Alias -Name dig -Value Resolve-DnsName

function Run-League {
<#

.SYNOPSIS
	Starts League of Legends

.PARAMETER DontExit
	if present, will close the shell after league has been started.
.INPUTS 
	Bool

#>
	[CmdletBinding()] #<<-- This turns a regular function into an advanced function
	param	(
		[Alias("e")]
		[ValidateNotNullOrEmpty()]
		[switch]$DontExit 
	)
	start "C:\Riot Games\Riot Client\RiotClientServices.exe" -ArgumentList "--launch-product=league_of_legends", "--launch-patchline=live"
	if (!$DontExit)
		{ exit}	
}

# Adds lol as an Alias for new "Run-League" Function

New-Alias -Name lol -Value Run-League

New-Alias -Name vim -Value nvim

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/cinnamon.omp.json" | Invoke-Expression

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
