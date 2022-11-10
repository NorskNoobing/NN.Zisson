function Get-ZIQueueStatus {
    param (
        [string]$queueName,
        [string]$queueType
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-ZiEndpoint)/api/simple/QueueStatus"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZiAccessToken)"
        }
        "Body" = @{
            "queue_name" = $queueName
            "queue_type"  = $queueType
        }
    }
    Invoke-RestMethod @splat
}
