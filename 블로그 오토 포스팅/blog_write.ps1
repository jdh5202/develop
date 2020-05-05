<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>
# Set-ExecutionPolicy Unrestricted

 

$fullPathIncFileName = $MyInvocation.MyCommand.Definition # Script 파일의 full path
$currentScriptName = $MyInvocation.MyCommand.Name # Script 파일 이름
$Default_path = $fullPathIncFileName.Replace($currentScriptName, "") # Script 폴더

$account_csv  = $Default_path + 'blog_write_acc.csv'
$setting_csv  = $Default_path + 'blog_write_set.csv'
$save_cli_txt  = $Default_path + 'blog_write_cli.txt'

$cur_acctok   = ''
$cur_blogadr  = ''
$suc_count_post  = 0
$fail_count_post = 0

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '890,695'
$Form.text                       = "blog_auto_write"
$Form.TopMost                    = $false
$Form.MaximizeBox                = $false
$Form.AutoSizeMode               = "GrowAndShrink"

$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$Form.StartPosition              = $CenterScreen; 

 
$bt_conn_kip                   = New-Object system.Windows.Forms.Button
$bt_conn_kip.text              = "kipris 접속"
$bt_conn_kip.width             = 100
$bt_conn_kip.height            = 30
$bt_conn_kip.location          = New-Object System.Drawing.Point(186,5)
$bt_conn_kip.Font              = 'Microsoft Sans Serif,10'
 
$bt_start_down                   = New-Object system.Windows.Forms.Button
$bt_start_down.text              = "파일 추출"
$bt_start_down.width             = 83
$bt_start_down.height            = 30
$bt_start_down.location          = New-Object System.Drawing.Point(10,197)
$bt_start_down.Font              = 'Microsoft Sans Serif,10'

$bt_naming                      = New-Object system.Windows.Forms.Button
$bt_naming.text                 = "네이밍"
$bt_naming.width                = 83
$bt_naming.height               = 30
$bt_naming.location             = New-Object System.Drawing.Point(105,197)
$bt_naming.Font                 = 'Microsoft Sans Serif,10'

$bt_del_pdf                      = New-Object system.Windows.Forms.Button
$bt_del_pdf.text                 = "pdf 삭제"
$bt_del_pdf.width                = 83
$bt_del_pdf.height               = 30
$bt_del_pdf.location             = New-Object System.Drawing.Point(194,197)
$bt_del_pdf.Font                 = 'Microsoft Sans Serif,10'


$tb_export_list                        = New-Object system.Windows.Forms.RichTextbox
$tb_export_list.WordWrap               = $false 
$tb_export_list.width                  = 100
$tb_export_list.height                 = 90
$tb_export_list.location               = New-Object System.Drawing.Point(96,35)
$tb_export_list.Font                   = 'Microsoft Sans Serif,10'


$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "출원번호 리스트"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(95,14)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$pb_upload_process               = New-Object system.Windows.Forms.ProgressBar
$pb_upload_process.width         = 418
$pb_upload_process.height        = 29
$pb_upload_process.location      = New-Object System.Drawing.Point(43,267)

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "1. 자료 필터링"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(18,16)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "2. 저작권 소멸 자료 추출"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(12,81)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$tb_export_num                        = New-Object system.Windows.Forms.TextBox
$tb_export_num.multiline              = $false
$tb_export_num.width                  = 68
$tb_export_num.height                 = 40
$tb_export_num.location               = New-Object System.Drawing.Point(192,78)
$tb_export_num.Font                   = 'Microsoft Sans Serif,10' 


$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "개"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(268,81)
$Label5.Font                     = 'Microsoft Sans Serif,10'

$Panel1                          = New-Object system.Windows.Forms.Panel
$Panel1.height                   = 143
$Panel1.width                    = 296
$Panel1.location                 = New-Object System.Drawing.Point(9,19)

$Panel2                          = New-Object system.Windows.Forms.Panel
$Panel2.height                   = 232
$Panel2.width                    = 291
$Panel2.location                 = New-Object System.Drawing.Point(13,31)

$tb_account_act                  = New-Object system.Windows.Forms.TextBox
$tb_account_act.multiline        = $false
$tb_account_act.width            = 100
$tb_account_act.height           = 20
$tb_account_act.location         = New-Object System.Drawing.Point(93,0)
$tb_account_act.Font             = 'Microsoft Sans Serif,10'

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "액세스 토큰"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(8,2)
$Label9.Font                     = 'Microsoft Sans Serif,10'

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "주소(http 제외)"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(0,29)
$Label10.Font                    = 'Microsoft Sans Serif,9'

$tb_account_adr                  = New-Object system.Windows.Forms.TextBox
$tb_account_adr.multiline        = $false
$tb_account_adr.width            = 191
$tb_account_adr.height           = 20
$tb_account_adr.location         = New-Object System.Drawing.Point(93,24)
$tb_account_adr.Font             = 'Microsoft Sans Serif,10'


