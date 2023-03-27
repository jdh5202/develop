@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
setlocal enabledelayedexpansion

:INPUT
cls
echo 1. 드라이브 숨김
echo 2. 드라이브 숨김 해제
echo 3. 프로그램 종료
set /p select= : 
cls

if %select% == 1 ( 

echo 1. 특정 드라이브 숨김
echo 2. C드라이브를 제외한 모든 드라이브 숨김
set /p select2= : 
cls

if !select2! == 1 (

echo 숨길 드라이브를 대문자로 입력하세요.
set /p drive_char=  : 

for /F "tokens=3" %%G IN ('reg query "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" 2^> nul') do set reg=%%G

for /L %%a in (65,1,122) do (
  cmd /c exit %%a
  if "!=exitcodeAscii!" EQU "!drive_char!" set dc=%%a
)
set /a dc=!dc!-65

for /f "delims=" %%A in ('powershell -command "[math]::pow(2,!dc!)"') do (set dc=%%A)
if !drive_char! == A set dc=1
set /a result=!reg!+dc
echo !result!

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDrives" /d "!result!" /t REG_DWORD /reg:32 /f
taskkill /F /IM explorer.exe & start C:\Windows\explorer.exe

set dc=
set result=
set reg=
)

if !select2! == 2 (
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDrives" /d "67108856" /t REG_DWORD /reg:32 /f
taskkill /F /IM explorer.exe & start C:\Windows\explorer.exe
)

) else if %select% == 2 ( 
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f
taskkill /F /IM explorer.exe & start C:\Windows\explorer.exe
) else if %select% == 3 ( exit ) else ( goto INPUT )

echo.
echo 계속하려면 Any 키를 누르세요.
pause > nul
goto INPUT
