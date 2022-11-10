function Get-ZIQueueCalls {
    param (
        [Parameter(Mandatory)][datetime]$startDate,
        [Parameter(Mandatory)][datetime]$endDate,
        [int]$queueList
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-ZiEndpoint)/api/simple/QueueCallsAll"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZiAccessToken)"
        }
        "Body" = @{
            "start_date" = $startDate
            "end_date"  = $endDate
            "queue_list" = $queueList
        }
    }
    Invoke-RestMethod @splat
}