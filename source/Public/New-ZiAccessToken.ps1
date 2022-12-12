function New-ZiAccessToken {
    [CmdletBinding()]
    param (
        $AccessTokenPath = "$env:USERPROFILE\.creds\Zisson\ZissonAccessToken.xml",
        $ApiKeyIdPath = "$env:USERPROFILE\.creds\Zisson\ZissonApiKeyId.xml",
        $RefreshTokenPath = "$env:USERPROFILE\.creds\Zisson\ZissonRefreshToken.xml",
        $CustomerGuidPath = "$env:USERPROFILE\.creds\Zisson\ZissonCustomerGuid.xml"
    )

    process {
        #Create folder to store credentials
        $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.lastIndexOf('\'))
        if (!(Test-Path $AccessTokenDir)) {
            $null = New-Item -ItemType Directory $AccessTokenDir
        }

        #Create ApiKeyId file
        if (!(Test-Path $ApiKeyIdPath)) {
            while (!$ApiKeyId) {
                $ApiKeyId = Read-Host "Enter Zisson ApiKeyId"
            }
            $ApiKeyId | ConvertTo-SecureString -AsPlainText | Export-Clixml $ApiKeyIdPath
        }

        #Create RefreshToken file
        if (!(Test-Path $RefreshTokenPath)) {
            while (!$RefreshToken) {
                $RefreshToken = Read-Host "Enter Zisson RefreshToken"
            }
            $RefreshToken | ConvertTo-SecureString -AsPlainText | Export-Clixml $RefreshTokenPath
        }

        #Create CustomerGuid file
        if (!(Test-Path $CustomerGuidPath)) {
            while (!$CustomerGuid) {
                $CustomerGuid = Read-Host "Enter Zisson CustomerGuid"
            }
            $CustomerGuid | ConvertTo-SecureString -AsPlainText | Export-Clixml $CustomerGuidPath
        }

        #Request new accesstoken
        $splat = @{
            "Method" = "POST"
            "Uri" = "https://app2.zisson.com/web-api/v1/authenticate/refresh-token"
            "Header" = @{
                "Accept" = "text/plain"
                "Content-Type" = "application/json-patch+json"
            }
            "Body" = @{
                "id" = Import-Clixml $ApiKeyIdPath | ConvertFrom-SecureString -AsPlainText
                "customerGuid" = Import-Clixml $CustomerGuidPath | ConvertFrom-SecureString -AsPlainText
                "refreshToken" = Import-Clixml $RefreshTokenPath | ConvertFrom-SecureString -AsPlainText
            }
        }
        Invoke-RestMethod @splat
    }
}