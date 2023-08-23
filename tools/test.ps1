$TARGET = "$env:DEVENV\build\tests"


Push-Location $TARGET
./all_tests.exe
Pop-Location