$bt_account_reg                  = New-Object system.Windows.Forms.Button
$bt_account_reg.text             = "새 계정 등록"
$bt_account_reg.width            = 97
$bt_account_reg.height           = 30
$bt_account_reg.location         = New-Object System.Drawing.Point(105,47)
$bt_account_reg.Font             = 'Microsoft Sans Serif,10'

$bt_requ_reg                     = New-Object system.Windows.Forms.Button
$bt_requ_reg.text                = "토큰 발급"
$bt_requ_reg.width               = 87
$bt_requ_reg.height              = 27
$bt_requ_reg.location            = New-Object System.Drawing.Point(35,110)
$bt_requ_reg.Font                = 'Microsoft Sans Serif,10'

$bt_tok_chg                        = New-Object system.Windows.Forms.Button
$bt_tok_chg.text                   = "토큰 수정"
$bt_tok_chg.width                  = 87
$bt_tok_chg.height                 = 27
$bt_tok_chg.location               = New-Object System.Drawing.Point(145,110)
$bt_tok_chg.Font                   = 'Microsoft Sans Serif,10'


$li_account_list                 = New-Object system.Windows.Forms.ComboBox
$li_account_list.text            = "보기"
$li_account_list.width           = 150
$li_account_list.height          = 20
$li_account_list.location        = New-Object System.Drawing.Point(98,80)
$li_account_list.Font            = 'Microsoft Sans Serif,10'
$li_account_list.DropDownStyle   = 'DropDownList'


$Label12                         = New-Object system.Windows.Forms.Label
$Label12.text                    = "계정 목록"
$Label12.AutoSize                = $true
$Label12.width                   = 25
$Label12.height                  = 10
$Label12.location                = New-Object System.Drawing.Point(16,82)
$Label12.Font                    = 'Microsoft Sans Serif,10'

$Panel3                          = New-Object system.Windows.Forms.Panel
$Panel3.height                   = 139
$Panel3.width                    = 286
$Panel3.location                 = New-Object System.Drawing.Point(14,26)


$tb_post_title                   = New-Object system.Windows.Forms.TextBox
$tb_post_title.multiline         = $false
$tb_post_title.width             = 251
$tb_post_title.height            = 20
$tb_post_title.location          = New-Object System.Drawing.Point(125,161)
$tb_post_title.Font              = 'Microsoft Sans Serif,10'
$tb_post_title.ReadOnly          = $true

$Label14                         = New-Object system.Windows.Forms.Label
$Label14.text                    = "게시물 제목"
$Label14.AutoSize                = $true
$Label14.width                   = 25
$Label14.height                  = 10
$Label14.location                = New-Object System.Drawing.Point(41,164)
$Label14.Font                    = 'Microsoft Sans Serif,10'

$Label15                         = New-Object system.Windows.Forms.Label
$Label15.text                    = "업로드 성공"
$Label15.AutoSize                = $true
$Label15.width                   = 25
$Label15.height                  = 10
$Label15.location                = New-Object System.Drawing.Point(39,193)
$Label15.Font                    = 'Microsoft Sans Serif,10'

$Label17                         = New-Object system.Windows.Forms.Label
$Label17.text                    = "업로드 실패"
$Label17.AutoSize                = $true
$Label17.width                   = 25
$Label17.height                  = 10
$Label17.location                = New-Object System.Drawing.Point(40,216)
$Label17.Font                    = 'Microsoft Sans Serif,10'

$tb_upload_suc                   = New-Object system.Windows.Forms.TextBox
$tb_upload_suc.multiline         = $false
$tb_upload_suc.width             = 60
$tb_upload_suc.height            = 20
$tb_upload_suc.location          = New-Object System.Drawing.Point(126,190)
$tb_upload_suc.Font              = 'Microsoft Sans Serif,10'
$tb_upload_suc.ReadOnly          = $true

$tb_upload_fail                  = New-Object system.Windows.Forms.TextBox
$tb_upload_fail.multiline        = $false
$tb_upload_fail.width            = 60
$tb_upload_fail.height           = 20
$tb_upload_fail.location         = New-Object System.Drawing.Point(127,215)
$tb_upload_fail.Font             = 'Microsoft Sans Serif,10'
$tb_upload_fail.ReadOnly         = $true


$Label18                         = New-Object system.Windows.Forms.Label
$Label18.text                    = "업로드할 파일 개수"
$Label18.AutoSize                = $true
$Label18.width                   = 25
$Label18.height                  = 10
$Label18.location                = New-Object System.Drawing.Point(7,70)
$Label18.Font                    = 'Microsoft Sans Serif,10'

$tb_upload_files                 = New-Object system.Windows.Forms.TextBox
$tb_upload_files.multiline       = $false
$tb_upload_files.BackColor       = "#f8e71c"
$tb_upload_files.width           = 64
$tb_upload_files.height          = 20
$tb_upload_files.location        = New-Object System.Drawing.Point(141,68)
$tb_upload_files.Font            = 'Microsoft Sans Serif,10'

