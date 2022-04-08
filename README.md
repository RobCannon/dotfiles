Based on https://www.atlassian.com/git/tutorials/dotfiles

Install and Authenticate with GH command line (interactive)
```
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install jq
curl --silent --show-error --location --url $(curl --silent --show-error --header "Accept: application/vnd.github.v3+json" --url https://api.github.com/repos/cli/cli/releases/latest | jq -r '.assets[] | select(.name | test("gh_\\S+_linux_amd64.deb$")) | .browser_download_url') --output gh_linux_amd64.deb

sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install ./gh_linux_amd64.deb
rm gh_linux_amd64.deb
gh auth login
```

Then, enter this batch of commands
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
git clone --bare "https://github.com/Equifax/robcannon-dotfiles.git" $HOME/.cfg
config config --local status.showUntrackedFiles no
config checkout -f main

sudo usermod -aG docker $USER
newgrp docker

source ~/.bash_profile

git credential approve <<EOF
protocol=https
host=github.com
username=$(yq e .'"github.com".user' ~/.config/gh/hosts.yml)
password=$(yq e .'"github.com".oauth_token' ~/.config/gh/hosts.yml)
EOF


```
