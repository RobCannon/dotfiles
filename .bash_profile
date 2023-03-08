# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# HomeBrew configuration
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

  # Configure for oh-my-posh
  # This causes an issue when oh-my-posh is installed with brew since the installation location changes
  # So do it all manually
  # eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/my-posh.json -s)"

  export POSH_THEME="$HOME/.config/oh-my-posh/my-posh.json"
  export POWERLINE_COMMAND="oh-my-posh"
  export CONDA_PROMPT_MODIFIER=false

  # set secondary prompt
  PS2="$(oh-my-posh print secondary --config="$POSH_THEME" --shell=bash --shell-version="$BASH_VERSION")"

  function _omp_hook() {
      local ret=$?

      omp_stack_count=$((${#DIRSTACK[@]} - 1))
      omp_elapsed=-1
      PS1="$(oh-my-posh print primary --config="$POSH_THEME" --shell=bash --shell-version="$BASH_VERSION" --error="$ret" --execution-time="$omp_elapsed" --stack-count="$omp_stack_count" | tr -d '\0')"

      return $ret
  }

  if [ "$TERM" != "linux" ] && [ -x "$(command -v oh-my-posh)" ] && ! [[ "$PROMPT_COMMAND" =~ "_omp_hook" ]]; then
      PROMPT_COMMAND="_omp_hook; $PROMPT_COMMAND"
  fi

  eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/my-posh.json)"  
fi

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ $PS1 && -f /usr/share/bash-completion/completions/git ]] && source /usr/share/bash-completion/completions/git
complete -F __start_kubectl k
complete -C aws_completer aws


# Configure nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/home/linuxbrew/.linuxbrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# User specific environment and startup programs
export PATH="$HOME/.local/bin:$PATH"
export KUBECONFIG=$HOME/.kube/config

export SSLKEYLOGFILE=~/.ssl-key.log

export GITHUB_TOKEN=$(~/.local/bin/github-token)

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export KUBERNETES_EXEC_INFO='{"apiVersion": "client.authentication.k8s.io/v1beta1"}'

update_clock () {
        echo '[ROOT] Updating clock (sudo hwclock --hctosys)'
        sudo hwclock -s
        sudo ntpdate time.windows.com
}