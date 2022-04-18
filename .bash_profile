# .bash_profile
# This prevents rendering issues when it the prompt is the first line in Windows Terminal
echo "Loading Rob's bash profile"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:$HOME/.local/bin
export KUBECONFIG=$HOME/.kube/config

export SSLKEYLOGFILE=~/.ssl-key.log

export GITHUB_TOKEN=$(~/.local/bin/github-token)

export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";

if [[ -n $PS1 ]]; then
  # This should only run for interactive shells
  if [ -f "$USERPROFILE/scoop/apps/ssh-agent-wsl/2.5/ssh-agent-wsl" ]
  then
    eval $($USERPROFILE/scoop/apps/ssh-agent-wsl/2.5/ssh-agent-wsl -r)
  fi

  eval "$(oh-my-posh --init --shell bash --config ~/.config/oh-my-posh/my-posh.json)"
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git
complete -F __start_kubectl k
#complete -C aws_completer aws


