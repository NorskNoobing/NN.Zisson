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