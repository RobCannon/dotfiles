#!/bin/pwsh
Param (
  [Parameter(Mandatory=$true)]
  [string]$TeamName,

  [Parameter(Mandatory=$true)]
  [string]$Path
)

$token=(Get-Content ~/.config/gh/hosts.yml | ConvertFrom-Yaml).'github.com'.oauth_token
$headers = @{ Authorization = "token $token" }

if (-Not (Test-Path $Path)) {
  New-Item -Path $Path -ItemType Directory | Out-Null
}

Push-Location $Path

Invoke-RestMethod -Headers $headers "https://api.github.com/orgs/Equifax/teams/$TeamName/repos" | %{ $_.clone_url } | %{
  Write-Host "Cloning $_"
  git clone $_
}

Pop-Location
