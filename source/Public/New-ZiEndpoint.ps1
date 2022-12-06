function New-ZiEndpoint {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,HelpMessage="Enter your Zisson domain suffix (no/com)")][ValidateSet("com","no")][string]$DomainSuffix,
        [string]$EndpointPath = "$env:USERPROFILE\.creds\Zisson\zissonEndpoint.xml"
    )

    process {
        switch ($DomainSuffix) {
            no {
                $Endpoint = "https://api.zisson.no"
            }
            com {
                $Endpoint = "https://api.zisson.com"
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