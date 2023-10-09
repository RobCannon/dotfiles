# Jump out if run from a script
if ([Environment]::GetCommandLineArgs().Length -gt 1) {
  return
}

oh-my-posh init pwsh --config $HOME/.config/oh-my-posh/my-posh.json -s | Invoke-Expression

Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -EditMode Emacs
