@echo off
setlocal
cd /d "%~dp0"
if not exist "bin\BMP2AQV41.exe" (
  echo The preserved executable is local-only. See README.md and ..\Releases.
  pause
  exit /b 1
)
start "" "%~dp0bin\BMP2AQV41.exe"
