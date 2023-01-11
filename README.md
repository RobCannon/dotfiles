Based on https://www.atlassian.com/git/tutorials/dotfiles

First, follow the instructions for the Window Boxstarter scripts
https://github.com/RobCannon/boxstarter

Then, enter this batch of commands from a WSL session

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
git clone --bare "https://github.com/RobCannon/dotfiles.git" $HOME/.cfg
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f main
dotfiles push --set-upstream origin main

~/.local/bin/init-os.sh
```

When that is complete, run this batch of commands
```
source ~/.bash_profile
~/.local/bin/init-repos

```
