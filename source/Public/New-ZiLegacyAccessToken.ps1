function New-ZiLegacyAccessToken {
    param (
        [string]$AccessTokenPath = "$env:USERPROFILE\.creds\Zisson\app1\zissonAccessToken.xml"
    )

    while (!$Username) {
        $Username = Read-Host "Enter the legacy Zisson API username"
    }

    while (!$Passwd) {
        $Passwd = Read-Host "Enter the legacy Zisson API password"
    }

    $AccessTokenDir = $AccessTokenPath.Substring(0, $AccessTokenPath.LastIndexOf('\'))
    if (!(Test-Path $AccessTokenDir)) {
        #Create parent folders of the access token file
        $null = New-Item -ItemType Directory $AccessTokenDir
    }

    #Encode credentials to Base64
    $Text = "$($Username):$($Passwd)"
    $Bytes = [Text.Encoding]::UTF8.GetBytes($Text)
    $AccessToken = [Convert]::ToBase64String($Bytes)

    #Create access token file
    $AccessToken | ConvertTo-SecureString -AsPlainText | Export-Clixml $AccessTokenPath
}