$LIB = "$env:DEVENV\lib"
$TARGET = "$LIB\googletest"
$URL = "https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip"

$extractedZip = "$LIB\googletest-1.14.0"

if (Test-Path $TARGET) {Remove-Item $TARGET -Recurse -Force > $null}
if (Test-Path $zipFile) {Remove-Item $zipFile -Recurse -Force > $null}

if (Test-Path $extractedZip) {
    Remove-Item $extractedZip -Recurse -Force > $null
}

# Download source code.
$zipFile = "$LIB\googletest.zip"
Invoke-WebRequest -Uri $URL -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath $DEVENV
Rename-Item $extractedZip $TARGET > $null
Remove-Item $zipFile > $null


# Compile.
Push-Location $TARGET

$nestedTARGET = "$TARGET\googletest"
& g++.exe -std=c++17 -isystem "$nestedTARGET/include" -I"$nestedTARGET" -pthread -c "$nestedTARGET/src/gtest-all.cc"

Pop-Location
