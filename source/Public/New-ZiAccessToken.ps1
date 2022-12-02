function New-ZIAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Zisson\zissonAccessToken.xml"
    )

    $username = Read-Host "Enter API username"
    $passwd = Read-Host -AsSecureString "Enter API password"

    $accessTokenDir = $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\'))
    if (!(Test-Path $accessTokenDir)) {
        #Create parent folders of the access token file
        $null = New-Item -ItemType Directory $accessTokenDir
    }
    
    #Encode credentials to Base64
    $text = "$($username):$($passwd | ConvertFrom-SecureString -AsPlainText)"
    $bytes = [Text.Encoding]::UTF8.GetBytes($text)
    $accessToken = [Convert]::ToBase64String($bytes)

    #Create access token file
    $accessToken | ConvertTo-SecureString -AsPlainText | Export-Clixml $accessTokenPath
}