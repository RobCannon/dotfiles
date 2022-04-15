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

