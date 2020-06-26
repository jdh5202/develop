$file_name = "problem.xml"
$xPath = '//problems'
$xPath2 = '//problem'

Set-ExecutionPolicy Unrestricted

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
Set-Location $scriptPath
$file_name = $scriptPath + '\' + $file_name

function make_xml {
Param ([String]$file_name) 



    if ( !(Test-Path $file_name ) -eq $true )
    { 
    
    # Create The Document
    $XmlWriter = New-Object System.XMl.XmlTextWriter($file_name,$Null)
 
    # Set The Formatting
    $xmlWriter.Formatting = "Indented"
    $xmlWriter.Indentation = "4"
 
    # Write the XML Decleration
    $xmlWriter.WriteStartDocument()
 
    # Write Root Element
    $xmlWriter.WriteStartElement("problems")


    # Write Close Tag for Root Element
    $xmlWriter.WriteEndElement() 
 
    # End the XML Document
    $xmlWriter.WriteEndDocument()
 
 
    # Finish The Document
    $xmlWriter.Finalize
    $xmlWriter.Flush
    $xmlWriter.Close() 
    
    $Load_xml = [xml](Get-Content $file_name -Encoding utf8 )
    $max_num.Text = 1
    
    } else { 

     $Load_xml = [xml](Get-Content $file_name -Encoding utf8 )
     $apn_node = $Load_xml.SelectSingleNode($xPath)
     $node_cnt = $apn_node.selectnodes($xPath2).Count + 1
     if ( $node_cnt -eq 0 ) { $node_cnt = 1 }
     $max_num.Text = $node_cnt

    }

}
 




Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '1370,816'
$Form.text                       = "Form"
$Form.TopMost                    = $false
$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen; 
$Form.StartPosition = $CenterScreen; 
$Form.AutoSizeMode = "GrowAndShrink"
$Form.MaximizeBox = $false

$prob                       = New-Object system.Windows.Forms.RichTextBox
$prob.multiline              = $false
$prob.width                  = 1122
$prob.height                 = 350
$prob.location               = New-Object System.Drawing.Point(147,15)
$prob.Font                   = 'Microsoft Sans Serif,28'
$prob.Multiline             = $true
$prob.WordWrap              = $true

$answer                        = New-Object system.Windows.Forms.RichTextBox
$answer.multiline              = $false
$answer.width                  = 1122
$answer.height                 = 350
$answer.location               = New-Object System.Drawing.Point(147,393)
$answer.Font                   = 'Microsoft Sans Serif,28'
$answer.Multiline             = $true
$answer.WordWrap              = $true

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "문제"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(60,142)
$Label1.Font                     = 'Microsoft Sans Serif,19'

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "답"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(75,542)
$Label2.Font                     = 'Microsoft Sans Serif,19'

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = ""
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.location                 = New-Object System.Drawing.Point(1,119)
$Label3.Font                     = 'Microsoft Sans Serif,11'

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "변경"
$Label4.AutoSize                 = $true
$Label4.width                    = 25
$Label4.height                   = 10
$Label4.location                 = New-Object System.Drawing.Point(1,193)
$Label4.Font                     = 'Microsoft Sans Serif,12'

$Label5                          = New-Object system.Windows.Forms.Label
$Label5.text                     = "이전"
$Label5.AutoSize                 = $true
$Label5.width                    = 25
$Label5.height                   = 10
$Label5.location                 = New-Object System.Drawing.Point(1,233)
$Label5.Font                     = 'Microsoft Sans Serif,12'

$Label6                          = New-Object system.Windows.Forms.Label
$Label6.text                     = "다음"
$Label6.AutoSize                 = $true
$Label6.width                    = 25
$Label6.height                   = 10
$Label6.location                 = New-Object System.Drawing.Point(1,273)
$Label6.Font                     = 'Microsoft Sans Serif,12'


$pro_num                         = New-Object system.Windows.Forms.TextBox
$pro_num.multiline               = $false
$pro_num.width                   = 90
$pro_num.height                  = 20
$pro_num.location                = New-Object System.Drawing.Point(50,189)
$pro_num.Font                    = 'Microsoft Sans Serif,14'


$max_num                         = New-Object system.Windows.Forms.TextBox
$max_num.multiline               = $false
$max_num.width                   = 90
$max_num.height                  = 20
$max_num.location                = New-Object System.Drawing.Point(50,269)
$max_num.Font                    = 'Microsoft Sans Serif,14'
$max_num.Enabled                 = $false 

$chg_num                         = New-Object system.Windows.Forms.TextBox
$chg_num.multiline               = $false
$chg_num.width                   = 90
$chg_num.height                  = 20
$chg_num.location                = New-Object System.Drawing.Point(50,229)
$chg_num.Font                    = 'Microsoft Sans Serif,14'
$chg_num.Enabled                 = $false 