$Label19                         = New-Object system.Windows.Forms.Label
$Label19.text                    = "작업 디렉터리"
$Label19.AutoSize                = $true
$Label19.width                   = 25
$Label19.height                  = 10
$Label19.location                = New-Object System.Drawing.Point(37,19)
$Label19.Font                    = 'Microsoft Sans Serif,10'

$tb_write_workdir                = New-Object system.Windows.Forms.TextBox
$tb_write_workdir.multiline      = $false
$tb_write_workdir.width          = 301
$tb_write_workdir.height         = 20
$tb_write_workdir.location       = New-Object System.Drawing.Point(139,13)
$tb_write_workdir.Font           = 'Microsoft Sans Serif,10'
$tb_write_workdir.ReadOnly       = $true

$bt_write_workdir                = New-Object system.Windows.Forms.Button
$bt_write_workdir.text           = "선택"
$bt_write_workdir.width          = 47
$bt_write_workdir.height         = 27
$bt_write_workdir.location       = New-Object System.Drawing.Point(447,9)
$bt_write_workdir.Font           = 'Microsoft Sans Serif,10'

$bt_write_exec                  = New-Object system.Windows.Forms.Button
$bt_write_exec.text             = "실행"
$bt_write_exec.width            = 97
$bt_write_exec.height           = 25
$bt_write_exec.location         = New-Object System.Drawing.Point(202,240)
$bt_write_exec.Font             = 'Microsoft Sans Serif,10'

$Label20                         = New-Object system.Windows.Forms.Label
$Label20.text                    = "파일 보유 개수"
$Label20.AutoSize                = $true
$Label20.width                   = 25
$Label20.height                  = 10
$Label20.location                = New-Object System.Drawing.Point(33,43)
$Label20.Font                    = 'Microsoft Sans Serif,10'

$tb_exist_file                   = New-Object system.Windows.Forms.TextBox
$tb_exist_file.multiline         = $false
$tb_exist_file.width             = 67
$tb_exist_file.height            = 20
$tb_exist_file.location          = New-Object System.Drawing.Point(140,40)
$tb_exist_file.Font              = 'Microsoft Sans Serif,10'
$tb_exist_file.ReadOnly          = $true


$li_select_account               = New-Object system.Windows.Forms.ComboBox
$li_select_account.text          = "보기"
$li_select_account.BackColor     = "#f5a623"
$li_select_account.width         = 150
$li_select_account.height        = 20
$li_select_account.location      = New-Object System.Drawing.Point(137,95)
$li_select_account.Font          = 'Microsoft Sans Serif,10'
$li_select_account.DropDownStyle = 'DropDownList'

$tb_wait_post                   = New-Object system.Windows.Forms.TextBox
$tb_wait_post.multiline         = $false
$tb_wait_post.BackColor         = "#f5a623"
$tb_wait_post.width             = 67
$tb_wait_post.height            = 20
$tb_wait_post.location          = New-Object System.Drawing.Point(137,125)
$tb_wait_post.Font              = 'Microsoft Sans Serif,10'

$tb_mwait_post                   = New-Object system.Windows.Forms.TextBox
$tb_mwait_post.multiline         = $false
$tb_mwait_post.BackColor         = "#f5a623"
$tb_mwait_post.width             = 67
$tb_mwait_post.height            = 20
$tb_mwait_post.location          = New-Object System.Drawing.Point(243,125)
$tb_mwait_post.Font              = 'Microsoft Sans Serif,10'


$tb_wri_category                   = New-Object system.Windows.Forms.TextBox
$tb_wri_category.multiline         = $false
$tb_wri_category.width             = 67
$tb_wri_category.height            = 20
$tb_wri_category.location          = New-Object System.Drawing.Point(318,66)
$tb_wri_category.Font              = 'Microsoft Sans Serif,10'


$Label34                         = New-Object system.Windows.Forms.Label
$Label34.text                    = "카테고리 id(번호)"
$Label34.AutoSize                = $true
$Label34.width                   = 35
$Label34.height                  = 10
$Label34.location                = New-Object System.Drawing.Point(219,70)
$Label34.Font                    = 'Microsoft Sans Serif,8'



$Label31                         = New-Object system.Windows.Forms.Label
$Label31.text                    = "대기 시간(초)"
$Label31.AutoSize                = $true
$Label31.width                   = 25
$Label31.height                  = 10
$Label31.location                = New-Object System.Drawing.Point(39,130)
$Label31.Font                    = 'Microsoft Sans Serif,10'

$label32                         = New-Object system.Windows.Forms.Label
$label32.text                    = "-"
$label32.AutoSize                = $true
$label32.width                   = 25
$label32.height                  = 10
$label32.location                = New-Object System.Drawing.Point(218,130)
$label32.Font                    = 'Microsoft Sans Serif,10'

