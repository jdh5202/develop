Gui, Add, Edit, x162 y106 w390 h20 vMV_FPATH, %A_scriptDir%
IfExist, m3u8_scr.INI
{
iniRead, dirpth_var, m3u8_scr.ini, Section, dirpth
GuiControl,,MV_FPATH,%dirpth_var%
}


Gui, Add, Button, x562 y102 w60 h25 gPat, 선택
Gui, Add, Text, x42 y65 w50 h0 , Text
Gui, Add, Text, x22 y69 w130 h20 , m3u8 영상 링크 주소
Gui, Add, Text, x262 y29 w150 h20 , m3u8 영상 추출 스크립트
Gui, Add, Text, x22 y109 w130 h20 , 동영상 저장 폴더
Gui, Add, Text, x22 y149 w130 h20 , 동영상 파일 이름
Gui, Add, Edit, x162 y66 w390 h20 vm3u8_LK, 

Gui, Add, Edit, x162 y146 w390 h20 vFname, file_name
Gui, Add, Button, x292 y189 w80 h30 gExtract, 영상추출
GuiControl, Disable, MV_FPATH
GuiControl, focus, m3u8_LK

SendInput,^v{Enter}

; Generated using SmartGUI Creator 4.0
Gui, Show, x525 y248 h229 w657, m3u8 영상 추출 스크립트

Return

GuiClose:
Gui,Submit,nohide
IniWrite, %MV_FPATH%, m3u8_scr.ini, Section, dirpth
ExitApp


Pat:
{  
    FileSelectFolder,MV_FPATH

    IniWrite, %MV_FPATH%, m3u8_scr.ini, Section, dirpth
    if (!MV_FPATH)
    {
        MV_FPATH = C:\Users\%A_USERNAME%\Desktop
    }

    GuiControl,,MV_FPATH,%MV_FPATH%
   return
}

Extract:
{ 
Gui,Submit,nohide

   Run, %comspec% /c cd "%MV_FPATH%" & ffmpeg -i "%m3u8_LK%" -c copy "%Fname%.ts"
  return
}

ini_rd:
{
Gui,Submit,nohide
iniRead, dirpth_var, m3u8_scr.ini, dirpth
msgbox %dirpth_var%
return
}
