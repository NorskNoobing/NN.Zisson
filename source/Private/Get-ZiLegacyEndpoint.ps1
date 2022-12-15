function Get-ZiLegacyEndpoint {
    [CmdletBinding()]
    param (
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\app1\zissonEndpoint.xml"
    )

    process {
        if (!(Test-Path $EndpointPath)) {
            New-ZiLegacyEndpoint
        }

        Import-Clixml $EndpointPath
    }
}