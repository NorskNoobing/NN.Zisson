function Get-ZiLegacyQueueCalls {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][datetime]$StartDate,
        [Parameter(Mandatory)][datetime]$EndDate,
        [Parameter(Mandatory)][int]$QueueList
    )

    process {
        $Splat = @{
            "Method" = "GET"
            "Uri" = "$(Get-ZiLegacyEndpoint)/api/simple/QueueCallsAll"
            "Headers" = @{
                "Authorization" = "Basic $(Get-ZiLegacyAccessToken)"
            }
            "Body" = @{
                "start_date" = $StartDate
                "end_date"  = $EndDate
                "queue_list" = $QueueList
            }
        }
        $Result = Invoke-RestMethod @Splat
        $Result.QueueCallsAll
    }
}