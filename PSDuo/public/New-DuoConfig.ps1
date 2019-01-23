<#
.Synopsis
   DUO REST API Configuration
.DESCRIPTION
   Sets the default configuration for PSDUO with and option to save it.
.EXAMPLE
   New-DUOConfig -ikey SDFJASKLDFJASLKDJ -sKey ASDKLFJSM<NVCIWJRFKSDM<>SMVNFNSKLF -apiHost api-###XXX###.duosecurity.com
   Generate a module scoped variable for DUO's REST API
.EXAMPLE
   New-DUOConfig -ikey SDFJASKLDFJASLKDJ -sKey ASDKLFJSM<NVCIWJRFKSDM<>SMVNFNSKLF -apiHost api-###XXX###.duosecurity.com -SaveConfig
   Generates the global variable for DUO's REST API
.OUTPUTS
   [PSCustomObject]$DuoConfig
.NOTES
   
.COMPONENT
   PSDuo
.ROLE
   
.FUNCTIONALITY
   
#>
function New-DuoConfig() {
    [CmdletBinding(
    )]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$iKey,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$sKey,
        
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$apiHost,

        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [Switch]$SaveConfig

    )
    $script:DuoConfig = @{
        iKey    = $iKey | ConvertTo-SecureString -AsPlainText -Force
        sKey    = $sKey | ConvertTo-SecureString -AsPlainText -Force
        apiHost = $apiHost | ConvertTo-SecureString -AsPlainText -Force
    }
}