#!/usr/bin/env bash

#!/bin/bash
set -e

# Set correct permissions for mount Windows drive
sudo tee /etc/wsl.conf > /dev/null <<'EOF'
[boot]
systemd=true
[automount]
enabled = true
options = "metadata,umask=0077,fmask=0077"
EOF


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpdate apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq update


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall core packages\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install \
  apt-transport-https \
  ca-certificates \
  lsb-release \
  systemd-timesyncd \
  gnupg2 \
  curl \
  wget \
  software-properties-common \
  build-essential \
  make \
  procps \
  file \
  gcc \
  git \
  gettext \
  unzip \
  jq \
  bash \
  bash-completion \
  tldr \
  nano \
  xclip \
  openssl \
  gnupg-agent \
  inetutils-traceroute \
  bind9-dnsutils \
  tcpdump \
  openssh-client \
  xdg-utils

# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mFix time sync issues in WSL\e[0m"
# https://github.com/microsoft/WSL/issues/8204#issuecomment-1338334154
# sudo mkdir -p /etc/systemd/system/systemd-timesyncd.service.d
# sudo tee /etc/systemd/system/systemd-timesyncd.service.d/override.conf > /dev/null <<'EOF'
# [Unit]
# ConditionVirtualization=
# EOF
#sudo systemctl start systemd-timesyncd
#sudo service systemd-timesyncd start



# Fix landscape-sysinfo.cache error in WSL
# https://askubuntu.com/questions/1414483/landscape-sysinfo-cache-permission-denied-when-i-start-ubuntu-22-04-in-wsl
sudo DEBIAN_FRONTEND=noninteractive apt-get --assume-yes remove landscape-common
rm -f ~/.motd_shown

# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mAdding PPA for WSLU \e[0m"
# sudo add-apt-repository -y ppa:wslutilities/wslu

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mAdding PPA for Git \e[0m"
sudo add-apt-repository ppa:git-core/ppa --yes

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mAdding PPA for NodeJs \e[0m"
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo bash -s

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mAdding GitHub package source \e[0m"
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mInstall Microsoft Packages source\e[0m"
# # https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#register-the-microsoft-package-repository
# wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -r -s)/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# rm -f packages-microsoft-prod.deb

# https://stackoverflow.com/questions/76536379/ubuntu-22-cannot-find-net-core
# sudo sh -c "cat > /etc/apt/preferences.d/dotnet <<'EOF'
# Package: dotnet*
# Pin: origin packages.microsoft.com
# Pin-Priority: 1001
# EOF"

# sudo sh -c "cat > /etc/apt/preferences.d/aspnet <<'EOF'
# Package: aspnet*
# Pin: origin packages.microsoft.com
# Pin-Priority: 1001
# EOF"

# sudo tee /usr/lib/binfmt.d/WSLInterop.conf > /dev/null <<'EOF'
# :WSLInterop:M::MZ::/init:PF
# EOF


# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mInstall docker GPG keys\e[0m"
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall k6 GPG keys\e[0m"
sudo gpg -k
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D69
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall python deadsnakes PPA\e[0m"
sudo add-apt-repository -y ppa:deadsnakes/ppa


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall Hashicorp GPG keys\e[0m"
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpdate apt based on new repos\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq update

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling common tools via apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install \
  dotnet-sdk-8.0 \
  python3.13 \
  python3.13-venv \
  python3-pip \
  python3-crcmod \
  virtualenv \
  wslu \
  gh \
  k6 \
  packer \
  nodejs \
  postgresql-client \
  mysql-client

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpgrade packages from apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo ''


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mClean up packages from apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" auto-remove
sudo systemctl daemon-reload
echo ''

sudo snap install yq
sudo snap install yt-dlp
sudo snap install aws-cli --classic
sudo snap install helm --classic
sudo snap install kubectl --classic


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInitialize corepack\e[0m"
sudo npm install -g corepack
corepack enable

. ~/.local/bin/update-os

pwsh -NoProfile -Command - <<'EOF'
Connect-Graph -NoWelcome -Scopes User.Read.All
$context = Get-MgContext
$user = Get-MgUser -UserId $context.Account
git config --global user.email "$($user.Mail)"
git config --global user.name "$($user.DisplayName)"
EOF

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mCreate symlinks to Windows host\e[0m"
rm -rf ~/.aws
ln -sf "$USERPROFILE/.aws" "$HOME/.aws"
rm -rf ~/.ssh
ln -sf "$USERPROFILE/.ssh" "$HOME/.ssh"


# Initialize ssh-agent
# https://unix.stackexchange.com/questions/339840/how-to-start-and-use-ssh-agent-as-systemd-service
#systemctl --user enable --now ssh-agent

# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mConfigure docker group\e[0m"
# sudo addgroup --system docker
# sudo adduser $USER docker
# if [ -S /var/run/docker.sock ]
# then
#   sudo chown root:docker /var/run/docker.sock
#   sudo chmod g+w /var/run/docker.sock
# fi

# echo ''
# echo -e "\e[1;36m------\e[0m"
# echo -e "\e[1;36mAdding permissions for docker\e[0m"
# sudo addgroup --system docker
# sudo adduser $USER docker
# if [ ! -S /var/run/docker.sock ]
# then
#   sudo ln -sf /mnt/wsl/rancher-desktop/run/docker.sock /var/run/docker.sock
# fi

# if [ -S /var/run/docker.sock ]
# then
#   sudo chown root:docker /var/run/docker.sock
#   sudo chmod g+w /var/run/docker.sock
# fi
sudo curl -s https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh

echo ''
echo -e "\e[1;32m------\e[0m"
echo -e "\e[1;32mOS Initialization Complete\e[0m"
