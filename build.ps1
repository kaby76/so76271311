# Generated from trgen 0.20.22
function rmrf([string]$Path) {
    try {
        Remove-Item -Recurse -ErrorAction:Stop $Path
    } catch [System.Management.Automation.ItemNotFoundException] {
        # Ignore
        $Error.Clear()
    }
}

if (Test-Path -Path transformGrammar.py -PathType Leaf) {
    $(& python3 transformGrammar.py ) 2>&1 | Write-Host
}

rmrf('build')
New-Item -Path 'build' -ItemType Directory
Set-Location 'build'

$(& cmake .. -G "Visual Studio 17 2022" -A x64 ; $compile_exit_code = $LASTEXITCODE ) | Write-Host
if($compile_exit_code -ne 0){
    Write-Host "Failed first cmake call $compile_exit_code."
    exit $compile_exit_code
}

$(& cmake --build . --config Release ; $compile_exit_code = $LASTEXITCODE ) | Write-Host
if($compile_exit_code -ne 0){
    Write-Host "Failed second cmake call $compile_exit_code."
    exit $compile_exit_code
}
exit $compile_exit_code
