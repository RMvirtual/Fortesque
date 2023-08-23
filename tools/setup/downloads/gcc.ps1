$outputFolder = "$env:DEVENV\devenv"
$url = "https://github.com/brechtsanders/winlibs_mingw/releases/download/13.2.0-16.0.6-11.0.0-ucrt-r1/winlibs-x86_64-posix-seh-gcc-13.2.0-llvm-16.0.6-mingw-w64ucrt-11.0.0-r1.zip"

if (-Not (Test-Path $outputFolder)) {
    New-Item $outputFolder -ItemType Directory > $null
}

Invoke-WebRequest -Uri $url -OutFile "$outputFolder\compiler.zip"
Expand-Archive -Path "$outputFolder\compiler.zip" -DestinationPath "$env:DEVENV\devenv"
