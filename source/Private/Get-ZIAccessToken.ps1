function Get-ZIAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Zisson\zissonAccessToken.xml"
    )

    if (Test-Path $accessTokenPath) {
        Import-Clixml $accessTokenPath | ConvertFrom-SecureString -AsPlainText
    } else {
        New-ZIAccessToken -accessTokenPath $accessTokenPath
    }
}