$Label16                         = New-Object system.Windows.Forms.Label
$Label16.text                    = "계정 선택"
$Label16.AutoSize                = $true
$Label16.width                   = 25
$Label16.height                  = 10
$Label16.location                = New-Object System.Drawing.Point(59,100)
$Label16.Font                    = 'Microsoft Sans Serif,10'

$Label21                         = New-Object system.Windows.Forms.Label
$Label21.text                    = "파일 저장 디렉터리"
$Label21.AutoSize                = $true
$Label21.width                   = 25
$Label21.height                  = 10
$Label21.location                = New-Object System.Drawing.Point(70,137)
$Label21.Font                    = 'Microsoft Sans Serif,10'

$tb_naming_workdir                       = New-Object system.Windows.Forms.TextBox
$tb_naming_workdir.multiline             = $false
$tb_naming_workdir.width                 = 258
$tb_naming_workdir.height                = 20
$tb_naming_workdir.location              = New-Object System.Drawing.Point(19,161)
$tb_naming_workdir.Font                  = 'Microsoft Sans Serif,10'
$tb_naming_workdir.ReadOnly              = $true


$bt_fdown_workdir                = New-Object system.Windows.Forms.Button
$bt_fdown_workdir.text           = "선택"
$bt_fdown_workdir.width          = 45
$bt_fdown_workdir.height         = 24
$bt_fdown_workdir.location       = New-Object System.Drawing.Point(202,129)
$bt_fdown_workdir.Font           = 'Microsoft Sans Serif,10'

$Label22                         = New-Object system.Windows.Forms.Label
$Label22.AutoSize                = $true
$Label22.width                   = 25
$Label22.height                  = 10
$Label22.location                = New-Object System.Drawing.Point(210,41)
$Label22.Font                    = 'Microsoft Sans Serif,16'

$Label35                         = New-Object system.Windows.Forms.Label
$Label35.text                    = "저장용"
$Label35.AutoSize                = $true
$Label35.width                   = 25
$Label35.height                  = 10
$Label35.location                = New-Object System.Drawing.Point(430,17)
$Label35.Font                    = 'Microsoft Sans Serif,16'


$Panel4                          = New-Object system.Windows.Forms.Panel
$Panel4.height                   = 303
$Panel4.width                    = 506
$Panel4.location                 = New-Object System.Drawing.Point(10,16)

$Groupbox1                       = New-Object system.Windows.Forms.Groupbox
$Groupbox1.height                = 167
$Groupbox1.width                 = 308
$Groupbox1.text                  = "① 자료 검색 - kipris"
$Groupbox1.location              = New-Object System.Drawing.Point(19,39)

$Groupbox2                       = New-Object system.Windows.Forms.Groupbox
$Groupbox2.height                = 270
$Groupbox2.width                 = 329
$Groupbox2.text                  = "② 파일 다운 및 네이밍"
$Groupbox2.location              = New-Object System.Drawing.Point(13,223)

$Groupbox3                       = New-Object system.Windows.Forms.Groupbox
$Groupbox3.height                = 172
$Groupbox3.width                 = 310
$Groupbox3.text                  = "③ 계정 정보 등록"
$Groupbox3.location              = New-Object System.Drawing.Point(13,503)

$Groupbox4                       = New-Object system.Windows.Forms.Groupbox
$Groupbox4.height                = 323
$Groupbox4.width                 = 519
$Groupbox4.text                  = "④ 글 등록"
$Groupbox4.location              = New-Object System.Drawing.Point(364,211)

$bt_jquery_copy1                 = New-Object system.Windows.Forms.Button
$bt_jquery_copy1.text            = "JQuery 코드 복사"
$bt_jquery_copy1.width           = 156
$bt_jquery_copy1.height          = 30
$bt_jquery_copy1.location        = New-Object System.Drawing.Point(17,37)
$bt_jquery_copy1.Font            = 'Microsoft Sans Serif,10'

$bt_jquery_copy2                 = New-Object system.Windows.Forms.Button
$bt_jquery_copy2.text            = "JQuery 코드 복사"
$bt_jquery_copy2.width           = 155
$bt_jquery_copy2.height          = 30
$bt_jquery_copy2.location        = New-Object System.Drawing.Point(18,106)
$bt_jquery_copy2.Font            = 'Microsoft Sans Serif,10'


$tb_empty_window                        = New-Object system.Windows.Forms.RichTextbox
$tb_empty_window.WordWrap               = $false 
$tb_empty_window.width                  = 300
$tb_empty_window.height                 = 200
$tb_empty_window.location               = New-Object System.Drawing.Point(516,15)
$tb_empty_window.Font                   = 'Microsoft Sans Serif,10'
$tb_empty_window.ForeColor             = "White"
$tb_empty_window.BackColor             = "Black"


