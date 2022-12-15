function New-ZiAccessToken {
    [CmdletBinding()]
    param (
        [int]$TokenTtl = "60",
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Zisson\app2\ZissonAccessToken.xml",
        [string]$LatestJwtPath = "$env:USERPROFILE\.creds\Zisson\app2\ZissonLatestJwt.xml"
    )

    process {
        #Create folder to store credentials
        $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.lastIndexOf('\'))
        if (!(Test-Path $AccessTokenDir)) {
            $null = New-Item -ItemType Directory $AccessTokenDir
        }

        #Create ApiKeyId file
        if (!(Test-Path $LatestJwtPath)) {
            while (!$LatestJwt) {
                $LatestJwt = Read-Host "Enter Zisson latest JWT object"
            }
            $LatestJwt | ConvertTo-SecureString -AsPlainText | Export-Clixml $LatestJwtPath
        }

        $LatestJwt = Import-Clixml $LatestJwtPath | ConvertFrom-SecureString -AsPlainText | ConvertFrom-Json

        #Request new accesstoken
        $splat = @{
            "Method" = "POST"
            "Uri" = "https://app2.zisson.com/web-api/v1/authenticate/refresh-token"
            "Header" = @{
                "Accept" = "application/json"
                "Content-Type" = "application/json"
            }
            "Body" = @{
                "id" = $LatestJwt.id
                "customerGuid" = $LatestJwt.customerGuid
                "refreshToken" = $LatestJwt.refreshToken
            } | ConvertTo-Json
        }
        $Result = Invoke-RestMethod @splat
        

        #Set up output
        @{
            "access_token" = $Result.jwt | ConvertTo-SecureString -AsPlainText
            "expiry_date" = (Get-Date).AddMinutes($TokenTtl)
        } | Export-Clixml -Path $AccessTokenPath
    }
}