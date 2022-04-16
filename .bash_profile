# .bash_profile
echo "Executing my bash profile"

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
