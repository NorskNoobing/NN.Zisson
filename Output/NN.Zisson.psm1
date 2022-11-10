#Region '.\Private\Get-ZIAccessToken.ps1' 0
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
#EndRegion '.\Private\Get-ZIAccessToken.ps1' 11
#Region '.\Private\New-ZIAccessToken.ps1' 0
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
#EndRegion '.\Private\New-ZIAccessToken.ps1' 23
#Region '.\Public\Get-ZIQueueCalls.ps1' 0
function Get-ZIQueueCalls {
    param (
        [Parameter(Mandatory)][ValidateSet("https://api.zisson.com","https://api.zisson.no")][string]$endpoint,
        [Parameter(Mandatory)][datetime]$startDate,
        [Parameter(Mandatory)][datetime]$endDate,
        [int]$queueList
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$endpoint/api/simple/QueueCallsAll"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZIAccessToken)"
        }
        "Body" = @{
            "start_date" = $startDate
            "end_date"  = $endDate
            "queue_list" = $queueList
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-ZIQueueCalls.ps1' 22
#Region '.\Public\Get-ZIQueueChats.ps1' 0
function Get-ZIQueueChats {
    param (
        [Parameter(Mandatory)][ValidateSet("https://api.zisson.com","https://api.zisson.no")][string]$endpoint,
        [Parameter(Mandatory)][datetime]$startDate,
        [Parameter(Mandatory)][datetime]$endDate
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$endpoint/api/simple/QueueChats"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZIAccessToken)"
        }
        "Body" = @{
            "start_date" = $startDate
            "end_date"  = $endDate
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-ZIQueueChats.ps1' 20
#Region '.\Public\Get-ZIQueueStatus.ps1' 0
function Get-ZIQueueStatus {
    param (
        [Parameter(Mandatory)][ValidateSet("https://api.zisson.com","https://api.zisson.no")][string]$endpoint,
        [string]$queueName,
        [string]$queueType
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$endpoint/api/simple/QueueStatus"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZIAccessToken)"
        }
        "Body" = @{
            "queue_name" = $queueName
            "queue_type"  = $queueType
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Get-ZIQueueStatus.ps1' 20
#Region '.\Public\Send-ZISMS.ps1' 0
function Send-ZISMS {
    param (
        [Parameter(Mandatory)][string]$message,
        [Parameter(Mandatory)][string]$recipients,
        [Parameter(Mandatory)][ValidateSet("https://api.zisson.com","https://api.zisson.no")]$endpoint,
        [Parameter(Mandatory)][string]$senderNumber,
        [Parameter(Mandatory)][string]$senderName
    )

    $splat = @{
        "Method" = "POST"
        "Uri" = "$endpoint/api/simple/SendSms"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZIAccessToken)"
        }
        "Body" = @{
            "sender_number" = $senderNumber
            "sender_name" = $senderName
            "recipients" = $recipients
            "msg" = $message
        }
    }
    Invoke-RestMethod @splat
}
#EndRegion '.\Public\Send-ZISMS.ps1' 24
