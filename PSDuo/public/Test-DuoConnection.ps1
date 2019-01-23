<#
.Synopsis
   Ping Duo Endpoints
.DESCRIPTION
    The /ping endpoint acts as a "liveness check" that can be called to verify that Duo is up before 
    trying to call other endpoints. Unlike the other endpoints, this one does not have to be signed 
    with the Authorization header.
.EXAMPLE
    Get-DuoUser
.EXAMPLE
    Test-DuoConnection
.INPUTS

.OUTPUTS
   [PSCustomObject]DuoRequest
.NOTES
    DUO API 
        Method GET 
        Path /auth/v2/ping
    PARAMETERS
        None
    RESPONSE CODES
        Response	Meaning
        200	        Success.
    RESPONSE FORMAT
        Key         Value
        time        Current server time. Formatted as a UNIX timestamp Int.
.COMPONENT
   DUO Auth
.FUNCTIONALITY
   Sends a webrequest to DUO, verifying the service is available. 
#>
function Test-DuoConnection() {
    [CmdletBinding(
    )]
    param
    (

    )

    [string]$method = "GET"
    [string]$path = "/auth/v2/ping"
    $apiHost = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Script:DuoConfig.apiHost))
    
    $DUORestRequest = @{
        URI         = ('Https://{0}{1}' -f $apiHost, $path)
        Method      = $method
        ContentType = 'application/x-www-form-urlencoded'
    }
    
    $Response = Invoke-RestMethod @DUORestRequest
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
        Write-Warning "APiParams:"+($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    }   
    $Output = $Response | Select-Object -ExpandProperty Response 
    Write-Output $Output
}