$reg                             = New-Object system.Windows.Forms.Button
$reg.text                        = "등록하기"
$reg.width                       = 110
$reg.height                      = 40
$reg.location                    = New-Object System.Drawing.Point(578,761)
$reg.Font                        = 'Microsoft Sans Serif,12'

$load                             = New-Object system.Windows.Forms.Button
$load.text                        = "불러오기"
$load.width                       = 110
$load.height                      = 40
$load.location                    = New-Object System.Drawing.Point(708,761)
$load.Font                        = 'Microsoft Sans Serif,12'

$upb                             = New-Object system.Windows.Forms.Button
$upb.text                        = "▲"
$upb.width                       = 55
$upb.height                      = 40
$upb.location                    = New-Object System.Drawing.Point(15,306)
$upb.Font                        = 'Microsoft Sans Serif,16'

$dob                             = New-Object system.Windows.Forms.Button
$dob.text                        = "▼"
$dob.width                       = 55
$dob.height                      = 40
$dob.location                    = New-Object System.Drawing.Point(75,306)
$dob.Font                        = 'Microsoft Sans Serif,16'

$reb                             = New-Object system.Windows.Forms.Button
$reb.text                        = "⊙"
$reb.width                       = 45
$reb.height                      = 30
$reb.location                    = New-Object System.Drawing.Point(50,351)
$reb.Font                        = 'Microsoft Sans Serif,14'

$xml_open                             = New-Object system.Windows.Forms.Button
$xml_open.text                        = "XML 열기"
$xml_open.width                       = 110
$xml_open.height                      = 40
$xml_open.location                    = New-Object System.Drawing.Point(18,400)
$xml_open.Font                        = 'Microsoft Sans Serif,14'

$xml_copy                             = New-Object system.Windows.Forms.Button
$xml_copy.text                        = "XML 변수 복사"
$xml_copy.width                       = 110
$xml_copy.height                      = 27
$xml_copy.location                    = New-Object System.Drawing.Point(18,450)
$xml_copy.Font                        = 'Microsoft Sans Serif,10'

$xml_load                             = New-Object system.Windows.Forms.Button
$xml_load.text                        = "XML 만들기"
$xml_load.width                       = 110
$xml_load.height                      = 27
$xml_load.location                    = New-Object System.Drawing.Point(18,580)
$xml_load.Font                        = 'Microsoft Sans Serif,10'

$clear_data                             = New-Object system.Windows.Forms.Button
$clear_data.text                        = "창 비우기"
$clear_data.width                       = 110
$clear_data.height                      = 27
$clear_data.location                    = New-Object System.Drawing.Point(18,490)
$clear_data.Font                        = 'Microsoft Sans Serif,10'


$Form.controls.AddRange(@($clear_data,$upb,$dob,$reb,$prob,$xml_open,$answer,$Label1,$Label2,$Label3,$Label4,$Label5,$Label6,$reg,$max_num,$load,$chg_num,$pro_num,$xml_copy,$xml_load))

function add_node
{ 

    if ( [String]::IsNullOrEmpty($prob.Text) -eq $false -and [String]::IsNullOrEmpty($answer.Text) -eq $false )
        {
                $Load_xml = [xml](Get-Content $file_name -Encoding utf8 )


                if ( ([String]::IsNullOrEmpty($pro_num.Text) -eq $true) ) 
                {
                    $node_num = [int]($max_num.Text)                
                    $pro_Element = $Load_xml.CreateElement("problem")
                    $pro_Element.SetAttribute('id',$node_num)
                    $pro_Element.InnerText = $prob.Text -replace "`n", "<br>"

                    $ans_Element = $Load_xml.CreateElement("answer") 
                    $ans_Element.SetAttribute('id',$node_num) 
                    $ans_Element.InnerText = $answer.Text -replace "`n", "<br>"
           
                    
                    $apn_node = $Load_xml.SelectSingleNode($xPath)
                    $apn_node.AppendChild($pro_Element)
                    $apn_node.AppendChild($ans_Element)
                    $prob.Text = ""
                    $answer.Text = ""
                    $max_num.Text = $node_num + 1
                    $label3.Text = "문제 개수: "+ $node_num + "개"
                    
                    
                } elseif( [int]$max_num.Text -gt [int]$pro_num.Text  ) 
                  {
                
                    $pro_page = "//problem[@id='" + $pro_num.Text + "']"
                    $ans_page = "//answer[@id='" + $pro_num.Text + "']"
                    
                    $Load_xml.SelectSingleNode($pro_page) | % { $_.'#text' = $prob.Text -replace "`n", "<br>" }
                    $Load_xml.SelectSingleNode($ans_page) | % { $_.'#text' = $answer.Text -replace "`n", "<br>"} 
                  } else { [System.Windows.Forms.MessageBox]::Show('없는 문제입니다.') } 
                  
                  $Load_xml.Save($file_name)
                
        } else { [System.Windows.Forms.MessageBox]::Show('문제 또는 답이 입력되지 않았습니다.')   }

        exist_chk
}
 

