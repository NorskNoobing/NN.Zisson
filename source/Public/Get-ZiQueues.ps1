function Get-ZiQueues {
    [CmdletBinding(DefaultParameterSetName="List queues")]
    param (
        [Parameter(Mandatory)][string]$CustomerGuid,
        [Parameter(Mandatory,ParameterSetName="Get queue by guid")][string]$QueueGuid,
        [Parameter(ParameterSetName="List queues")][switch]$ListQueues
    )

    process {
        $Uri = "https://app2.zisson.com/web-api/v1/customers/$CustomerGuid/queues"

        switch ($PsCmdlet.ParameterSetName) {
            "Get queue by guid" {
                $Uri += "/$QueueGuid"
            }
        }

        $splat = @{
            "Method" = "GET"
            "Uri" = $Uri
            "Header" = @{
                "Authorization" = "Bearer $(Get-ZiAccessToken)"
                "Accept" = "application/json"
                "Content-Type" = "application/json"
            }
        }
        Invoke-RestMethod @splat
    }
}