<#
.Synopsis
   Return the DUO REST API Configuration Settings
.DESCRIPTION
   Gets the default configuration for PSDUO.
.EXAMPLE
   Get-DuoConfig 
   Returns the Config for the current DUO Session.
.OUTPUTS
   [PSCustomObject]$DuoConfig
.NOTES
   
.COMPONENT
   PSDuo
.ROLE
   
.FUNCTIONALITY
   
#>
function Get-DuoConfig() {
    [CmdletBinding(
    )]
    param()
    If (!($Script:DuoConfig)) {
        Write-Warning "Please set up a DUO Configuration via New-DuoConfig cmdlet"
    }
    Write-Output $Script:DuoConfig
}