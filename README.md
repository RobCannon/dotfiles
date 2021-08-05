Based on https://www.atlassian.com/git/tutorials/dotfiles

Authenticate with GH command line (interactive)
```
gh auth login
```

Then, enter this batch of commands
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare "https://github.com/Equifax/robcannon-dotfiles.git" $HOME/.cfg
config config --local status.showUntrackedFiles no
config checkout -f rob

sudo usermod -aG docker $USER
newgrp docker

source ~/.bash_profile

git credential approve <<EOF
protocol=https
host=github.com
username=$(yq e .'"github.com".user' ~/.config/gh/hosts.yml)
password=$(yq e .'"github.com".oauth_token' ~/.config/gh/hosts.yml)
EOF

init-repos
```