$Panel2.controls.AddRange(@($bt_start_down,$bt_naming,$bt_del_pdf,$tb_export_list,$Label1,$Label21,$tb_naming_workdir,$bt_fdown_workdir))
$Panel4.controls.AddRange(@($tb_wri_category,$label34,$bt_write_exec,$pb_upload_process,$tb_post_title,$Label14,$Label15,$Label17,$tb_upload_suc,$tb_upload_fail,$Label18,$tb_upload_files,$Label19,$tb_write_workdir,$bt_write_workdir,$Label20,$tb_exist_file,$li_select_account,$Label16,$Label22,$Label31,$Label32,$tb_wait_post,$tb_mwait_post))
$Panel1.controls.AddRange(@($Label3,$Label4,$tb_export_num,$TextBox3,$bt_conn_kip,$Label5,$bt_jquery_copy1,$bt_jquery_copy2))
$Groupbox1.controls.AddRange(@($Panel1))
$Groupbox2.controls.AddRange(@($Panel2))
$Panel3.controls.AddRange(@($tb_account_act,$Label9,$Label10,$tb_account_adr,$bt_account_reg,$li_account_list,$Label12,$bt_requ_reg,$bt_tok_chg))
$Groupbox3.controls.AddRange(@($Panel3))
$Groupbox4.controls.AddRange(@($Panel4))
$Form.controls.AddRange(@($Groupbox1,$Groupbox2,$Groupbox3,$Groupbox4,$tb_empty_window,$Label35))


# jquery code copy
$bt_jquery_copy1.add_Click({

$jq1_path = $Default_path + 'search_jq1.txt'

$jqu = Get-Content $jq1_path -encoding utf8 
$jqu -replace 'this_value', $tb_export_num.Text | clip


})

$bt_jquery_copy2.add_Click({

$jq2_path = $Default_path + 'get_data_jq2.txt'
Get-Content $jq2_path -encoding utf8 | clip

})
# ----------------


# 2. 파일 네이밍 및 다운
$bt_start_down.add_Click({


    # 키프리스 pdf 파일 다운로드  -     #ex ) 2020050009587 2020000013314
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};

    $export_arr = $tb_export_list.Text -split '\n'

    $kipris_url_def = 'http://kipris.or.kr/kpat/'
    $kipris_part1 = '?method=fullText&applno='
    $kipris_part2 = '&pub_reg=R'
    
    if ( [String]::IsNullOrEmpty($tb_export_num.Text) -eq $false )
    {

        $export_arr = $export_arr[0..[Int]$tb_export_num.Text]

        foreach ( $item in $export_arr )
        {
            if ( [String]::IsNullOrEmpty($item) -eq $false )
            { 
            $kipris_data = $item
            $kipris_url = $kipris_url_def + ($kipris_data+'.pdf') + $kipris_part1 + $kipris_data + $kipris_part2
            (New-Object System.Net.WebClient).DownloadFile($kipris_url,$tb_naming_workdir.Text + '\' + $item + '.pdf')
            }
      
        }
        
        # 쓰레기 파일 정리
        Get-ChildItem -Filter *.pdf -Path $tb_naming_workdir.Text | Where-Object -FilterScript { $_.Length -lt 5KB } | Remove-Item
         

        $oRetrun=[System.Windows.Forms.MessageBox]::Show('파일을 추출하였습니다 알Pdf로 pdf를 텍스트로 변환하세요.',"완료",[System.Windows.Forms.MessageBoxButtons]::OKCancel) 
        if ( $oRetrun -eq "OK" ) { 
        Invoke-Item $tb_naming_workdir.Text; 
        $npdf_exec = ${env:ProgramFiles(x86)} + '\ESTsoft\ALPDF\ALPDF.exe'
        & $npdf_exec
        }
     } else { msg_box -str '자료 개수를 입력하세요' } 
    
    

})



$bt_naming.add_Click({



    $target_file = Get-ChildItem -Filter *.txt -Path $tb_naming_workdir.Text 
   
    if ( [String]::IsNullOrEmpty($target_file) -eq $false )
    {
        foreach ( $item in $target_file )
        { 

            
            # 파일 제목 따기

            # changed utf8 
            (Get-Content $item.FullName) | Set-Content -Encoding utf8 -Path $item.FullName
            $content = Get-Content -Path $item.FullName -Encoding utf8
            $title = ($content | Select-String "(54)")
            $tit_idx = 3

            if ( [String]::IsNullOrEmpty($title) -eq $false )
            {
                $title_idx = $title.Matches.Index

                if ( ($title_idx -is [array]) -eq $false)
                { 
                    $title = $title.ToString()
                    $title =  $title.Substring($title_idx+$tit_idx, $title.Length - $title_idx - $tit_idx )
                

                    if ( $title.Length -gt 90 ) # 파일명 길이 체크
                    {
                    $title = $title.Substring(0,90)
                    } 

                    $title = $title -replace '\W',' '

                    $title += '.txt'
                    $naming_tit = $item.DirectoryName + '\' + $title

                    if ( $item.FullName -ne $naming_tit )
                    { Rename-Item -Path $item.FullName $naming_tit -Force }

                  } 

             } 
       
        }
        $target_file | % { Remove-Item $_.FullName }

        $oRetrun=[System.Windows.Forms.MessageBox]::Show('네이밍이 완료되었습니다. 폴더를 열어보시겠습니까?',"완료",[System.Windows.Forms.MessageBoxButtons]::OKCancel) 
        if ( $oRetrun -eq "OK" ) { Invoke-Item $tb_naming_workdir.Text }
    } else { msg_box -str "txt 파일이 없습니다." }
    
})


