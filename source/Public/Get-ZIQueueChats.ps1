function Get-ZiQueueChats {
    param (
        [Parameter(Mandatory)][datetime]$startDate,
        [Parameter(Mandatory)][datetime]$endDate
    )

    $splat = @{
        "Method" = "GET"
        "Uri" = "$(Get-ZiEndpoint)/api/simple/QueueChats"
        "Headers" = @{
            "Authorization" = "Basic $(Get-ZiAccessToken)"
        }
        "Body" = @{
            "start_date" = $startDate
            "end_date"  = $endDate
        }
    }
    $result = Invoke-RestMethod @splat
    $result.QueueChats
}