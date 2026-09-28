@echo off
setlocal
cd /d "%~dp0"
set "FBC=C:\WinFBE_Suite\toolchains\FreeBASIC-1.10.0-winlibs-gcc-9.3.0\fbc32.exe"
if not "%~1"=="" set "FBC=%~1"
if not exist "%FBC%" (
  echo Compiler not found: "%FBC%"
  echo Usage: build_converter.cmd [path-to-fbc32.exe]
  exit /b 1
)
if not exist "build" mkdir "build"
echo Compiler: "%FBC%"
echo Source: "%CD%\BMP2AQV41.bas"
echo Output: "%CD%\build\BMP2AQV41.exe"
"%FBC%" "BMP2AQV41.bas" -s gui -x "build\BMP2AQV41.exe"
if errorlevel 1 exit /b 1
echo Build succeeded.
