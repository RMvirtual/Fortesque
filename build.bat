@ECHO OFF
REM Builds and runs the solution.
CLS

REM Build executable.
SET msBuildFolder="%LOCALAPPDATA%\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin"

IF "%~1" == "" (%msBuildFolder%\MSBuild.exe Fortesque.sln >> NUL) ^
ELSE (%msBuildFolder%\MSBuild.exe Fortesque.sln)

REM Run executable.
PUSHD x64\Debug
Fortesque.exe
POPD