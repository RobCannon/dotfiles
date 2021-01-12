#!/bin/pwsh
Param (
  [Parameter(Mandatory=$true)]
  [string]$TeamName,

  [string]$Path
)

if (-Not $Path) {
  if ($TeamName -match 'cloud-services-') {
    $Path = "~/src/$($TeamName.Replace('cloud-services-',''))"
  }
  else {
    $Path = "~/src/$TeamName"
  }
}

if (-Not (Test-Path $Path)) {
  New-Item -Path $Path -ItemType Directory | Out-Null
}

$token=(Get-Content ~/.config/gh/hosts.yml | ConvertFrom-Yaml).'github.com'.oauth_token
$headers = @{ Authorization = "token $token" }

$repos = Invoke-RestMethod -Headers $headers "https://api.github.com/orgs/Equifax/teams/$TeamName/repos"
foreach($repo in $repos) {
  $clone_url = $repo.clone_url
  $folder = Join-Path $Path $repo.name.Replace("$TeamName-",'')

  Write-Host "Cloning $clone_url to $folder"
  git clone $clone_url $folder
}