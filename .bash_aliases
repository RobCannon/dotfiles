## Colorize the ls output ##
eval "$(dircolors)"
alias ls='ls -F -h --color=always -v --time-style=long-iso -l'

## Use a long listing format ##
alias dir='ls -a'

## Show hidden files ##
alias l.='ls -d .* --color=auto'

alias myip='hostname -I | awk '"'"'{print $1}'"'"''

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# Git aliases
alias gitrebase='git rebase --interactive @{u}'
alias gitreset='git fetch origin -p && git reset --hard @{u} && git clean -xfd'
alias giturl='git remote get-url origin'
alias gitsync='git pull --tags origin --rebase -f && git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -D'
alias gitmergetest='gh-open && git checkout main && git merge test && git push && git checkout test'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# This command is used ALOT both below and in daily life
alias k='kubectl'

# Apply a YML file
alias kaf='k apply -f'
alias kdf='k delete -f'

# Drop into an interactive terminal on a container
alias keti='k exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcgc='k config get-contexts'
alias kcuc='k config use-context'
alias kcsc='k config set-context'
alias kcdc='k config delete-context'
alias kccc='k config current-context'
alias kgn='k get namespaces'

# Pod management.
alias kgp='k get pods'
alias kep='k edit pods'
alias kdp='k describe pods'
alias kdelp='k delete pods'

# Service management.
alias kgs='k get svc'
alias kes='k edit svc'
alias kds='k describe svc'
alias kdels='k delete svc'

# Ingress management
alias kgi='k get ingress'
alias kei='k edit ingress'
alias kdi='k describe ingress'
alias kdeli='k delete ingress'

# Secret management
alias kgsec='k get secret'
alias kdsec='k describe secret'
alias kdelsec='k delete secret'

# Deployment management.
alias kgd='k get deployment'
alias ked='k edit deployment'
alias kdd='k describe deployment'
alias kdeld='k delete deployment'
alias ksd='k scale deployment'
alias krsd='k rollout status deployment'

# Rollout management.
alias kgrs='k get rs'
alias krh='k rollout history'
alias kru='k rollout undo'

# Logs
alias kl='k logs'

# Terraform aliases
alias tfi='terraform init -upgrade=true'
alias tfv='terraform validate'
alias tfp='terraform plan'
alias tfa='terraform apply -auto-approve'
alias tff='terraform fmt -recursive'
alias tfo='terraform output'
alias tfws='terraform workspace select'
alias tft='terraform init -upgrade=true && terraform validate && terraform plan'

alias dockerclean='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true && docker rmi $(docker images -q -f dangling=true)'
alias dockercleanall='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true && docker rmi --force $(docker images -q)'
alias dockerkillall='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true'

# gcloud aliases
alias gcil='gcloud compute instances list'
alias glogin='gcloud auth login --quiet --update-adc'
alias grevoke='rm -rf ~/.config/gcloud'

#alias ping='prettyping --nolegend'
#alias man='tldr'
alias topcpu='ps -eo pid,ppid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 20'

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


