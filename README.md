Based on https://www.atlassian.com/git/tutorials/dotfiles

Authenticate with GH command line (interactive) from the desktop (not WSL)
```
gh auth login
```

Then, enter this batch of commands
```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager-core.exe"
git clone --bare "https://github.com/RobCannon/dotfiles.git" $HOME/.cfg
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f main

source ~/.bash_profile

init-os

clear

update-os
```

```
sudo usermod -aG docker $USER
newgrp docker
```