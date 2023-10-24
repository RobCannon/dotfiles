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
alias giturl='git remote get-url origin'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Apply a YML file
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'

# Drop into an interactive terminal on a container
alias keti='kubectl exec -ti'

# Manage configuration quickly to switch contexts between local, dev ad staging.
alias kcgc='kubectl config get-contexts'
alias kcuc='kubectl config use-context'
alias kcsc='kubectl config set-context'
alias kcdc='kubectl config delete-context'
alias kccc='kubectl config current-context'
alias kgn='kubectl get namespaces'

# Pod management.
alias kgp='kubectl get pods'
alias kep='kubectl edit pods'
alias kdp='kubectl describe pods'
alias kdelp='kubectl delete pods'

# Service management.
alias kgs='kubectl get svc'
alias kes='kubectl edit svc'
alias kds='kubectl describe svc'
alias kdels='kubectl delete svc'

# Ingress management
alias kgi='kubectl get ingress'
alias kei='kubectl edit ingress'
alias kdi='kubectl describe ingress'
alias kdeli='kubectl delete ingress'

# Secret management
alias kgsec='kubectl get secret'
alias kdsec='kubectl describe secret'
alias kdelsec='kubectl delete secret'

# Deployment management.
alias kgd='kubectl get deployment'
alias ked='kubectl edit deployment'
alias kdd='kubectl describe deployment'
alias kdeld='kubectl delete deployment'
alias ksd='kubectl scale deployment'
alias krsd='kubectl rollout status deployment'

# Rollout management.
alias kgrs='kubectl get rs'
alias krh='kubectl rollout history'
alias kru='kubectl rollout undo'

# Logs
alias kl='kubectl logs'

alias dockerclean='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true && docker rmi $(docker images -q -f dangling=true)'
alias dockercleanall='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true && docker rmi --force $(docker images -q)'
alias dockerkillall='docker kill $(docker ps -q) || true && docker rm $(docker ps -a -q) || true'


alias topcpu='ps -eo pid,ppid,user,%mem,%cpu,cmd --sort=-%cpu | head -n 20'

# Yarn
alias yup='yarn install && yarn up'

alias sbp='source ~/.bash_profile'
alias slo='source ./login.sh'