function load_node
{ 
    if ( ([String]::IsNullOrEmpty($pro_num.Text) -eq $false) -and ([int]$max_num.Text -gt [int]$pro_num.Text) )
      {
        $pro_page = "//problem[@id='" + $pro_num.Text + "']"
        $ans_page = "//answer[@id='" + $pro_num.Text + "']"
      
        $Load_xml = [xml](Get-Content $file_name -Encoding utf8 )
        $prob.Text = $Load_xml.SelectSingleNode($pro_page) | % { $_.'#text' }
        $answer.Text = $Load_xml.SelectSingleNode($ans_page) | % { $_.'#text'}
        
        $prob.Text = $prob.Text -replace "<br>","`n"
        $answer.Text = $answer.Text -replace "<br>","`n"

        $chg_num.Text = $pro_num.Text     
        
      } else { [System.Windows.Forms.MessageBox]::Show('없는 문제입니다.') }

      exist_chk
}

function exist_chk
{
   $Load_xml = [xml](Get-Content $file_name -Encoding utf8 )
   $apn_node = $Load_xml.SelectSingleNode($xPath)
   $node_cnt = $apn_node.selectnodes($xPath2).Count

   $pro_page = "//problem"
   $ans_page = "//answer"
   
   $tmp = $Load_xml.selectnodes($pro_page).'id'
   $tmp2 = $Load_xml.selectnodes($pro_page).'id' | select -Unique
   if ( $tmp.Count -ne $tmp2.Count )
   {
    [System.Windows.Forms.MessageBox]::Show('중복된 노드를 발견했습니다.')
   }
   
}

$reg.Add_Click({ add_node; Copy-Item -Path "problem.xml" -Destination "D:\지경배\공부모음\problem.xml"})
$load.Add_Click({ load_node  })

$upb.Add_Click({ 

     if ( ([int]$max_num.Text -gt [int]$pro_num.Text +1) ) 
     { 
         $pro_num.Text = [int]$pro_num.Text + 1
         load_node  
     }

})

$dob.Add_Click({ 

    if ( ([String]::IsNullOrEmpty($pro_num.Text) -eq $true)  )
    {
        $pro_num.Text = [int]($max_num.Text) 
    }
    
    if ( 1 -lt [int]$pro_num.Text ) 
    { 
         $pro_num.Text = [int]$pro_num.Text - 1
         load_node  
    }
})

$reb.Add_Click({ $pro_num.Text = "" })

$xml_open.Add_Click({ 

$open_path = ([System.Uri]$file_name).AbsoluteUri
$browser   = [System.Diagnostics.Process]::Start("chrome.exe", $open_path) 

})

$xml_copy.Add_Click({

$Load_xml_data_name = "problem"
$Load_xml_data_name += '.xml'
$Load_xml_path =  $scriptPath + '\' + $Load_xml_data_name
     
$Load_xml_data = Get-Content $Load_xml_path -Encoding utf8
$Load_xml_data = $Load_xml_data -replace ('\\','\\')
$Load_xml_data = $Load_xml_data -replace ("'","\'")

$datas = @()
$Load_xml_data | % { $datas += "xml+='" + $_ + "';" }

$datas | clip

})

$xml_load.Add_Click({


    if ( [String]::IsNullOrEmpty($prob.Text) -eq $false )
    {
     
     $word_db = $prob.Text -split "\n"


     $Load_xml_data_name = Read-host "만들 파일 이름을 입력하세요."
     $Load_xml_data_name += '.xml'
     $Load_xml_data_name =  $scriptPath + '\' + $Load_xml_data_name
     
     make_xml -file_name $Load_xml_data_name
     
     $Load_xml_data = [xml](Get-Content $Load_xml_data_name -Encoding utf8 )   
     
      for( $node_num = 0; $node_num -lt $word_db.Length; $node_num++  )
      {
                    $split_data = $word_db[$node_num] -split "\t"
     
                    $pro_Element = $Load_xml_data.CreateElement("problem")
                    $pro_Element.SetAttribute('id',$node_num+1)
                    $pro_Element.InnerText = $split_data[0]

                    $ans_Element = $Load_xml_data.CreateElement("answer") 
                    $ans_Element.SetAttribute('id',$node_num+1) 
                    $ans_Element.InnerText = $split_data[1]
           
                    $apn_node = $Load_xml_data.SelectSingleNode($xPath)
                    $apn_node.AppendChild($pro_Element)
                    $apn_node.AppendChild($ans_Element)
                    
                    
      } $Load_xml_data.Save($Load_xml_data_name)
                    

    }



                   
                



})




$clear_data.Add_Click({

$prob.Text = ""
$answer.Text = ""
$pro_num.Text = ""

})

make_xml -file_name $file_name



[void]$Form.ShowDialog()
