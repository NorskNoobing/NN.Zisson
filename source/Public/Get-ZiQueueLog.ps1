function Get-ZiQueueLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][datetime]$FromDate,
        [Parameter(Mandatory)][datetime]$ToDate
    )

    process {
        $splat = @{
            "Method" = "POST"
            "Uri" = "https://app2.zisson.com/web-api/v1/queue-log/search"
            "Header" = @{
                "Authorization" = "Bearer $(Get-ZiAccessToken)"
                "Accept" = "application/json"
                "Content-Type" = "application/json"
            }
            "Body" = @{
                "fromDate" = $FromDate
                "toDate" = $ToDate
            } | ConvertTo-Json
        }
        Invoke-RestMethod @splat
    }
}