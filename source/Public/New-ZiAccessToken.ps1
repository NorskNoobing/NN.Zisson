function New-ZIAccessToken {
    param (
        [string]$accessTokenPath = "$env:USERPROFILE\.creds\Zisson\zissonAccessToken.xml"

    )

    $username = Read-Host "Enter Zisson API username"
    if (!$username) {
        Write-Error "Please provide a Zisson API username." -ErrorAction Stop
    }

    $passwd = Read-Host "Enter Zisson API password"
    if (!$passwd) {
        Write-Error "Please provide a Zisson API password." -ErrorAction Stop
    }

    $accessTokenDir = $accessTokenPath.Substring(0, $accessTokenPath.lastIndexOf('\'))
    if (!(Test-Path $accessTokenDir)) {
        #Create parent folders of the access token file
        $null = New-Item -ItemType Directory $accessTokenDir
    }
    
    #Encode credentials to Base64
    $text = "$($username):$($passwd)"
    $bytes = [Text.Encoding]::UTF8.GetBytes($text)
    $accessToken = [Convert]::ToBase64String($bytes)

    #Create access token file
    $accessToken | ConvertTo-SecureString -AsPlainText | Export-Clixml $accessTokenPath
}