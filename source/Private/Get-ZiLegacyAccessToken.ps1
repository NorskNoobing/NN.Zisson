function Get-ZiLegacyAccessToken {
    [CmdletBinding()]
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Zisson\app1\zissonAccessToken.xml"
    )

    process {
        if (!(Test-Path $AccessTokenPath)) {
            New-ZiLegacyAccessToken
        }
        
        Import-Clixml $AccessTokenPath | ConvertFrom-SecureString -AsPlainText
    }
}