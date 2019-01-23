$moduleRoot = Resolve-Path "$PSScriptRoot\.."
$moduleName = Split-Path $moduleRoot -Leaf

Describe "General project validation: PSDUO" -Tags @("Unit") {
    $PowerShellFile = Get-ChildItem $moduleRoot -Include *.ps1 -Exclude *scripts* ,*tests* -Recurse
    #$PesterTests = Get-ChildItem $moduleRoot\..\tests\

    # TestCases are splatted to the script so we need hashtables
    $testCase = $PowerShellFile | Foreach-Object {@{file = $_}}
    It "Script <file> should be valid powershell" -TestCases $testCase {
        param($file)
        $file.fullname | Should Exist
        $contents = Get-Content -Path $file.fullname -ErrorAction Stop
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should Be 0
    }
    # $testCase = $PowerShellFile | Foreach-Object {@{file = $_}}
    # It "Script <file> should have a Pester Test powershell" -TestCases $testCase {
    #     param($file)
    #     Test-Path "$moduleRoot\Tests\$($file.basename).tests.ps1" | Should be $true
    # }
}
