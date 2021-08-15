@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
pushd "%~dp0"
mkdir "C:\Tools"
move "register_hotkey.exe" "C:\Tools"
move "Saved File.INI" "C:\Tools"
mklink "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\register_hotkey link.lnk" "C:\Tools\register_hotkey.exe"
"C:\Tools\register_hotkey.exe"