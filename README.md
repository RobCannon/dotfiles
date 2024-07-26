Based on https://www.atlassian.com/git/tutorials/dotfiles

First, follow the instructions for the Window Boxstarter scripts
https://github.com/RobCannon/boxstarter

Then, enter this batch of commands from a WSL session
```
echo "[network]" | sudo tee /etc/wsl.conf
echo "generateResolvConf = false" | sudo tee -a /etc/wsl.conf
exit
```

Then, open a Powershell session and run this batch of commands
```
wsl --shutdown
exit
```


The open a WSL session and run this batch of commands
```
sudo rm -rf /etc/resolv.conf
sudo tee /etc/resolv.conf > /dev/null <<'EOF'
nameserver 1.1.1.1
nameserver 1.0.0.1
EOF

alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"
git clone --bare "https://github.com/RobCannon/dotfiles.git" $HOME/.cfg
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f main

~/.local/bin/init-os.sh
```

Only Rob should run this.  This is to update the repo.
```
dotfiles push --set-upstream origin main
```

When that is complete, run this batch of commands
```
source ~/.bash_profile
~/.local/bin/init-repos

```
