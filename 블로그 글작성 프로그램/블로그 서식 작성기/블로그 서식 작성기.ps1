# utf16 LE
Set-ExecutionPolicy Bypass # unrestricted

#$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
# Set-Location $scriptPath

$scriptPath = $(get-location).Path;
Set-Location $scriptPath



$default_css_code = "<style>
#tt-body-page figure.imageblock img, figure.imageblock img,
figure.imageblock img {
   display: inline-block;
   max-width: 100% !importent;
   margin: 0;
   height: auto;
   /*border: 1px solid #ffffff;*/
	 border-radius: 10px;
   box-sizing: border-box;
	 box-shadow: 0 0 0 2px #fef inset;
   padding: 10px;
}
	div {
	font-size:13pt;
  font-weight:bold;
	color:white;
  letter-spacing: 0.02em;
  line-height: 1.8;	
	}
#custom_code_text {
  font-size:13pt;
  font-weight:bold;
  letter-spacing: 0.02em;
  line-height: 1.8;
}
#custom_blockquote {
    padding: 5px 20px;
    margin: 10px 0 20px;
    color: #919191;
    font-size: .9em;
    font-style: italic;
    border-left: 3px solid #e1e4e5;
}
#custom_blockquote *{
    font-size: 16px;
    line-height: 1.6;
    color: #666;
    letter-spacing: 0px;
}
#custom_code_title {
    position: relative;
    margin: 20px 0 15px;
    font-size: 23pt;
    border-bottom: thick double #48d1cc;
    border-bottom-left-radius: 21px;
    border-bottom-right-radius: 6px;
    line-height: 1.6;
    color: #00afff !important;
    font-family: 'LotteMartHappy','Youth','Jeju Gothic', '본고딕','Arial', '나눔바른고딕','나눔고딕';
    font-weight: bold;
    display:inline-block; 
}
#custom_code_subtitle {
    position: relative;
    margin: 20px 0 5px;
    font-size: 16pt;
    line-height: 1.9;
	color: #B2CCFF !important;
    border-bottom: 2px solid #B2CCFF !important;
    display:inline-block;
    font-family: 'LotteMartHappy','Youth','Jeju Gothic', '본고딕','Arial', '나눔바른고딕','나눔고딕';
    font-weight: bold;
}

#custom_code_mark {
    background-color: #CCFDCC;
    padding: 2px 4px;
    font-weight: bold;
}
#custom_code_code {
    padding: 5px 7px 4px;
    font-size: 90%;
    color: #2e8b57;
    background-color: #fff;
    border-radius: 4px;
    font-weight: bold;
    border: 1px solid #008b8b;
    border-bottom-width: 2px;
    box-shadow: inset 1px -1px 1px #f7f2f2, inset -1px 1px 1px #fffafa;
}
#custom_basic_code {
    font-weight:bold;
    display: inline-block;
    padding: 7px 7px 4px;
    font-size: .9em;
    line-height: 14px;
    color: #000;
    background-color: #fcfcfc;
    border: 1px solid #ccc;
    border-bottom-width: 2px;
    border-radius: 3px;
    box-shadow: inset 1px -1px 1px #fff, inset -1px 1px 1px #fff;
}
#custom_code_quote {
position: relative;
padding: 13px 30px 10px 40px;
margin: 15px 0;
border: 5px solid #6495ed;
border-left: 5px solid #4682b4;
border-bottom: 5px solid #4682b4;
background: rgba(00, 11, 004, 0.9);
transition: all 1s;
}
#custom_code_quote #custom_code_pre {
font-weight:bold;
line-height: 1.9;
color: #ffffff;
background:transparent;
font-size: 12pt;
letter-spacing: 0.02em;
margin: 7px 0;
font-family: 'Youth','Jeju Gothic', '본고딕', '나눔바른고딕','나눔고딕';
}
</style>"


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()


$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '892,630'
$Form.text                       = "블로그 서식 작성기 - jdh5202"
$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$Form.StartPosition = $CenterScreen; 
$Form.AutoSizeMode = "GrowAndShrink"
$Form.MaximizeBox = $false


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$TextArea_zoom                            = New-Object system.Windows.Forms.Form

