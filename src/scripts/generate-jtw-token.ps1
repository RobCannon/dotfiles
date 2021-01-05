#!/bin/pwsh
$GH_APP_USER='73630'
$GH_APP_PRIVATE_KEY_FILE='/home/r_cannon_equifax_com/src/GitHubApp_73630.pem'

function Base64UrlEncodeBytes($bytes) { [Convert]::ToBase64String($bytes) -replace '\+','-' -replace '/','_' -replace '=' }
function Base64UrlEncodeJson($json) { Base64UrlEncodeBytes([System.Text.Encoding]::UTF8.GetBytes(($json | ConvertTo-Json -Compress))) }

$header = Base64UrlEncodeJson(@{alg = 'RS256'; typ = 'JWT'})
$payload = Base64UrlEncodeJson(@{iat=[DateTimeOffset]::Now.ToUnixTimeSeconds(); exp = [DateTimeOffset]::Now.AddSeconds(600).ToUnixTimeSeconds(); iss = [int]$GH_APP_USER})

$rsa = [System.Security.Cryptography.RSA]::Create()
[int]$bytesRead = 0
$rsa.ImportRSAPrivateKey([Convert]::FromBase64String(([System.IO.File]::ReadAllLines($GH_APP_PRIVATE_KEY_FILE) | ?{ $_ -notmatch '----'})), [ref]$bytesRead)

$signature = Base64UrlEncodeBytes($rsa.SignData([System.Text.Encoding]::UTF8.GetBytes("$header.$payload"), [Security.Cryptography.HashAlgorithmName]::SHA256, [Security.Cryptography.RSASignaturePadding]::Pkcs1))

"$header.$payload.$signature"