$bt_del_pdf.add_Click({


       $target_file = Get-ChildItem -Filter *.pdf -Path $tb_naming_workdir.Text 
  
        foreach ( $item in $target_file )
        {
          Remove-Item -path $item.FullName
        }
        msg_box -str 'pdf를 모두 삭제하였습니다.'


})


# 3. 계정 생성 - csv 저장
$bt_account_reg.add_Click({

     
     
    if ( (($tb_account_act.Text -ne '') -and ($tb_account_adr.Text -ne '')) -eq $true ) {

            $blog_adr = $tb_account_adr.Text
            $dot_split = $blog_adr.indexof('.')
 
            if ( $dot_split -gt 0 )
            {

                if ( (Test-Path $account_csv) -eq $true )
                {
                    $header = $('acctok','blog_adr','cont_adr') -join ','
        
                    $report = New-Object psobject
                    $report | Add-Member -MemberType NoteProperty -name 'acctok' -Value $tb_account_act.Text
                    $report | Add-Member -MemberType NoteProperty -name 'blog_adr' -Value $blog_adr
                    $report | Add-Member -MemberType NoteProperty -name 'cont_adr' -Value $blog_adr.Substring(0,$dot_split)
                    $report | export-csv -Append $account_csv -NoTypeInformation -Force -Encoding utf8

                    $tb_account_adr.Text = ''
                    $tb_account_act.Text = ''

                    # 계정 추가
                    select_account

                 } else { 
                    # 임의로 계정 정보 파일을 삭제했을 경우 재생성
                    create_csv; msg_box -str '계정 생성 파일을 만들었습니다. 다시 시도하세요.'
                 }

              } else {
                msg_box -str '블로그 주소 형식에 맞게 입력하세요. (aaa.tistory.com)'              
              }
              
     } else { msg_box -str '액세스 토큰 또는 블로그 주소를 입력하세요.' }


})


# 저장 디렉터리 선택
$bt_fdown_workdir.add_Click({

        Add-Type -AssemblyName System.Windows.Forms 
        $browser = New-Object System.Windows.Forms.FolderBrowserDialog 
        $check = $browser.ShowDialog()

        if ($check -eq "OK")
        {
            $tb_naming_workdir.Text = $browser.SelectedPath
        }

})
$bt_write_workdir.add_Click({

        Add-Type -AssemblyName System.Windows.Forms 
        $browser = New-Object System.Windows.Forms.FolderBrowserDialog 
        $check = $browser.ShowDialog()

        if ($check -eq "OK")
        {
            $tb_write_workdir.Text = $browser.SelectedPath

            $target_file = Get-ChildItem -Filter *.txt -Path $tb_write_workdir.Text  
            $cur_file_num = $target_file.Count
            $tb_exist_file.Text = $cur_file_num
        }

})
# ------------------------



# write exec
$bt_write_exec.add_Click({


    if ( (Test-Path $account_csv) -eq $true )
    {
        $wri_csv = Import-Csv $account_csv

        for( $i=1; $i -lt $wri_csv.Count; $i++)
        {

            if (  $wri_csv[$i].cont_adr -eq $li_select_account.SelectedItem )
            { 
            
            $cur_blogadr = $wri_csv[$i].blog_adr
            $cur_acctok = $wri_csv[$i].acctok
            break
            }   
        }  
     }  


    if ( ([String]::IsNullOrEmpty($cur_acctok) -eq $false) -and ([String]::IsNullOrEmpty($tb_upload_files.Text) -eq $false))
    {
        
         $suc_count_post  = 0
         $fail_count_post = 0
         # 사용자가 입력한 개수
         $upload_ct = [int]$tb_upload_files.Text 
         # 실제 파일 개수
         $target_file = Get-ChildItem -Filter *.txt -Path $tb_write_workdir.Text  
         $cur_file_num = $target_file.Count
         $tb_exist_file.Text = $cur_file_num


         # 실제 파일 개수 < 사용자가 입력한 개수 = error 필터
         if ( $upload_ct -gt $cur_file_num ) { $lot_index = $cur_file_num } 
         else { $lot_index = $upload_ct } 
         
         if ( $lot_index -ne 0 ) {
         write_post -upload_ct $lot_index
         } else { msg_box '파일이 없습니다.' }


    } else { msg_box -str '토큰이 비어있거나, 업로드 수가 정의되지 않았습니다.' }
    
    

})

