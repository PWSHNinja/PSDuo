function Invoke-DuoPreAuth() {
    [CmdletBinding(
    )]
    param
    (
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$user_id,
        [parameter(Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [String]$username
    )
    [string]$method = "POST"
    [string]$path = "/auth/v2/preauth"
    $ApiParams = $MyInvocation.BoundParameters

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