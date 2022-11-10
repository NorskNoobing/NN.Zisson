function Get-ZiEndpoint {
    [CmdletBinding()]
    param (
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\zissonEndpoint.xml"
    )

    process {
        Import-Clixml $EndpointPath
    }
}