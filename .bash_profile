# .bash_profile
echo "Executing my bash profile"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.dotnet:$HOME/.dotnet/tools
KUBECONFIG=$HOME/.kube/config

export PATH
export KUBECONFIG