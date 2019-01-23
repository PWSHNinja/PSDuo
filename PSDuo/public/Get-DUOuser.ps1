<#
.Synopsis
   Retrieve DUO Users
.DESCRIPTION
   Returns a list of users. If username is not provided, the list will contain all users. 
   If username is provided, the list will either contain a single user (if a match was found) or no users.
.EXAMPLE
    Get-DuoUser
.EXAMPLE
    Get-DuoUser -username 'i842459'
.INPUTS
   [string]UserName
.OUTPUTS
   [PSCustomObject]DuoRequest
.NOTES
    DUO API 
        Method GET 
        Path /admin/v1/users
    PARAMETERS
        Parameter	Required?	Description
        username	Optional	Specify a username to look up a single user.
    RESPONSE CODES
        Response	Meaning
        200	        Success. Returns a list of users.
        400	        Invalid parameters.
.COMPONENT
   The component this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Get-DUOuser() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $false)]
        [String]$username
    )
    [string]$method = "GET"
    [string]$path = "/admin/v1/users"
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