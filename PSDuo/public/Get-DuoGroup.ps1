<#
.Synopsis
   Retrieve DUO Groups
.DESCRIPTION
   Returns a list of groups.
.EXAMPLE
    Get-DuoGroup
.EXAMPLE
    Get-DuoGroup -username JoeUser
.INPUTS
   
.OUTPUTS
   [PSCustomObject]DuoRequest
.NOTES
    DUO API 
        Method GET 
        Path /admin/v1/groups
    PARAMETERS
        None
    RESPONSE CODES
        Response	Meaning
        200	        Success. Returns a list of users.
.COMPONENT
   The component this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Get-DuoGroup() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $false)]
        [String]$user_id
    )
    [string]$method = "GET"
    [string]$path = "/admin/v1/groups"
    if($user_id){
        [string]$path = "/admin/v1/users/$user_id/groups"
    }
    
    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    $Response = Invoke-RestMethod @DuoRequest
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
        Write-Warning ($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    }   
    $Output = $Response | Select-Object -ExpandProperty Response 
    Write-Output $Output
}