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
