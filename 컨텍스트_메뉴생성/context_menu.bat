@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
setlocal enabledelayedexpansion
 
:INPUT
cls
echo 1. 컨텍스트 메뉴 조회
echo 2. 컨텍스트 메뉴 추가
echo 3. 컨텍스트 메뉴 삭제
echo 4. 하위 컨텍스트 메뉴 추가
echo 5. 레지스트리 편집창 이동
echo 6. 프로그램 종료
set /p select= : 
cls
 
if %select% == 1 ( 
reg query "HKEY_CLASSES_ROOT\*\shell"
echo.
echo "<하위 컨텍스트 조회>"
set /p context_menu_name1=  상위 컨텍스트 메뉴명 :
echo.
reg query "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\shell"

) else if %select% == 2 ( 
 
set /p context_menu_name=  1. 추가할 컨텍스트 메뉴명 : 
set /p execute_file_name=  2. 실행 파일명 : 

set /p c_hotkey=  단축키 등록 여부 y,n: 

if !c_hotkey! == y (
set /p c_hk= 단축키 : 
echo.
reg add "HKEY_CLASSES_ROOT\*\shell\!context_menu_name!" /v "MUIVerb" /d "!context_menu_name!(&!c_hk!)" /f
)

reg add "HKEY_CLASSES_ROOT\*\shell\!context_menu_name!\command" /d "!execute_file_name!" /f
 
) else if %select% == 3 ( 
reg query "HKEY_CLASSES_ROOT\*\shell"
set /p context_menu_name=  삭제할 컨텍스트 메뉴명 :
reg delete "HKEY_CLASSES_ROOT\*\shell\!context_menu_name!" /f
 
) else if %select% == 4 ( 
reg query "HKEY_CLASSES_ROOT\*\shell"
set /p context_menu_name1=  상위 컨텍스트 메뉴명 :
set /p context_menu_name2=  하위 컨텍스트 메뉴명 :
set /p execute_file_name=  실행 파일명 :
set /p hotkey=  단축키 등록 여부 y,n: 

if !hotkey! == y (
set /p hk= 단축키 : 
echo.
reg add "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\shell\!context_menu_name2!" /v "MUIVerb" /d "!context_menu_name2!(&!hk!)" /f
)
reg delete "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\command" /f >Nul 2>&1
reg add "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!" /v "SubCommands" /f
reg add "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\shell\!context_menu_name2!\command" /d "!execute_file_name!" /f
 
echo.
echo "<hotkey>"
for /F "tokens=3" %%G IN ('reg query "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\shell\!context_menu_name2!" /v "MUIVerb"') do echo %%G
echo "<execute>"
for /F "tokens=3" %%G IN ('reg query "HKEY_CLASSES_ROOT\*\shell\!context_menu_name1!\shell\!context_menu_name2!\command"') do echo %%G

set var=
set context_menu_name1=
set context_menu_name2=
set execute_file_name=
set hotkey=
set hk=


) else if %select% == 5 ( 

set showkey="HKEY_CLASSES_ROOT\*\shell"
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /v "LastKey" /d "!showkey!" /f 
start "" regedit

) else if %select% == 6 ( exit ) else ( goto INPUT )

echo.
echo 계속하려면 Any 키를 누르세요.
pause > nul
goto INPUT
