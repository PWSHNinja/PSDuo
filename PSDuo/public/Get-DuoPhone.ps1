<#
.Synopsis
   Retrieve DUO Phones
.DESCRIPTION
   Returns a list of phones. If no number or extension parameters are provided, the list will contain 
   all phones. Otherwise, the list will contain either single phone (if a match was found), or 
   no phones.
.EXAMPLE
    Get-DuoPhone
.EXAMPLE
    Get-DuoPhone -number ###-###-####
.INPUTS
   [string]Number
.OUTPUTS
   [PSCustomObject]DuoRequest
.NOTES
    DUO API 
        Method GET 
        Path /admin/v1/users
    PARAMETERS
        Parameter	Required?	Description
        number  	Optional	Specify a number to look up a single phone.
        extension   Optional    The extension, if necessary.
    RESPONSE CODES
        Response	Meaning
        200	        Success. Returns a list of users.
        400	        Invalid number.
    RESPONSE FORMAT
        encrypted	The encryption status of an Android or iOS device file system. One of: “Encrypted”, 
                    “Unencrypted”, or “Unknown”. Blank for other platforms. This information is available 
                    to Duo Beyond and Duo Access plan customers.
    
        extension    An extension, if necessary.

        fingerprint	Whether an Android or iOS phone is configured for fingerprint verification. One of: “Configured”, 
                    “Disabled”, or “Unknown”. Blank for other platforms.
                    *This information is available to Duo Beyond and Duo Access plan customers.

        name        Free-form label for the phone.

        number	    The phone number.

        phone_id	The phone’s ID.
        platform	The phone platform. One of: “unknown”, “google android”, “apple ios”, “windows phone 7”, 
                    “rim blackberry”, “java j2me”, “palm webos”, “symbian os”, “windows mobile”, or “generic smartphone”.
                    “windows phone” is accepted as a synonym for “windows phone 7”. This includes devices running
                    Windows Phone 8. If a smartphone’s exact platform is unknown but it will have Duo Mobile installed, 
                    use “generic smartphone” and generate an activation code. When the phone is activated its platform will be automatically detected.

        postdelay	The time (in seconds) to wait after the extension is dialed and before the speaking the prompt.
        
        predelay	The time (in seconds) to wait after the number picks up and before dialing the extension.
        
        screenlock	Whether screen lock is enabled on an Android or iOS phone. One of: “Locked”, “Unlocked”, or “Unknown”. Blank for other platforms.
                    *This information is available to Duo Beyond and Duo Access plan customers.

        sms_passcodes_sent	Have SMS passcodes been sent to this phone? Either “true” or “false”.
        
        type	    The type of phone. One of: “unknown”, “mobile”, or “landline”.
        
        users	    A list of users associated with this phone.
.COMPONENT
    PSDuo
.FUNCTIONALITY
    The functionality that best describes this cmdlet
#>
function Get-DuoPhone() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $false)]
        [String]$number,
        [parameter(Mandatory = $false)]
        [String]$extension
    )
    [string]$method = "GET"
    [string]$path = "/admin/v1/phones"
    $APiParams = $MyInvocation.BoundParameters
    
    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    $Response = Invoke-RestMethod @DuoRequest
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
        Write-Warning "APiParams:"+($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    }   
    $Output = $Response | Select-Object -ExpandProperty Response 
    Write-Output $Output
}

