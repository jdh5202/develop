@echo off
color 0a
bcdedit > nul || (echo ��Ŭ�� �Ͽ� ������ �������� �����ϼ���. & pause & exit)

echo "���͸� ������ �����մϴ�."
cd %USERPROFILE%\desktop
powercfg.exe -energy
energy-report.html
pause > nul