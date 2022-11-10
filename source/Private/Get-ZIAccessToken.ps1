function Get-ZiAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Zisson\zissonAccessToken.xml"
    )

    if (!(Test-Path $accessTokenPath)) {
        New-ZiAccessToken
    }
    
    Import-Clixml $accessTokenPath | ConvertFrom-SecureString -AsPlainText
}