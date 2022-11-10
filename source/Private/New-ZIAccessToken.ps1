function New-ZIAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Zisson\zissonAccessToken.xml"
    )

    $username = Read-Host "Enter API username"
    $passwd = Read-Host -AsSecureString "Enter API password"

    if (!(Test-Path $accessTokenPath)) {
        #Create parent folders of the access token file 
        mkdir -p $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\')) | Out-Null
    }
    
    #Encode credentials to Base64
    $text = "$($username):$($passwd | ConvertFrom-SecureString -AsPlainText)"
    $bytes = [Text.Encoding]::UTF8.GetBytes($text)
    $accessToken = [Convert]::ToBase64String($bytes)

    #Create access token file
    $accessToken | ConvertTo-SecureString -AsPlainText | Export-Clixml $accessTokenPath
    #Output new access token
    $accessToken
}