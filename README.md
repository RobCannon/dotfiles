Based on https://www.atlassian.com/git/tutorials/dotfiles

Enter these commands and supply PAT
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare  https://github.com/Equifax/robcannon-dotfiles.git $HOME/.cfg
```

Authenticate eith GH command line
```
gh auth login
```

The run these commands to finish

```
config config --local status.showUntrackedFiles no
config checkout -f rob

sudo usermod -aG docker $USER
newgrp docker

source ~/.bash_profile
init-repos
```
