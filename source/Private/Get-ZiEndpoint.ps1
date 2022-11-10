function Get-ZiEndpoint {
    [CmdletBinding()]
    param (
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\zissonEndpoint.xml"
    )

    process {
        if (!(Test-Path $EndpointPath)) {
            New-ZiEndpoint
        }

        Import-Clixml $EndpointPath
    }
}