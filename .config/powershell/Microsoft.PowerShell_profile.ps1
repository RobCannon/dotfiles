# Jump out if run from a script
if ([Environment]::GetCommandLineArgs().Length -gt 1) {
  return
}

oh-my-posh --init --shell pwsh --config $HOME/.config/oh-my-posh/my-posh-pwsh.json | Invoke-Expression

function invoke-terraforminit { & terraform init -upgrade=true }
function invoke-terraformvalidate { & terraform validate }
function invoke-terraformplan { & terraform plan }
function invoke-terraformapply { & terraform apply --auto-approve }

set-alias tfi invoke-terraforminit
set-alias tfv invoke-terraformvalidate
set-alias tfp invoke-terraformplan
set-alias tfa invoke-terraformapply


# This is an example profile for PSReadLine.
#
# This is roughly what I use so there is some emphasis on emacs bindings,
# but most of these bindings make sense in Windows mode as well.

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# Searching for commands with up/down arrow is really handy.  The
# option "moves to end" is useful if you want the cursor at the end
# of the line while cycling through history like it does w/o searching,
# without that option, the cursor will remain at the position it was
# when you used up arrow, which can be useful if you forget the exact
# string you started the search on.
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
