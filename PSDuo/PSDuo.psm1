# $Script:DUOConfigPath = Join-Path -Path $ENV:ProgramData -ChildPath PSDuo
# If (!(Test-Path -Path $DUOConfigPath)) {
#     Write-Warning 'No DUO cofiguration file found - Please use New-DuoConfig to generate a config'
# }
#Try {$script:DuoConfig = Import-Clixml -Path $DUOConfigPath\DuoConfig.clixml}
#Catch {$_ | Out-Null}

# Gather all files
$PublicFunctions = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$PrivateFunctions = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the functions
#ForEach ($File in $PublicFunctions) {
ForEach ($File in @($PublicFunctions + $PrivateFunctions)) {
    Try {
        Write-Verbose "Importing $File.Basename"
        . $File.FullName
    }
    Catch {
        Write-Error -Message "Failed to import function $($File.FullName): $_"
    }
}