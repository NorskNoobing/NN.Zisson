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