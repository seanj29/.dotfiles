# Shows navigable menu of all options when hitting Tab

Set-PSReadlineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

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

#Adds dig as an Alias for Resolve-DnsName

New-Alias -Name dig -Value Resolve-DnsName

Set-PsFzfOption -EnableAliasFuzzyEdit -TabExpansion -EnableAliasFuzzyGitStatus 

$ENV:FZF_DEFAULT_OPTS=@"
--preview `"bat --color=always --style=auto --line-range=:500 {}`"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"@

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin.omp.json" | Invoke-Expression

Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
