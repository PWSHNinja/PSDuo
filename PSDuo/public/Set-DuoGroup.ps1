
function Set-DuoGroup() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $true)]
        [String]$group_id,
        [parameter(Mandatory = $false)]
        [String]$user_id
    )
    [string]$method = "POST"
    [string]$path = "/admin/v1/users/$user_id/groups"

    
    $APiParams = $MyInvocation.BoundParameters
    $MyInvocation.BoundParameters.Remove('user_id')

    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $APiParams
    $Response = Invoke-RestMethod @DuoRequest
    If ($Response.stat -ne 'OK') {
        Write-Warning 'DUO REST Call Failed'
        Write-Warning ($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
        #Write-Warning $Error | select * | Out-String
    }   
    $Output = $Response | Select-Object -ExpandProperty Response 
    $Output
}