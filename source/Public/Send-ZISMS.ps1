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