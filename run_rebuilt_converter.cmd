@echo off
setlocal
call "%~dp0build_converter.cmd" %*
if errorlevel 1 (
  pause
  exit /b 1
)
cd /d "%~dp0"
start "" "%~dp0build\BMP2AQV41.exe"
