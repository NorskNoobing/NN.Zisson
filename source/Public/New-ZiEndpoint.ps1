function New-ZiEndpoint {
    [CmdletBinding()]
    param (
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\zissonEndpoint.xml"
    )

    process {
        $DomainSuffix = Read-Host "Enter your Zisson domain suffix (no/com)"
        switch ($DomainSuffix) {
            no {
                $Endpoint = "https://api.zisson.no"
            }
            com {
                $Endpoint = "https://api.zisson.com"
            }
            Default {
                Write-Error "Domain suffix was set to `"$DomainSuffix`". Please enter either `"no`" or `"com`"" -ErrorAction Stop
            }
        }

        #Create parent folders of the access token file
        $EndpointDir = $EndpointPath.Substring(0, $EndpointPath.lastIndexOf('\'))
        if (!(Test-Path $EndpointDir)) {
            $null = New-Item -ItemType Directory $EndpointDir
        }

        $Endpoint | Export-Clixml $EndpointPath
    }
}