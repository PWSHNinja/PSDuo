function Set-Duouser(){
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [String]$user_id,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$username,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$alias1,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$alias2,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$alias3,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$alias4,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$realname,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$email,
        [parameter(Mandatory = $false,
        ValueFromPipelineByPropertyName = $true)]
        [String]$notes
    )
    [string]$method = "POST"
    [string]$path = "/admin/v1/users/$user_id"
    $MyInvocation.BoundParameters.Remove('user_id')
    $ApiParams = $MyInvocation.BoundParameters

    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    $Response = Invoke-RestMethod @DuoRequest
    If($Response.stat -ne 'OK'){
       Write-Warning 'DUO REST Call Failed'
       Write-Warning ($APiParams | Out-String)
       Write-Warning "Method:$method    Path:$path"
    }   
    $Output = $Response | Select-Object -ExpandProperty Response
    Write-Output $Output
}

