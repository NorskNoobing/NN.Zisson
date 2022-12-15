function Get-ZiAccessToken {
    [CmdletBinding()]
    param (
        $AccessTokenPath = "$env:USERPROFILE\.creds\Zisson\app2\ZissonAccessToken.xml"
    )

    process {
        if (!(Test-Path -Path $AccessTokenPath)) {
            New-ZiAccessToken
        }

        $TimeTillTokenExpiry = (Import-Clixml -Path $AccessTokenPath).expiry_date - (Get-Date)
        
        #Check if there's less than 5 minutes till the current access token expires
        if (($TimeTillTokenExpiry.Minutes) -lt 5) {
            New-ZiAccessToken
        }

        (Import-Clixml -Path $AccessTokenPath).access_token | ConvertFrom-SecureString -AsPlainText
    }
}