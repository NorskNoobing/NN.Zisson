function Get-ZiQueueStatus {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$QueueGuid
    )

    process {
        $splat = @{
            "Method" = "GET"
            "Uri" = "https://app2.zisson.com/external-api/v1/queuestatus/$QueueGuid"
            "Header" = @{
                "Authorization" = "Bearer $(Get-ZiAccessToken)"
                "Accept" = "application/json"
                "Content-Type" = "application/json"
            }
        }
        Invoke-RestMethod @splat
    }
}