$scr_wid = [int]((Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution[0] / 1.1)
$scr_hei = [int]((Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution[0] / 1.1)

$TextArea_zoom.ClientSize                 =  "$scr_wid,$scr_hei"
$TextArea_zoom.text                       = "Form"
$TextArea_zoom.AutoSizeMode = "GrowAndShrink"
$TextArea_zoom.MaximizeBox = $false

$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$TextArea_zoom.StartPosition = $CenterScreen; 



$en_input_window                       = New-Object system.Windows.Forms.RichTextBox
$en_input_window.multiline             = $false
$en_input_window.width                 = $scr_wid
$en_input_window.height                = $scr_hei
$en_input_window.location              = New-Object System.Drawing.Point(1,25)
$en_input_window.Font                  = 'Microsoft Sans Serif,18'
$en_input_window.Multiline             = $true
$en_input_window.WordWrap              = $false


$symbol_cpy1                         = New-Object system.Windows.Forms.Button
$symbol_cpy1.text                    = "C1 ●"
$symbol_cpy1.width                   = 65
$symbol_cpy1.height                  = 25
$symbol_cpy1.location                = New-Object System.Drawing.Point(5,0)
$symbol_cpy1.Font                    = 'Microsoft Sans Serif,14'

$symbol_cpy2                         = New-Object system.Windows.Forms.Button
$symbol_cpy2.text                    = "C2 ◎"
$symbol_cpy2.width                   = 65
$symbol_cpy2.height                  = 25
$symbol_cpy2.location                = New-Object System.Drawing.Point(80,0)
$symbol_cpy2.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy3                         = New-Object system.Windows.Forms.Button
$symbol_cpy3.text                    = "C3 ▷"
$symbol_cpy3.width                   = 65
$symbol_cpy3.height                  = 25
$symbol_cpy3.location                = New-Object System.Drawing.Point(155,0)
$symbol_cpy3.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy4                         = New-Object system.Windows.Forms.Button
$symbol_cpy4.text                    = "C4 ※"
$symbol_cpy4.width                   = 65
$symbol_cpy4.height                  = 25
$symbol_cpy4.location                = New-Object System.Drawing.Point(230,0)
$symbol_cpy4.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy5                         = New-Object system.Windows.Forms.Button
$symbol_cpy5.text                    = "C5 ◈"
$symbol_cpy5.width                   = 65
$symbol_cpy5.height                  = 25
$symbol_cpy5.location                = New-Object System.Drawing.Point(305,0)
$symbol_cpy5.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy6                         = New-Object system.Windows.Forms.Button
$symbol_cpy6.text                    = "F1 ⓑ"
$symbol_cpy6.width                   = 65
$symbol_cpy6.height                  = 25
$symbol_cpy6.location                = New-Object System.Drawing.Point(380,0)
$symbol_cpy6.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy7                         = New-Object system.Windows.Forms.Button
$symbol_cpy7.text                    = "F2 ⓒ"
$symbol_cpy7.width                   = 65
$symbol_cpy7.height                  = 25
$symbol_cpy7.location                = New-Object System.Drawing.Point(445,0)
$symbol_cpy7.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy8                         = New-Object system.Windows.Forms.Button
$symbol_cpy8.text                    = "F3 ⓜ"
$symbol_cpy8.width                   = 65
$symbol_cpy8.height                  = 25
$symbol_cpy8.location                = New-Object System.Drawing.Point(510,0)
$symbol_cpy8.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy9                         = New-Object system.Windows.Forms.Button
$symbol_cpy9.text                    = "F4 ⓠ"
$symbol_cpy9.width                   = 65
$symbol_cpy9.height                  = 25
$symbol_cpy9.location                = New-Object System.Drawing.Point(575,0)
$symbol_cpy9.Font                    = 'Microsoft Sans Serif,12'

$symbol_cpy10                         = New-Object system.Windows.Forms.Button
$symbol_cpy10.text                    = "F5 ⓢ"
$symbol_cpy10.width                   = 65
$symbol_cpy10.height                  = 25
$symbol_cpy10.location                = New-Object System.Drawing.Point(640,0)
$symbol_cpy10.Font                    = 'Microsoft Sans Serif,12'

$number_cpy1                         = New-Object system.Windows.Forms.Button
$number_cpy1.text                    = "C6 ①"
$number_cpy1.width                   = 65
$number_cpy1.height                  = 25
$number_cpy1.location                = New-Object System.Drawing.Point(710,0)
$number_cpy1.Font                    = 'Microsoft Sans Serif,14'

$number_cpy2                         = New-Object system.Windows.Forms.Button
$number_cpy2.text                    = "C7 ②"
$number_cpy2.width                   = 65
$number_cpy2.height                  = 25
$number_cpy2.location                = New-Object System.Drawing.Point(779,0)
$number_cpy2.Font                    = 'Microsoft Sans Serif,14'

$number_cpy3                         = New-Object system.Windows.Forms.Button
$number_cpy3.text                    = "C8 ③"
$number_cpy3.width                   = 65
$number_cpy3.height                  = 25
$number_cpy3.location                = New-Object System.Drawing.Point(848,0)
$number_cpy3.Font                    = 'Microsoft Sans Serif,14'

$number_cpy4                         = New-Object system.Windows.Forms.Button
$number_cpy4.text                    = "C9 ④"
$number_cpy4.width                   = 65
$number_cpy4.height                  = 25
$number_cpy4.location                = New-Object System.Drawing.Point(915,0)
$number_cpy4.Font                    = 'Microsoft Sans Serif,14'

$number_cpy5                         = New-Object system.Windows.Forms.Button
$number_cpy5.text                    = "C0 ⑤"
$number_cpy5.width                   = 65
$number_cpy5.height                  = 25
$number_cpy5.location                = New-Object System.Drawing.Point(980,0)
$number_cpy5.Font                    = 'Microsoft Sans Serif,14'

$number_cpy6                         = New-Object system.Windows.Forms.Button
$number_cpy6.text                    = "F6 ⑥"
$number_cpy6.width                   = 65
$number_cpy6.height                  = 25
$number_cpy6.location                = New-Object System.Drawing.Point(1050,0)
$number_cpy6.Font                    = 'Microsoft Sans Serif,14'

$number_cpy7                         = New-Object system.Windows.Forms.Button
$number_cpy7.text                    = "F7 ⑦"
$number_cpy7.width                   = 65
$number_cpy7.height                  = 25
$number_cpy7.location                = New-Object System.Drawing.Point(1120,0)
$number_cpy7.Font                    = 'Microsoft Sans Serif,14'

$number_cpy8                         = New-Object system.Windows.Forms.Button
$number_cpy8.text                    = "F8 ⑧"
$number_cpy8.width                   = 65
$number_cpy8.height                  = 25
$number_cpy8.location                = New-Object System.Drawing.Point(1190,0)
$number_cpy8.Font                    = 'Microsoft Sans Serif,14'

$number_cpy9                         = New-Object system.Windows.Forms.Button
$number_cpy9.text                    = "F9 ⑨"
$number_cpy9.width                   = 65
$number_cpy9.height                  = 25
$number_cpy9.location                = New-Object System.Drawing.Point(1260,0)
$number_cpy9.Font                    = 'Microsoft Sans Serif,14'

$number_cpy10                        = New-Object system.Windows.Forms.Button
$number_cpy10.text                    = "F10 ⑩"
$number_cpy10.width                   = 65
$number_cpy10.height                  = 25
$number_cpy10.location                = New-Object System.Drawing.Point(1330,0)
$number_cpy10.Font                    = 'Microsoft Sans Serif,12'

$TextArea_zoom.controls.AddRange(@($en_input_window,$symbol_cpy1,$symbol_cpy2,$symbol_cpy3,$symbol_cpy4,$symbol_cpy5,$symbol_cpy6,$symbol_cpy7,$symbol_cpy8,$symbol_cpy9,$symbol_cpy10))
$TextArea_zoom.controls.AddRange(@($number_cpy1,$number_cpy2,$number_cpy3,$number_cpy4,$number_cpy5,$number_cpy6,$number_cpy7,$number_cpy8,$number_cpy9,$number_cpy10))

$edit_but_group = @($symbol_cpy1,$symbol_cpy2,$symbol_cpy3,$symbol_cpy4,$symbol_cpy5,$symbol_cpy6,$symbol_cpy7,$symbol_cpy8,$symbol_cpy9,$symbol_cpy10,$number_cpy1,$number_cpy2,$number_cpy3,$number_cpy4,$number_cpy5,$number_cpy6,$number_cpy7,$number_cpy8,$number_cpy9,$number_cpy10)

$TextArea_zoom.Add_KeyDown({
    if($_.KeyCode -eq "Escape") {
        $TextArea_zoom.Close()
        } else {
        
         $char_code_paste2 = @('ⓑ','ⓒ','ⓜ','ⓠ','ⓢ','①','②','③','④','⑤')
         $char_code_paste1 = @('●','◎','▷','※','◈','⑥','⑦','⑧','⑨','⑩')    
         
         $char_code_nkey   = @('D1','D2','D3','D4','D5','D6','D7','D8','D9','D0')
         $char_code_pkey   = @('F1','F2','F3','F4','F5','F6','F7','F8','F9','F10')

            $i = 0
               foreach ( $paste in $char_code_paste2 )
               {  
                  if ( $_.KeyCode -eq $char_code_pkey[$i] )
                  {  
                     if ( $i -le 4 )
                     {
                     Set-Clipboard $paste
                     } else {
                     
		$spc_t = "ⓑ" + $paste + "ⓑ"
		Set-Clipboard $spc_t
                     } [System.Windows.Forms.SendKeys]::SendWait("^v")
                     
                     break
                  }  $i++
               } 
            
            $i = 0 
               foreach ( $paste in $char_code_paste1 )
               {   
              
                  if ( $_.KeyCode -eq $char_code_nkey[$i] -and $_.Control )
                  {  
                      Set-Clipboard $paste
                     [System.Windows.Forms.SendKeys]::SendWait("^v")
                     
                     break
                  }  $i++
               } 
               
            
      
        }
    })
       $TextArea_zoom.KeyPreview = $true


# Source Textbox & Label
$symbol1                        = New-Object system.Windows.Forms.TextBox
$symbol1.multiline              = $false
$symbol1.width                  = 100
$symbol1.height                 = 20
$symbol1.location               = New-Object System.Drawing.Point(67,11)
$symbol1.Font                   = 'Microsoft Sans Serif,10'

$symbol2                        = New-Object system.Windows.Forms.TextBox
$symbol2.multiline              = $false
$symbol2.width                  = 100
$symbol2.height                 = 20
$symbol2.location               = New-Object System.Drawing.Point(67,35)
$symbol2.Font                   = 'Microsoft Sans Serif,10'

$symbol3                        = New-Object system.Windows.Forms.TextBox
$symbol3.multiline              = $false
$symbol3.width                  = 100
$symbol3.height                 = 20
$symbol3.location               = New-Object System.Drawing.Point(67,59)
$symbol3.Font                   = 'Microsoft Sans Serif,10'

$symbol4                        = New-Object system.Windows.Forms.TextBox
$symbol4.multiline              = $false
$symbol4.width                  = 100
$symbol4.height                 = 20
$symbol4.location               = New-Object System.Drawing.Point(67,83)
$symbol4.Font                   = 'Microsoft Sans Serif,10'

$symbol5                        = New-Object system.Windows.Forms.TextBox
$symbol5.multiline              = $false
$symbol5.width                  = 100
$symbol5.height                 = 20
$symbol5.location               = New-Object System.Drawing.Point(67,106)
$symbol5.Font                   = 'Microsoft Sans Serif,10'
$symbol5.BackColor              = 'lightgreen'

$symbol6                        = New-Object system.Windows.Forms.TextBox
$symbol6.multiline              = $false
$symbol6.width                  = 100
$symbol6.height                 = 20
$symbol6.location               = New-Object System.Drawing.Point(67,129)
$symbol6.Font                   = 'Microsoft Sans Serif,10'
$symbol6.BackColor              = 'lightgreen'

$symbol7                        = New-Object system.Windows.Forms.TextBox
$symbol7.multiline              = $false
$symbol7.width                  = 100
$symbol7.height                 = 20
$symbol7.location               = New-Object System.Drawing.Point(67,152)
$symbol7.Font                   = 'Microsoft Sans Serif,10'
$symbol7.BackColor              = 'lightgreen'

$symbol8                        = New-Object system.Windows.Forms.TextBox
$symbol8.multiline              = $false
$symbol8.width                  = 100
$symbol8.height                 = 20
$symbol8.location               = New-Object System.Drawing.Point(67,175)
$symbol8.Font                   = 'Microsoft Sans Serif,10'
$symbol8.BackColor              = 'lightgreen'

$symbol9                        = New-Object system.Windows.Forms.TextBox
$symbol9.multiline              = $false
$symbol9.width                  = 100
$symbol9.height                 = 20
$symbol9.location               = New-Object System.Drawing.Point(67,198)
$symbol9.Font                   = 'Microsoft Sans Serif,10'
$symbol9.BackColor              = 'lightgreen'

$symbol10                        = New-Object system.Windows.Forms.TextBox
$symbol10.multiline              = $false
$symbol10.width                  = 100
$symbol10.height                 = 20
$symbol10.location               = New-Object System.Drawing.Point(67,221)
$symbol10.Font                   = 'Microsoft Sans Serif,10'
$symbol10.BackColor              = 'red'

$Label9                          = New-Object system.Windows.Forms.Label
$Label9.text                     = "Source1"
$Label9.AutoSize                 = $true
$Label9.width                    = 25
$Label9.height                   = 10
$Label9.location                 = New-Object System.Drawing.Point(10,16)
$Label9.Font                     = 'Microsoft Sans Serif,10'

$Label10                         = New-Object system.Windows.Forms.Label
$Label10.text                    = "Source2"
$Label10.AutoSize                = $true
$Label10.width                   = 25
$Label10.height                  = 10
$Label10.location                = New-Object System.Drawing.Point(10,40)
$Label10.Font                    = 'Microsoft Sans Serif,10'

$Label11                         = New-Object system.Windows.Forms.Label
$Label11.text                    = "Source3"
$Label11.AutoSize                = $true
$Label11.width                   = 25
$Label11.height                  = 10
$Label11.location                = New-Object System.Drawing.Point(10,62)
$Label11.Font                    = 'Microsoft Sans Serif,10'

$Label12                         = New-Object system.Windows.Forms.Label
$Label12.text                    = "Source4"
$Label12.AutoSize                = $true
$Label12.width                   = 25
$Label12.height                  = 10
$Label12.location                = New-Object System.Drawing.Point(10,85)
$Label12.Font                    = 'Microsoft Sans Serif,10'

$Label13                         = New-Object system.Windows.Forms.Label
$Label13.text                    = "Source5"
$Label13.AutoSize                = $true
$Label13.width                   = 25
$Label13.height                  = 10
$Label13.location                = New-Object System.Drawing.Point(10,110)
$Label13.Font                    = 'Microsoft Sans Serif,10'

$Label14                         = New-Object system.Windows.Forms.Label
$Label14.text                    = "Source6"
$Label14.AutoSize                = $true
$Label14.width                   = 25
$Label14.height                  = 10
$Label14.location                = New-Object System.Drawing.Point(10,131)
$Label14.Font                    = 'Microsoft Sans Serif,10'

$Label15                         = New-Object system.Windows.Forms.Label
$Label15.text                    = "Source7"
$Label15.AutoSize                = $true
$Label15.width                   = 25
$Label15.height                  = 10
$Label15.location                = New-Object System.Drawing.Point(10,153)
$Label15.Font                    = 'Microsoft Sans Serif,10'

$Label37                         = New-Object system.Windows.Forms.Label
$Label37.text                    = "Source8"
$Label37.AutoSize                = $true
$Label37.width                   = 25
$Label37.height                  = 10
$Label37.location                = New-Object System.Drawing.Point(10,176)
$Label37.Font                    = 'Microsoft Sans Serif,10'

$Label38                         = New-Object system.Windows.Forms.Label
$Label38.text                    = "Source9"
$Label38.AutoSize                = $true
$Label38.width                   = 25
$Label38.height                  = 10
$Label38.location                = New-Object System.Drawing.Point(10,199)
$Label38.Font                    = 'Microsoft Sans Serif,10'

$Label39                         = New-Object system.Windows.Forms.Label
$Label39.text                    = "Source!"
$Label39.AutoSize                = $true
$Label39.width                   = 25
$Label39.height                  = 10
$Label39.location                = New-Object System.Drawing.Point(10,223)
$Label39.Font                    = 'Microsoft Sans Serif,10'

# Destination Textbox & label
$rep_tag1                        = New-Object system.Windows.Forms.TextBox
$rep_tag1.multiline              = $false
$rep_tag1.width                  = 100
$rep_tag1.height                 = 20
$rep_tag1.location               = New-Object System.Drawing.Point(302,11)
$rep_tag1.Font                   = 'Microsoft Sans Serif,10'

$rep_tag2                        = New-Object system.Windows.Forms.TextBox
$rep_tag2.multiline              = $false
$rep_tag2.width                  = 100
$rep_tag2.height                 = 20
$rep_tag2.location               = New-Object System.Drawing.Point(302,35)
$rep_tag2.Font                   = 'Microsoft Sans Serif,10'

$rep_tag3                       = New-Object system.Windows.Forms.TextBox
$rep_tag3.multiline             = $false
$rep_tag3.width                 = 100
$rep_tag3.height                = 20
$rep_tag3.location              = New-Object System.Drawing.Point(302,59)
$rep_tag3.Font                  = 'Microsoft Sans Serif,10'

$rep_tag4                       = New-Object system.Windows.Forms.TextBox
$rep_tag4.multiline             = $false
$rep_tag4.width                 = 100
$rep_tag4.height                = 20
$rep_tag4.location              = New-Object System.Drawing.Point(302,83)
$rep_tag4.Font                  = 'Microsoft Sans Serif,10'

$rep_tag5                       = New-Object system.Windows.Forms.TextBox
$rep_tag5.multiline             = $false
$rep_tag5.width                 = 100
$rep_tag5.height                = 20
$rep_tag5.location              = New-Object System.Drawing.Point(302,106)
$rep_tag5.Font                  = 'Microsoft Sans Serif,10'
$rep_tag5.BackColor             = 'lightgreen'

$rep_tag6                       = New-Object system.Windows.Forms.TextBox
$rep_tag6.multiline             = $false
$rep_tag6.width                 = 100
$rep_tag6.height                = 20
$rep_tag6.location              = New-Object System.Drawing.Point(302,129)
$rep_tag6.Font                  = 'Microsoft Sans Serif,10'
$rep_tag6.BackColor             = 'lightgreen'

$rep_tag7                       = New-Object system.Windows.Forms.TextBox
$rep_tag7.multiline             = $false
$rep_tag7.width                 = 100
$rep_tag7.height                = 20
$rep_tag7.location              = New-Object System.Drawing.Point(302,152)
$rep_tag7.Font                  = 'Microsoft Sans Serif,10'
$rep_tag7.BackColor             = 'lightgreen'

$rep_tag8                       = New-Object system.Windows.Forms.TextBox
$rep_tag8.multiline             = $false
$rep_tag8.width                 = 100
$rep_tag8.height                = 20
$rep_tag8.location              = New-Object System.Drawing.Point(302,175)
$rep_tag8.Font                  = 'Microsoft Sans Serif,10'
$rep_tag8.BackColor             = 'lightgreen'

$rep_tag9                       = New-Object system.Windows.Forms.TextBox
$rep_tag9.multiline             = $false
$rep_tag9.width                 = 100
$rep_tag9.height                = 20
$rep_tag9.location              = New-Object System.Drawing.Point(302,198)
$rep_tag9.Font                  = 'Microsoft Sans Serif,10'
$rep_tag9.BackColor             = 'lightgreen'

$rep_tag10                       = New-Object system.Windows.Forms.TextBox
$rep_tag10.multiline             = $false
$rep_tag10.width                 = 100
$rep_tag10.height                = 20
$rep_tag10.location              = New-Object System.Drawing.Point(302,221)
$rep_tag10.Font                  = 'Microsoft Sans Serif,7'
$rep_tag10.BackColor             = 'red'

$rep_tag7                       = New-Object system.Windows.Forms.TextBox
$rep_tag7.multiline             = $false
$rep_tag7.width                 = 100
$rep_tag7.height                = 20
$rep_tag7.location              = New-Object System.Drawing.Point(302,152)
$rep_tag7.Font                  = 'Microsoft Sans Serif,10'
$rep_tag7.BackColor             = 'lightgreen'

$Label16                         = New-Object system.Windows.Forms.Label
$Label16.text                    = "Destination1"
$Label16.AutoSize                = $true
$Label16.width                   = 25
$Label16.height                  = 10
$Label16.location                = New-Object System.Drawing.Point(220,16)
$Label16.Font                    = 'Microsoft Sans Serif,10'

$Label17                         = New-Object system.Windows.Forms.Label
$Label17.text                    = "Destination2"
$Label17.AutoSize                = $true
$Label17.width                   = 25
$Label17.height                  = 10
$Label17.location                = New-Object System.Drawing.Point(220,40)
$Label17.Font                    = 'Microsoft Sans Serif,10'

$Label18                         = New-Object system.Windows.Forms.Label
$Label18.text                    = "Destination3"
$Label18.AutoSize                = $true
$Label18.width                   = 25
$Label18.height                  = 10
$Label18.location                = New-Object System.Drawing.Point(220,62)
$Label18.Font                    = 'Microsoft Sans Serif,10'

$Label19                         = New-Object system.Windows.Forms.Label
$Label19.text                    = "Destination4"
$Label19.AutoSize                = $true
$Label19.width                   = 25
$Label19.height                  = 10
$Label19.location                = New-Object System.Drawing.Point(220,85)
$Label19.Font                    = 'Microsoft Sans Serif,10'

$Label20                         = New-Object system.Windows.Forms.Label
$Label20.text                    = "Destination5"
$Label20.AutoSize                = $true
$Label20.width                   = 25
$Label20.height                  = 10
$Label20.location                = New-Object System.Drawing.Point(220,110)
$Label20.Font                    = 'Microsoft Sans Serif,10'

$Label21                         = New-Object system.Windows.Forms.Label
$Label21.text                    = "Destination6"
$Label21.AutoSize                = $true
$Label21.width                   = 25
$Label21.height                  = 10
$Label21.location                = New-Object System.Drawing.Point(220,131)
$Label21.Font                    = 'Microsoft Sans Serif,10'

$Label22                         = New-Object system.Windows.Forms.Label
$Label22.text                    = "Destination7"
$Label22.AutoSize                = $true
$Label22.width                   = 25
$Label22.height                  = 10
$Label22.location                = New-Object System.Drawing.Point(220,153)
$Label22.Font                    = 'Microsoft Sans Serif,10'

$Label34                         = New-Object system.Windows.Forms.Label
$Label34.text                    = "Destination8"
$Label34.AutoSize                = $true
$Label34.width                   = 25
$Label34.height                  = 10
$Label34.location                = New-Object System.Drawing.Point(220,176)
$Label34.Font                    = 'Microsoft Sans Serif,10'

$Label35                         = New-Object system.Windows.Forms.Label
$Label35.text                    = "Destination9"
$Label35.AutoSize                = $true
$Label35.width                   = 25
$Label35.height                  = 10
$Label35.location                = New-Object System.Drawing.Point(220,199)
$Label35.Font                    = 'Microsoft Sans Serif,10'

$Label36                         = New-Object system.Windows.Forms.Label
$Label36.text                    = "Destination!"
$Label36.AutoSize                = $true
$Label36.width                   = 25
$Label36.height                  = 10
$Label36.location                = New-Object System.Drawing.Point(220,221)
$Label36.Font                    = 'Microsoft Sans Serif,10'


# right arrow 
$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "→"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(187,16)
$Label1.Font                     = 'Microsoft Sans Serif,10'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "→"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(187,40)
$Label2.Font                     = 'Microsoft Sans Serif,10'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "→"
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(187,62)
$Label3.Font                     = 'Microsoft Sans Serif,10'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "→"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(187,85)
$Label4.Font                     = 'Microsoft Sans Serif,10'

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "→"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(187,110)
$Label5.Font                     = 'Microsoft Sans Serif,10'

$Label6                          = New-Object system.Windows.Forms.Label
$Label6.text                     = "→"
$Label6.AutoSize                 = $true
$Label6.width                    = 25
$Label6.height                   = 10
$Label6.location                 = New-Object System.Drawing.Point(187,131)
$Label6.Font                     = 'Microsoft Sans Serif,10'

$Label7                          = New-Object system.Windows.Forms.Label
$Label7.text                     = "→"
$Label7.AutoSize                 = $true
$Label7.width                    = 25
$Label7.height                   = 10
$Label7.location                 = New-Object System.Drawing.Point(187,153)
$Label7.Font                     = 'Microsoft Sans Serif,10'

$Label33                          = New-Object system.Windows.Forms.Label
$Label33.text                     = "→"
$Label33.AutoSize                 = $true
$Label33.width                    = 25
$Label33.height                   = 10
$Label33.location                 = New-Object System.Drawing.Point(187,176)
$Label33.Font                     = 'Microsoft Sans Serif,10'

$Label31                          = New-Object system.Windows.Forms.Label
$Label31.text                     = "→"
$Label31.AutoSize                 = $true
$Label31.width                    = 25
$Label31.height                   = 10
$Label31.location                 = New-Object System.Drawing.Point(187,199)
$Label31.Font                     = 'Microsoft Sans Serif,10'

$Label32                          = New-Object system.Windows.Forms.Label
$Label32.text                     = "→"
$Label32.AutoSize                 = $true
$Label32.width                    = 25
$Label32.height                   = 10
$Label32.location                 = New-Object System.Drawing.Point(187,222)
$Label32.Font                     = 'Microsoft Sans Serif,10'

$Groupbox1                       = New-Object system.Windows.Forms.Groupbox
$Groupbox1.height                = 248
$Groupbox1.width                 = 425
$Groupbox1.text                  = "변경하기"
$Groupbox1.location              = New-Object System.Drawing.Point(256,14)



# 입력창 - 결과창
$input_window                       = New-Object system.Windows.Forms.RichTextBox
$input_window.multiline             = $false
$input_window.width                 = 388
$input_window.height                = 280
$input_window.location              = New-Object System.Drawing.Point(17,339)
$input_window.Font                  = 'Microsoft Sans Serif,10'
$input_window.Multiline             = $true
$input_window.WordWrap              = $false

$result_window                       = New-Object system.Windows.Forms.RichTextBox
$result_window.multiline             = $false
$result_window.width                 = 388
$result_window.height                = 280
$result_window.location              = New-Object System.Drawing.Point(490,339)
$result_window.Font                  = 'Microsoft Sans Serif,10'
$result_window.Multiline             = $true

# 실행 및 저장 버튼
$excute_but                         = New-Object system.Windows.Forms.Button
$excute_but.text                    = "실행"
$excute_but.width                   = 60
$excute_but.height                  = 30
$excute_but.location                = New-Object System.Drawing.Point(415,436)
$excute_but.Font                    = 'Microsoft Sans Serif,10'

$save_but                         = New-Object system.Windows.Forms.Button
$save_but.text                    = "저장"
$save_but.width                   = 60
$save_but.height                  = 30
$save_but.location                = New-Object System.Drawing.Point(379,274)
$save_but.Font                    = 'Microsoft Sans Serif,10'

$loading_but                         = New-Object system.Windows.Forms.Button
$loading_but.text                    = "불러오기"
$loading_but.width                   = 75
$loading_but.height                  = 30
$loading_but.location                = New-Object System.Drawing.Point(477,274)
$loading_but.Font                    = 'Microsoft Sans Serif,10'

$enlarge_but                         = New-Object system.Windows.Forms.Button
$enlarge_but.text                    = "입력창(확대하기)"
$enlarge_but.width                   = 300
$enlarge_but.height                  = 30
$enlarge_but.location                = New-Object System.Drawing.Point(55,304)
$enlarge_but.Font                    = 'Microsoft Sans Serif,10' 

$scrmove_but                         = New-Object system.Windows.Forms.Button
$scrmove_but.text                    = "기록 보기"
$scrmove_but.width                   = 80
$scrmove_but.height                  = 30
$scrmove_but.location                = New-Object System.Drawing.Point(577,274)
$scrmove_but.Font                    = 'Microsoft Sans Serif,10' 


$Label23                         = New-Object system.Windows.Forms.Label
$Label23.text                    = "결과창"
$Label23.AutoSize                = $true
$Label23.width                   = 25
$Label23.height                  = 10
$Label23.location                = New-Object System.Drawing.Point(660,309)
$Label23.Font                    = 'Microsoft Sans Serif,15'

$Label25                         = New-Object system.Windows.Forms.Label
$Label25.text                    = "스크립트 작업창"
$Label25.AutoSize                = $true
$Label25.width                   = 25
$Label25.height                  = 10
$Label25.location                = New-Object System.Drawing.Point(67,17)
$Label25.Font                    = 'Microsoft Sans Serif,10'

$Label26                         = New-Object system.Windows.Forms.Label
$Label26.text                    = "옵션"
$Label26.AutoSize                = $true
$Label26.width                   = 25
$Label26.height                  = 10
$Label26.location                = New-Object System.Drawing.Point(748,37)
$Label26.Font                    = 'Microsoft Sans Serif,16,style=Bold'


$script_window                       = New-Object system.Windows.Forms.RichTextBox
$script_window.width                 = 210
$script_window.height                = 200
$script_window.location              = New-Object System.Drawing.Point(18,40)
$script_window.Font                  = 'Microsoft Sans Serif,10'
$script_window.Multiline             = $true
$script_window.ForeColor             = "White"
$script_window.BackColor             = "Black"

$CheckOpt1                       = New-Object system.Windows.Forms.CheckBox
$CheckOpt1.text                  = "실행 결과 보기"
$CheckOpt1.AutoSize              = $false
$CheckOpt1.width                 = 135
$CheckOpt1.height                = 20
$CheckOpt1.location              = New-Object System.Drawing.Point(720,76)
$CheckOpt1.Font                  = 'Microsoft Sans Serif,10'
$CheckOpt1.Checked               = $true

$CheckOpt2                       = New-Object system.Windows.Forms.CheckBox
$CheckOpt2.text                  = "결과물 자동 복사"
$CheckOpt2.AutoSize              = $false
$CheckOpt2.width                 = 155
$CheckOpt2.height                = 20
$CheckOpt2.location              = New-Object System.Drawing.Point(720,100)
$CheckOpt2.Font                  = 'Microsoft Sans Serif,10'
$CheckOpt2.Checked               = $true

$CheckOpt3                       = New-Object system.Windows.Forms.CheckBox
$CheckOpt3.text                  = "시작 시 자동 불러오기"
$CheckOpt3.AutoSize              = $false
$CheckOpt3.width                 = 175
$CheckOpt3.height                = 20
$CheckOpt3.location              = New-Object System.Drawing.Point(720,124)
$CheckOpt3.Font                  = 'Microsoft Sans Serif,10'
$CheckOpt3.Checked               = $false

$CheckOpt4                       = New-Object system.Windows.Forms.CheckBox
$CheckOpt4.text                  = "종료 시 자동 저장"
$CheckOpt4.AutoSize              = $false
$CheckOpt4.width                 = 155
$CheckOpt4.height                = 20
$CheckOpt4.location              = New-Object System.Drawing.Point(720,148)
$CheckOpt4.Font                  = 'Microsoft Sans Serif,10'

$evecode_but                     = New-Object system.Windows.Forms.Button
$evecode_but.text                = "복사하기"
$evecode_but.width               = 75
$evecode_but.height              = 32
$evecode_but.location            = New-Object System.Drawing.Point(151,244)
$evecode_but.Font                = 'Microsoft Sans Serif,10'

$Label30                          = New-Object system.Windows.Forms.Label
$Label30.text                     = "이벤트 코드"
$Label30.AutoSize                 = $true
$Label30.width                    = 25
$Label30.height                   = 10
$Label30.location                 = New-Object System.Drawing.Point(59,241)
$Label30.Font                     = 'Microsoft Sans Serif,10'

$code_box                        = New-Object system.Windows.Forms.TextBox
$code_box.multiline              = $false
$code_box.text                   = "$this-id-content"
$code_box.width                  = 100
$code_box.height                 = 20
$code_box.location               = New-Object System.Drawing.Point(50,261)
$code_box.Font                   = 'Microsoft Sans Serif,10'
$code_box.Text                   = '$this-id-content'
$code_box.ReadOnly               =  $true

$Label40                         = New-Object system.Windows.Forms.Label
$Label40.text                    = "코드 선택"
$Label40.AutoSize                = $true
$Label40.width                   = 22
$Label40.height                  = 10
$Label40.location                = New-Object System.Drawing.Point(727,209)
$Label40.Font                    = 'Microsoft Sans Serif,16,style=Bold'

$CodeBox                       = New-Object system.Windows.Forms.ComboBox
$CodeBox.text                  = "js"
$CodeBox.width                 = 100
$CodeBox.height                = 20
$CodeBox.location              = New-Object System.Drawing.Point(733,239)
$CodeBox.Font                  = 'Microsoft Sans Serif,10'

$Code_list = @("cpp","c-sharp","bash","css","js","java","php","perl","py","vb","sql","xml","text","jfx","cf","as3","erl","diff","cf")
foreach($code_item in $Code_list)
{
  $tras = $CodeBox.Items.add($code_item)
}

$Groupbox1.controls.AddRange(@($Label31,$Label32,$Label33,$Label34,$Label35,$Label36,$Label37,$Label38,$Label39,$symbol10,$symbol1,$symbol2,$symbol3,$symbol4,$symbol5,$symbol6,$symbol7,$symbol8,$symbol9,$Label1,$rep_tag1,$rep_tag2,$rep_tag3,$rep_tag4,$rep_tag5,$rep_tag6,$rep_tag7,$rep_tag8,$rep_tag9,$rep_tag10,$Label2,$Label3,$Label4,$Label5,$Label6,$Label7,$Label9,$Label10,$Label11,$Label12,$Label13,$Label14,$Label15,$Label16,$Label17,$Label18,$Label19,$Label20,$Label21,$Label22))
$Form.controls.AddRange(@($scrmove_but,$evecode_but,$Label30,$code_box,$Label26,$CheckOpt1,$CheckOpt2,$CheckOpt3,$CheckOpt4,$loading_but,$script_window,$Groupbox1,$input_window,$save_but,$excute_but,$result_window,$Label23,$Label25,$CodeBox,$Label40,$enlarge_but))


function Get_title
{ Param ([String]$chr , [String]$str) 

    $index = $str.IndexOf($chr) + 1
    
    if ( $index -gt 0)
    { 
      $title = $str.Substring($index,$str.Length - $index)
      return $title

    } else {
        return $false
    }
   
}

function exist_value
{ Param ([String]$Data) 

  if ( [String]::IsNullOrEmpty($Data) -eq $true )
  {
    return $false
  } else { return $true }
  
}

function convert_tag
{ Param ([String]$source , [String]$Destination , [string[]]$Data) 
 

    # tag replace
    for ($i=0; $i -lt $Data.Length; $i++)
    {
          if ( ($title = Get_title -chr $source -str $Data[$i]) -ne $false )
          {  
             $Data[$i] = $Data[$i] -replace [RegEx]::Escape($title),''
    
             $Data[$i] = $Data[$i] -replace [RegEx]::Escape($source),$Destination
             $Data[$i] = $Data[$i] -replace [RegEx]::Escape('$this-id-content'),$title
             
          } 
    }
    
    return $Data


}
function excute { 

    $text = @()
    $symbol_text = @()
    $replace_tag = @()

    $symbol_boxes1 = @($symbol1,$symbol2,$symbol3,$symbol4)
    $symbol_boxes2 = @($symbol5,$symbol6,$symbol7,$symbol8,$symbol9)
    $rep_boxes1    = @($rep_tag1,$rep_tag2,$rep_tag3,$rep_tag4)
    $rep_boxes2    = @($rep_tag5,$rep_tag6,$rep_tag7,$rep_tag8,$rep_tag9)
    
    $text = $input_window.Text
    $text = $text -replace '&','&amp;'
    $text = $text -replace '<','&lt;'
    $text = $text -replace '>','&gt;'

    # get replace data
    $symbol_boxes1 | % { if ( (exist_value -Data $_.Text) -eq $true ) { $symbol_text += $_.Text } }
    $rep_boxes1 | % { if ( (exist_value -Data $_.Text) -eq $true ) { $replace_tag    += $_.Text } }

    # symbol10 - 코드 스크립트용
    $script_chr_code = 'ⓢ'
    $script_chk_flag = 1
        if (  $symbol10.Text -eq $script_chr_code ) 
        { 
            $text = convert_range_code -char_code $symbol10.Text -Destination $rep_tag10.Text -Data $text    
            }
            $text = $text -Split('\n') | % { 
            $stmp = $_ 
            
            if ( ($stmp -match $script_chr_code) -eq $true )
            { $script_chk_flag = -$script_chk_flag } # 한 라인에 2개
            if ( ($stmp -match ($script_chr_code+'.*?'+$script_chr_code)) -eq $true )
            { $script_chk_flag = 1 }
            
            
            
            if ( $script_chk_flag -eq 1 )
                { $stmp + '<br>'}
            else { $stmp + [Environment]::NewLine }
         } 
           $text = $text -replace $script_chr_code,''
    ##################################################
          
           
          
         
        for( $i = 0; $i -lt $symbol_text.Length; $i++)
        {
        $text = convert_tag -source $symbol_text[$i] -Destination $replace_tag[$i] -Data $text
        }
       
       
       
       # -----------------Convert_Font---------------------------
       $symbol_text = @()
       $replace_tag = @()
       
       $symbol_boxes2 | % { if ( (exist_value -Data $_.Text) -eq $true ) { $symbol_text += $_.Text } }
       $rep_boxes2 | % { if ( (exist_value -Data $_.Text) -eq $true ) { $replace_tag    += $_.Text } }

        for( $i = 0; $i -lt $symbol_text.Length; $i++)
        {
            if ( $symbol_text[$i] -ne '◈' -and $symbol_text[$i] -ne 'ⓒ' -and $symbol_text[$i] -ne 'ⓜ' -and $symbol_text[$i] -ne 'ⓑ' -and $symbol_text[$i] -ne 'ⓠ')
            {
            $text = convert_font -source $symbol_text[$i] -Destination $replace_tag[$i] -Data $text
            }
            else 
            {
            $text = convert_range_code -char_code $symbol_text[$i] -Destination $replace_tag[$i] -Data $text
            }
        }
       
        # result
        $result_window.Text = $default_css_code + '<div id="custom_code_text">' + $text + '</div>'
        
        result_print
}

function convert_range_code
{ Param ([String]$char_code,[String]$Destination , [string[]]$Data)
    
 
    $exprs = $char_code + '.*?([\w|\t|\r|\W]*?)' + $char_code

    $htm_mat = [regex]::matches($Destination, '(<([^>]+)>)')

    $start_code = ''
    $end_code = ''       


    
 for( $i=0; $i -lt $htm_mat.Count/2; $i++ )
    {
      $start_code += $htm_mat[$i].Value
      $end_code = $htm_mat[$htm_mat.Count-1 - $i ].Value + $end_code
    }


      if (  $char_code -ne 'ⓢ' ) {
       $Data = [regex]::escape($Data) -replace $exprs, ($start_code + ' ' + '$1' + $end_code) 
      } else {
        $Data = [regex]::escape($Data) -replace $exprs, ($char_code + $start_code + ' ' + '$1' + $end_code + $char_code)
      }
        $Data = [regex]::unescape($Data)
   
    return $Data
    
}

function save
{
  $symbol_text = @()
  $symbol_index = @()
  
  $replace_tag = @()
  $replace_index = @()
  
  $input_text = @()
  $result_text = @()
  $script_text = @()
  
  
      # get replace data
      $index = 0
      $symbol_boxes = @($symbol1,$symbol2,$symbol3,$symbol4,$symbol5,$symbol6,$symbol7,$symbol8,$symbol9,$symbol10)
      $symbol_boxes | % { 
          
          if ( (exist_value -Data $_.Text) -eq $true )
          { 
            $symbol_index += $index
            $symbol_text += $_.Text;
          }
          $index++
        }

      $index = 0
      $rep_boxes = @($rep_tag1,$rep_tag2,$rep_tag3,$rep_tag4,$rep_tag5,$rep_tag6,$rep_tag7,$rep_tag8,$rep_tag9,$rep_tag10)
      $rep_boxes | % { 
          
          if ( (exist_value -Data $_.Text) -eq $true )
          { 
            $replace_index += $index
            $replace_tag   += $_.Text;
          }
          $index++
        }
    
    if ( (exist_value -Data $input_window.Text) -eq $true ) { $input_text = $input_window.Text }
    if ( (exist_value -Data $result_window.Text) -eq $true ) { $result_text = $result_window.Text }
    if ( (exist_value -Data $script_window.Text) -eq $true ) { $script_text = $script_window.Text }

    # get value from textbox & join for csv file
    $tmp_input = @($symbol_text,$symbol_index,$replace_tag,$replace_index,$input_text,$result_text,$script_text)
    $inputobject = @()

    $count = -1
    $location = @()
    for($i=0; $i -lt $tmp_input.Length; $i++)
    { 
        if ( (exist_value -Data $tmp_input[$i]) -eq $true )
        {    $count++; $location+= $i;
             $inputobject += $tmp_input[$i] -join ','
        }
    } $count = 0;
    
    


    # export string to csv
    $path = 'form_log.csv'
    $header = @('symbol_text','symbol_index' , 'rep_text' , 'rep_index' , 'input_text' , 'result_text', 'script_text')

    $report = New-Object psobject
    $inputobject | % { 
    $report | Add-Member -MemberType NoteProperty -name $header[$location[$count]] -Value $_
    $count++
    }
    $report | export-csv $Path -NoTypeInformation -Encoding utf8 
    [System.Windows.Forms.MessageBox]::Show('저장되었습니다.')

}

function LoadingData
{
    $log_file_name = 'form_log.csv'

    if ( (Test-Path $log_file_name) -eq $true ) 
    {
    
    $csv = Import-Csv -Path $log_file_name 
      
    $symbol_boxes = @($symbol1,$symbol2,$symbol3,$symbol4,$symbol5,$symbol6,$symbol7,$symbol8,$symbol9,$symbol10)
    $rep_boxes = @($rep_tag1,$rep_tag2,$rep_tag3,$rep_tag4,$rep_tag5,$rep_tag6,$rep_tag7,$rep_tag8,$rep_tag9,$rep_tag10)
    $symbol_boxes | % { $_.Text = '' }
    $rep_boxes | % { $_.Text = '' }
    $input_window.Text = ''
    $result_window.Text = ''
    $script_window.Text = ''
    
    # import csv to string
    
    
    $csv_symbol_index = $csv.symbol_index -split(',')
    $csv_symbol_text  = $csv.symbol_text -split(',')
    $csv_rep_index = $csv.rep_index -split(',')
    $csv_rep_text  = $csv.rep_text -split(',')
    $csv_input_text = $csv.input_text
    $csv_result_text = $csv.result_text
    $csv_script_text = $csv.script_text



    ## loading
    for($i=0; $i -lt $csv_symbol_text.Length; $i++) 
    {
      $symbol_boxes[$csv_symbol_index[$i]].Text = $csv_symbol_text[$i]
    }
    for($i=0; $i -lt $csv_rep_index.Length; $i++) 
    {
        $rep_boxes[$csv_rep_index[$i]].Text = $csv_rep_text[$i]
    }
    
    $input_window.Text = $csv_input_text
    $result_window.Text = $csv_result_text
    $script_window.Text = $csv_script_text
    } else { [System.Windows.Forms.MessageBox]::Show('로그파일이 존재하지 않습니다.')  }
}

function request_save
{
        if ( $CheckOpt4.Checked -eq $true )
        { save }       
}


function save_option
{
    # export option to csv
    $path = 'form_setting.csv'
    
    $header = @('result_view','auto_copy','auto_load','auto_save')
    $inputobject = @($CheckOpt1,$CheckOpt2,$CheckOpt3,$CheckOpt4)

    $report = New-Object psobject
    for($i=0; $i -lt $inputobject.Length; $i++) 
    {
    $report | Add-Member -MemberType NoteProperty -name $header[$i] -Value $inputobject[$i].Checked
    }
    $report | export-csv $Path -NoTypeInformation -Encoding utf8 
}

function Load_option
{
    # import csv to option
    $log_file_name = 'form_setting.csv'

    if ( (Test-Path $log_file_name) -eq $true ) 
    {
        $csv_option = Import-Csv -Path $log_file_name
        
        try {
       
        $CheckOpt1.Checked = [System.Convert]::ToBoolean($csv_option.result_view) 
        $CheckOpt2.Checked = [System.Convert]::ToBoolean($csv_option.auto_copy) 
        $CheckOpt3.Checked = [System.Convert]::ToBoolean($csv_option.auto_load) 
        $CheckOpt4.Checked = [System.Convert]::ToBoolean($csv_option.auto_save)
        } catch [FormatException] {
          
        }

        
    }
    
}

function result_print {

        # copy
        if ( $CheckOpt2.Checked -eq $true )
        {
        $result_window.SelectAll() 
        $result_window.Copy() 
        }
        
        # export html
        $result_window.Text > 'string_to_tag.html'
        
        # open html
        if ( $CheckOpt1.Checked -eq $true )
        {   
        $html_path = $scriptPath + '\' + 'string_to_tag.html'
        $html_path = ([System.Uri]$html_path).AbsoluteUri
        $browser   = [System.Diagnostics.Process]::Start("chrome.exe", $html_path)                      
        }
        
        

}
function convert_font {
Param ([String]$source , [String]$Destination , [string[]]$Data)
    
    # 단어를 찾는다. ex) 와이어샤크
    # 다음과 같이 입힌다. <font>와이어샤크</font>

    
    $Data = $Data -replace [RegEx]::Escape($source),$Destination
    $Data = $Data -replace [RegEx]::Escape('$this-id-content'),$source
    return $Data
    
}
function find_replace_char {
Param ([String]$char,[Drawing.Color]$color)

$len = $en_input_window.TextLength;
      $index = 0;
      $lastIndex = $en_input_window.Text.LastIndexOf($char);

       while ( $index -lt $lastIndex )
       {
        $en_input_window.Find($char, $index, $len, [System.Windows.forms.RichtextBoxFinds]::None);
        $en_input_window.SelectionBackColor = $color;
        $index = $en_input_window.Text.IndexOf($char, $index) + 1;
       }      
}

function char_replace {

    $color_list = @([Drawing.Color]::red,[Drawing.Color]::Blue,[Drawing.Color]::DarkGray,
    [Drawing.Color]::MediumSlateBlue,[Drawing.Color]::Green,[Drawing.Color]::DarkCyan,
    [Drawing.Color]::Plum,[Drawing.Color]::Chocolate,[Drawing.Color]::AliceBlue,[Drawing.Color]::Bisque)
    $char_list = @('●','◎','ⓑ','ⓠ','ⓒ','ⓜ','◈','ⓢ','▷','※')

    $color_ind = 0;

    foreach( $one_char in $char_list)
    { 
      find_replace_char -char $one_char -color $color_list[$color_ind];
      $color_ind++
    }

}


$excute_but.Add_Click({ 

    if ( (exist_value -Data $input_window.Text) -eq $true )
    { excute } else 
    { [System.Windows.Forms.MessageBox]::Show('값이 없습니다') }

})
$save_but.Add_Click({ save })
$loading_but.Add_Click({ LoadingData })
$Form.Add_Closing({request_save})
$CheckOpt1.Add_Click({ save_option })
$CheckOpt2.Add_Click({ save_option })
$CheckOpt3.Add_Click({ save_option })
$CheckOpt4.Add_Click({ save_option })
$scrmove_but.Add_Click({ Invoke-Item $scriptPath })

$enlarge_but.Add_Click({ 
    $en_input_window.Text = $input_window.Text  
    char_replace;
 
    [void]$TextArea_zoom.ShowDialog()

     
})

$TextArea_zoom.Add_Closing({ 

$input_window.Text = $en_input_window.Text 

    $folder_name = '편집기록'
    $test_path = $scriptPath + '\' + $folder_name

    if ( (Test-Path $test_path) -ne $true )
    {
      New-Item -Path $scriptPath -Name $folder_name -ItemType "directory"
    } 
    $outputfile = Get-Date -Format "yyyy/MM/dd HH시mm분(dddd)"
    $outputfile = $scriptPath + '\' + $folder_name + '\' + $outputfile + '.txt'
    Set-Content -Path $outputfile -Value $en_input_window.Text -Encoding utf8
    



})

$evecode_but.Add_Click({ $code_box.SelectAll();$code_box.Copy();})

# click code box 
$CodeBox.add_SelectedIndexChanged({$rep_tag10.Text = '<pre class="brush:' + $CodeBox.SelectedItem.ToString() + '"></pre>' } )

# Load option setting
Load_option;

# auto data load
if ( $CheckOpt3.Checked -eq $true )
{ LoadingData }


[void]$Form.ShowDialog()
