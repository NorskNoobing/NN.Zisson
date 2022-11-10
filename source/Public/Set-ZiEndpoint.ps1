function Set-ZiEndpoint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][ValidateSet("https://api.zisson.com","https://api.zisson.no")]$Endpoint,
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\zissonEndpoint.xml"
    )

    process {
        #Create parent folders of the access token file
        $EndpointDir = $EndpointPath.Substring(0, $EndpointPath.lastIndexOf('\'))
        if (!(Test-Path $EndpointDir)) {
            $null = New-Item -ItemType Directory $EndpointDir
        }

        $Endpoint | Export-Clixml $EndpointPath
    }
}