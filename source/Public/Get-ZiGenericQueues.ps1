function Get-ZiGenericQueues {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$CustomerGuid, 
        [Parameter(ParameterSetName="List queues")][int]$QueueType,
        [Parameter(Mandatory,ParameterSetName="Get queue by id")][string]$QueueGuid
    )

    process {
        $Uri = "https://app2.zisson.com/web-api/v1/customers/$CustomerGuid/generic-queues"

        switch ($PsCmdlet.ParameterSetName) {
            "List queues" {
                #Parameters to exclude in Uri build
                $ParameterExclusion = @("CustomerGuid")

                #Build request Uri
                $PSBoundParameters.Keys.ForEach({
                    $Key = $_
                    $Value = $PSBoundParameters.$key
                    
                    #Check if parameter is excluded
                    if ($ParameterExclusion -contains $Key) {
                        return
                    }

                    #Check for "?" in Uri and set delimiter
                    if (!($Uri -replace "[^?]+")) {
                        $Delimiter = "?"
                    } else {
                        $Delimiter = "&"
                    }

                    $Uri = "$Uri$Delimiter$Key=$Value"
                })
            }
            "Get queue by id" {
                $Uri = "$Uri/$QueueGuid"
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