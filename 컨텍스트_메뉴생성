@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
setlocal enabledelayedexpansion

:INPUT
cls
echo 1. 컨텍스트 메뉴 추가(1)
echo 2. 컨텍스트 메뉴 삭제(2)
echo 3. 프로그램 종료
set /p select= : 
cls

if %select% == 1 ( 

set /p context_menu_name=  1. 추가할 컨텍스트 메뉴명 : 
set /p execute_file_name=  2. 실행 파일명 : 

reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\!context_menu_name!\command" /d "!execute_file_name!" /f

) else if %select% == 2 ( 
set /p context_menu_name=  삭제할 컨텍스트 메뉴명 :
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\!context_menu_name!" /f

) else if %select% == 3 ( exit ) else ( goto INPUT )

echo.
echo 계속하려면 Any 키를 누르세요.
pause > nul
goto INPUT
