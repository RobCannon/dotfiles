#!/usr/bin/env bash

#!/bin/bash
set -e

# Set correct permissions for mount Windows drive
sudo tee /etc/wsl.conf > /dev/null <<'EOF'
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
  gnupg \
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
  tcpdump \
  openssh-client


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall Microsoft GPG keys\e[0m"
wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall docker GPG keys\e[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstall python deadsnakes PPA\e[0m"
sudo add-apt-repository -y ppa:deadsnakes/ppa


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpdate apt based on new repos\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq update

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling common tools via apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install \
  powershell \
  python3.11 \
  python3.11-venv \
  python3-pip \
  python3-crcmod \
  virtualenv \
  dotnet-sdk-6.0
  


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpgrade packages from apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo ''

pwsh -NoProfile -Command - <<'EOF'
Install-Module -Name PowerShellGet -RequiredVersion 3.0.12-beta -Force -AllowPrerelease
Set-PSResourceRepository -Name PSGallery -Trusted

Install-PSResource PSReadLine -Reinstall
Install-PSResource Powershell-yaml -Reinstall
cls
EOF




echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mUpgrade packages from apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo ''


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mClean up packages from apt\e[0m"
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" auto-remove
echo ''



echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling HomeBrew\e[0m"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling yq for yaml parsing\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install yq


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling github command line\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install gh


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Hashicorp packer\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install packer


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Hashicorp vault\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install vault

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Hashicorp terraform\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install terraform

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling terraform-docs\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install terraform-docs


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling terraform-docs\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install pulumi

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Helm\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install docker-compose

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Helm\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install helm

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Istio cli\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install istioctl

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Kustomize\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install kustomize

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling FluxCD cli\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install fluxcd/tap/flux

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling Oh-My-Posh\e[0m"
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install oh-my-posh

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling AWS cli\e[0m"
ulimit -n 1000000
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install awscli

echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mInstalling AWS cli\e[0m"
ulimit -n 1000000
HOMEBREW_NO_ENV_HINTS=1 HOMEBREW_NO_INSTALL_CLEANUP=1 /home/linuxbrew/.linuxbrew/bin/brew install eksctl


echo ''
echo -e "\e[1;36m------\e[0m"
echo -e "\e[1;36mConfigure docker group\e[0m"
sudo addgroup --system docker
sudo adduser $USER docker
if [ -S /var/run/docker.sock ]
then
  sudo chown root:docker /var/run/docker.sock
  sudo chmod g+w /var/run/docker.sock
fi


echo ''
echo -e "\e[1;32m------\e[0m"
echo -e "\e[1;32mOS Initialization Complete\e[0m"
