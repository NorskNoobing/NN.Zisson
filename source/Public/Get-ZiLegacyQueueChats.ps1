function Get-ZiLegacyQueueChats {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][datetime]$StartDate,
        [Parameter(Mandatory)][datetime]$EndDate
    )

    process {
        $Splat = @{
            "Method" = "GET"
            "Uri" = "$(Get-ZiLegacyEndpoint)/api/simple/QueueChats"
            "Headers" = @{
                "Authorization" = "Basic $(Get-ZiLegacyAccessToken)"
            }
            "Body" = @{
                "start_date" = $StartDate
                "end_date"  = $EndDate
            }
        }
        $Result = Invoke-RestMethod @Splat
        $Result.QueueChats
    }
}