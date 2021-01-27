#!/bin/pwsh
clone-repos.ps1 cloud-services-equifax-shell
clone-repos.ps1 cloud-services-container-imaging
clone-repos.ps1 cloud-services-kubernetes
clone-repos.ps1 cloud-services
clone-repos.ps1 iaas-platform-services-fr-smtp-relay ~/src/smtp-relay


git clone https://github.com/Equifax/6463_us_server-imaging_iaas_project-setup.git ~/src/server-imaging/project-setup

git clone https://github.com/Equifax/gcp-fedramp-server-images ~/src/fr-server-imaging/gcp-fedramp-server-images
git clone https://github.com/Equifax/7170_us_server-imaging-fr_iaas_project-setup.git ~/src/fr-server-imaging/project-setup
git clone https://github.com/Equifax/7170_us_server-imaging-fr_iaas_project-setup-prd.git ~/src/fr-server-imaging/project-setup-prd

git clone https://github.com/Equifax/1977_us_iaas-dbmw_iaas_project-setup.git ~/src/dbmw/project-setup

git clone https://github.com/Equifax/7265_us_iac-codeshare_iaas_project-setup.git ~/src/iac/project-setup

git clone https://github.com/Equifax/6454_us_platform-services-poc_iaas_project-setup.git ~/src/platform-services-poc/project-setup
