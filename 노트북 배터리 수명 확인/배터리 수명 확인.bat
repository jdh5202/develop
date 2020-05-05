@echo off
color 0a
bcdedit > nul || (echo 우클릭 하여 관리자 권한으로 실행하세요. & pause & exit)

echo "배터리 점검을 시작합니다."
cd %USERPROFILE%\desktop
powercfg.exe -energy
energy-report.html
pause > nul