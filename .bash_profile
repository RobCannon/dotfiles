# .bash_profile
echo "Executing my bash profile"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/.local/bin
export KUBECONFIG=$HOME/.kube/config