# 토큰 요청
$bt_requ_reg.add_Click({


    

        [Void][Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
        $client_id = [Microsoft.VisualBasic.Interaction]::InputBox('Client ID를 입력하세요.', 'Input Box')
        [Void][Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
        $call_back = [Microsoft.VisualBasic.Interaction]::InputBox('Call_Back 주소를 입력하세요.', 'Input Box','http://')

        if ( ([String]::IsNullOrEmpty($client_id) -eq $false) -and ([String]::IsNullOrEmpty($call_back) -eq $false) )
        {          
           $req_tok_url = 'https://www.tistory.com/oauth/authorize?client_id='
           $req_tok_cli = $client_id + '&redirect_uri='

           $req_tok_cal = $call_back + '&response_type=token'

           $req_tok_url = $req_tok_url + $req_tok_cli + $req_tok_cal

            # 토큰 요청 기록 남기기
           if ( (Test-Path $save_cli_txt ) -eq $false )
           {
                Set-Content -Path $save_cli_txt -Value ''
           }
           
           $val = [String](Date)
           $val = $val + ' client ID = ' + $client_id + ' call_back = ' + $call_back
           Add-Content -Path $save_cli_txt -Value $val

           $browser = [System.Diagnostics.Process]::Start( "chrome.exe", "-incognito " + $req_tok_url )

        } else { msg_box -str '계정을 선택하세요.' }


})

$bt_tok_chg.add_Click({

        [Void][Reflection.Assembly]::LoadWithPartialName("Microsoft.VisualBasic")
        $change_tok = [Microsoft.VisualBasic.Interaction]::InputBox('선택된 계정의 토큰을 변경합니다.', 'Input Box')
 
        if ( ([String]::IsNullOrEmpty($change_tok) -eq $false) )
        {          
            $chg_csv = Import-Csv -Path $account_csv
            $selected_acc = $li_account_list.SelectedItem
            
            
            if ( ([String]::IsNullOrEmpty($selected_acc) -eq $false) )
            {
               $chg_idx = $li_account_list.SelectedIndex + 1
               $chg_csv[$chg_idx].acctok = $change_tok
               $chg_csv | Export-Csv $account_csv -NoType -Encoding utf8
               msg_box '변경되었습니다.'
            } else { msg_box '선택된 계정이 없습니다.' }
        }
})



$bt_conn_kip.add_Click({

          $kip_url = 'http://beginner.kipris.or.kr/beginner/search/firstSearch.jsp'
          $browser = [System.Diagnostics.Process]::Start( "chrome.exe", "-incognito " + $kip_url )

})


# 글 쓰기
function write_post
{ param([int]$upload_ct)
   
        
           $target_file = Get-ChildItem -Filter *.txt -Path $tb_write_workdir.Text 
           
           $file_delete_flag = $false 
           $oRetrun=[System.Windows.Forms.MessageBox]::Show('포스팅이 끝나면 기존의 아이템을 삭제하시겠습니까?',"삭제",[System.Windows.Forms.MessageBoxButtons]::OKCancel) 
           if ( $oRetrun -eq "OK" ) { $file_delete_flag = $true }

           # 진행률 표
           $pb_upload_process.Maximum = $upload_ct
           $pb_upload_process.Step = 1
           $pb_upload_process.value = 0
           $cat_id = ''
           # 카테고리 번호
           if ( ([String]::IsNullOrEmpty($tb_wait_post) -eq $false) )
           {
             $cat_id = $tb_wri_category.Text
             $cat_id = [string]$cat_id
           } else { $cat_id = '0' } 

           # changed Utf8
           $target_file | % {
           (Get-Content $_.FullName) | Set-Content -Encoding UTF8 -Force -Path $_.FullName
           }

           for( $i=0; $i -lt $upload_ct; $i++ )
           { 
               $item_title = $target_file[$i].BaseName
               $item_data = Get-Content $target_file[$i].FullName -encoding utf8 -Force
               $item_data = $item_data -join [Environment]::NewLine -replace '\n','<br>'
               $tb_post_title.Text = $item_title
               
               
               
               
               $Statuscode = Invoke-WebRequest -Uri "https://www.tistory.com/apis/post/write" -Method Post -Body @{
                             access_token = $cur_acctok
                             blogName = $cur_blogadr
                             title = $item_title
                             content = $item_data
                             acceptComment = '0' # 댓글 비허용
                             visibility = '3' # 게시물 공개
                             category = $cat_id # 카테고리 id
                 }

                $stat_code = $Statuscode.StatusCode
                
           
                 # 업로드 성공 여부
                if ( $stat_code -eq "200" -or $stat_code -eq "201" -or $stat_code -eq "202" -or $stat_code -eq "204" -or $stat_code -eq "206" )
                {
                  $suc_count_post++
                } else {
                  $fail_count_post++
                }
                $tb_upload_suc.Text = $suc_count_post
                $tb_upload_fail.Text =  $fail_count_post   
              
                $pb_upload_process.PerformStep()

              # 포스팅 후 대기 시간 - 설정 안하면 30초
              if ( ([String]::IsNullOrEmpty($tb_wait_post) -eq $false) -and ([String]::IsNullOrEmpty($tb_mwait_post) -eq $false) )
              {
               $random = $tb_wait_post.Text..$tb_mwait_post.Text | Get-Random
               Start-Sleep -Seconds $random
              } else { Start-Sleep -Seconds 30 }
              
              if ( $file_delete_flag -eq $true ) 
              { Remove-Item $target_file[$i].FullName }
              
           } 
           msg_box -str '포스팅을 완료하였습니다.'
   
} 

# ---------------------------

# create_load csv
function create_csv
{
    
        # 계정 파일
        if ( (Test-Path $account_csv) -eq $false )
        {
        $header = 'acctok','blog_adr','cont_adr'
        $null_data = @(1,1,1) -join ','
        ConvertFrom-Csv -InputObject $null_data -Header $header | Export-Csv $account_csv -NoType -Encoding utf8
        } 
        
        # 설정 값 파일
        if ( (Test-Path $setting_csv) -eq $false )
        {
        $header = 'expdata_num','name_save_dir','wri_save_dir','export_list','upload_num','wait_post','mwait_post','empty_wd','ct_id'
        $null_data = @(100,$Default_path,$Default_path,'2020050009587',100,30,45,'저장용',0) -join ','
        ConvertFrom-Csv -InputObject $null_data -Header $header | Export-Csv $setting_csv -NoType -Encoding utf8
        } 
}

function load_csv
{
        # 계정 파일
        if ( (Test-Path $account_csv) -eq $true ) { select_account } 
        
        # 설정 값 파일
        if ( (Test-Path $setting_csv) -eq $true ) 
        { 
           $set_csv = Import-Csv -Path $setting_csv
           $tb_export_num.Text = $set_csv.expdata_num
           $tb_naming_workdir.Text = $set_csv.name_save_dir
           $tb_write_workdir.Text = $set_csv.wri_save_dir
           $tb_export_list.Text = $set_csv.export_list
           $tb_upload_files.Text = $set_csv.upload_num
           $tb_wait_post.Text    = $set_csv.wait_post
           $tb_mwait_post.Text   = $set_csv.mwait_post
           $tb_empty_window.Text = $set_csv.empty_wd
           $tb_wri_category.Text = $set_csv.ct_id
        } 

        if ( (Test-Path $tb_write_workdir.Text) -eq $true )
        {
        $target_file = Get-ChildItem -Filter *.txt -Path $tb_write_workdir.Text
        $tb_exist_file.Text = $target_file.Count
        } else { msg_box '작업 디렉터리에 해당 폴더가 존재하지 않습니다.' }
}
# -----------------------------





# changed csv
function select_account
{ 
        $sel_acc_csv = Import-Csv -Path $account_csv
        $li_account_list.Items.Clear()
        $li_select_account.Items.Clear()

        # add_account
        for ( $i=1; $i -lt $sel_acc_csv.Count; $i++ )
        { 
         $tmp_blog_adr = $sel_acc_csv[$i].blog_adr
         $splits = $tmp_blog_adr.indexof('.')
         $tmp_blog_adr = $tmp_blog_adr.Substring(0,$splits) 
         $null = $li_account_list.Items.add( $tmp_blog_adr )
         $null = $li_select_account.Items.add( $tmp_blog_adr )
        }  

        if ( $sel_acc_csv.Count -gt 1 ) { 
        $li_account_list.SelectedIndex = $sel_acc_csv.Count-2; 
        $li_select_account.SelectedIndex = $sel_acc_csv.Count-2; 
        }
}
function save_path_csv 
{
     
        # save_form
        $report = New-Object psobject
        $report | Add-Member -MemberType NoteProperty -name 'expdata_num' -Value $tb_export_num.Text
        $report | Add-Member -MemberType NoteProperty -name 'name_save_dir' -Value $tb_naming_workdir.Text
        $report | Add-Member -MemberType NoteProperty -name 'wri_save_dir' -Value $tb_write_workdir.Text
        $report | Add-Member -MemberType NoteProperty -name 'export_list' -Value $tb_export_list.Text
        $report | Add-Member -MemberType NoteProperty -name 'upload_num' -Value $tb_upload_files.Text
        $report | Add-Member -MemberType NoteProperty -name 'wait_post' -Value $tb_wait_post.Text
        $report | Add-Member -MemberType NoteProperty -name 'mwait_post' -Value $tb_mwait_post.Text
        $report | Add-Member -MemberType NoteProperty -name 'empty_wd' -Value $tb_empty_window.Text
        $report | Add-Member -MemberType NoteProperty -name 'ct_id' -Value $tb_wri_category.Text
        
        $report | export-csv -Path $setting_csv -NoTypeInformation -Force -Encoding utf8
}




# -----------------------------

function msg_box
{ param([string]$str)
 $null = [System.Windows.Forms.MessageBox]::Show($str)
}


$Form.Add_Closing({ save_path_csv })


# init
create_csv
load_csv

[void]$Form.ShowDialog()
