function Remove-Duophone(){
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $true,
        ValueFromPipelineByPropertyName = $true)]
        [String]$phone_id
    )
    [string]$method = "Delete"
    [string]$path = "/admin/v1/phones/$phone_id"
      #$ApiParams = $MyInvocation.BoundParameters

    $DuoRequest = Convertto-DUORequest -DuoMethodPath $path -Method $method -ApiParams $ApiParams
    $Response = Invoke-RestMethod @DuoRequest
    If($Response.stat -ne 'OK'){
        Write-Warning 'DUO REST Call Failed'
        Write-Warning ($APiParams | Out-String)
        Write-Warning "Method:$method    Path:$path"
    }   
    $Output = $Response | Select-Object -ExpandProperty Response
    $Output
}