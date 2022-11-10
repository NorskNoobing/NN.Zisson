function Get-ZIQueueChats {
    param (
        [Parameter(Mandatory)][datetime]$startDate,
        [Parameter(Mandatory)][datetime]$endDate
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-ZiEndpoint)/api/simple/QueueChats"
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