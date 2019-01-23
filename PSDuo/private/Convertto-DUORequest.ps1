<#
.Synopsis
   DUO Webrequest Authentication Generator 
.DESCRIPTION
   DUO API Authentication Helper

    DUO Authentication calls require a specific format: 
    The API uses HTTP Basic Authentication to authenticate requests. Use your Duo application’s integration key as the HTTP Username.
    Generate the HTTP Password as an HMAC signature of the request. This will be different for each request and must be re-generated each time.
.EXAMPLE
    [string]$method = "GET"
    [string]$path = "/admin/v1/users"
    $APiParams = @{username='JoeTheUser'}
    
    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    Invoke-RestMethod @DuoRequest
.INPUTS
   
.OUTPUTS
   
.NOTES
    DUO API Authentication

    The API uses HTTP Basic Authentication to authenticate requests. Use your Duo application’s integration key as the HTTP Username.
    Generate the HTTP Password as an HMAC signature of the request. This will be different for each request and must be re-generated each time.

    https://duo.com/docs/adminapi#authentication

    Return HTTP Basic Authentication ("Authorization" and "Date") headers.
    method, host, path: strings from request
        $method = 'GET -or PLACE...'  
        $apiHost = 'api-xxxxxxxx.duosecurity.com'
        $DuoMethodPath = = '/admin/v1/users' 
        $StringAPIParams - Converted locally, using passed vairables from commandlets
        *Some of DUO's path enpoints include the only parameter needed and therefore do not need $StringAPIParams.
        
    params: dict of request parameters
        $APIParams
    skey: secret key
        $DuoConfig.sKey
    ikey: integration key
        $DuoConfig.iKey
    $DUOmethodPath
.COMPONENT
   DUOPS
.FUNCTIONALITY
   DUO API
#>

function Convertto-DuoRequest(){
    param(
        $DuoMethodPath,
        $APIParams,
        $method
    )
    #Check for DUOConfig
    If(!($Script:DuoConfig)){
        Write-Warning "Please set up a DUO Configuration via New-DuoConfig cmdlet"
        Throw "No DuoConfig found"
}

    #Decrypt our keys from our config
    $skey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Script:DuoConfig.sKey))
    $iKey = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Script:DuoConfig.iKey))
    $apiHost = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Script:DuoConfig.apiHost))
    $Date = (Get-Date).ToUniversalTime().ToString("ddd, dd MMM yyyy HH:mm:ss -0000")

    #Stringified Params/URI Safe chars - I think this should grab everything...
    $StringAPIParams = ($APIParams.Keys | Sort-Object | ForEach-Object {
        $_ + "=" + [uri]::EscapeDataString($APIParams.$_)
    }) -join "&"

    #DUO Params formatted and stored as bytes with StringAPIParams
    $DuoParams = (@(
        $Date.Trim(),
        $method.ToUpper().Trim(),
        $apiHost.ToLower().Trim(),
        $DuoMethodPath.Trim(),
        $StringAPIParams.trim()
    ).trim() -join "`n").ToCharArray().ToByte([System.IFormatProvider]$UTF8)

    #Hash out some secrets 
    $HMACSHA1 = [System.Security.Cryptography.HMACSHA1]::new($skey.ToCharArray().ToByte([System.IFormatProvider]$UTF8))
    $hmacsha1.ComputeHash($DuoParams) | Out-Null
    $ASCII = [System.BitConverter]::ToString($hmacsha1.Hash).Replace("-", "").ToLower()

    #Create the new header and combing it with our iKey to use it as Authentication
    $AuthHeadder = $ikey + ":" + $ASCII
    [byte[]]$ASCIBytes = [System.Text.Encoding]::ASCII.GetBytes($AuthHeadder)

    #Create our Parameters for the webrequest - Easy @Splatting!
    $DUOWebRequestParams = @{
        URI         = ('Https://{0}{1}' -f $apiHost, $DuoMethodPath)
        Headers     = @{
            "X-Duo-Date"    = $Date
            "Authorization" = ('Basic: {0}' -f [System.Convert]::ToBase64String($ASCIBytes))
        }
        Body        = $APIParams
        Method      = $method
        ContentType = 'application/x-www-form-urlencoded'
    }
    Write-Output $DUOWebRequestParams
}
