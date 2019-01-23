# if(-not $PSScriptRoot)
# {
#     $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
# }

# Import-Module $PSScriptRoot\..\PSDUO\PSDUO.PSM1 -Verbose -Force -ErrorAction SilentlyContinue

# Describe "ConvertTo-DUORequest"{
#     Context "DuoMethodPath" {
#         It "Should be throw an error if $null" {
#             ConvertTo-DUORequest -APIParams "/admin/v1/users" -method "GET" | Should Throw
#         }
#         It "Should be throw an error if $null" {
#             ConvertTo-DUORequest -DuoMethodPath "" -APIParams "/admin/v1/users" -method "GET" | Should Throw
#         }
#     }
# }