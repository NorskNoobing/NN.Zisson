function Send-ZISMS {
    param (
        [Parameter(Mandatory)][string]$message,
        [Parameter(Mandatory)][string]$recipients,
        [Parameter(Mandatory)][string]$senderNumber,
        [Parameter(Mandatory)][string]$senderName
    )

    $splat = @{
        "Method" = "POST"
        "Uri" = "$(Get-ZiEndpoint)/api/simple/SendSms"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZiAccessToken)"
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