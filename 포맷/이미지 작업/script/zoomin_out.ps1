param([string]$file_name, [String]$resize_x, $resize_y=100, [String]$delete_opt)

if ( $file_name -ne "" -and $resize_x -ne "" )
{

   $file_name = Split-Path $file_name -leaf
   echo $resize_y
   $resize_size = ""
   if ( $resize_x -match "x" )
   {
        $resize_size = [String]$resize_x + 'x' + [String]$resize_y + '!'
   } else { 
        $resize_size = [String]$resize_x + '%x' + [String]$resize_y + '%'
   }
        $result_img_name = ($file_name -replace [System.IO.Path]::GetExtension($file_name)) + "_zoom" + [System.IO.Path]::GetExtension($file_name)    
        magick convert $file_name -resize $resize_size -quality 100 $result_img_name     

         if ( $delete_opt -eq "d" )
         {
            Remove-Item $file_name
        }

} else {  
echo ""
echo "파일 이름 및 확대/축소 하려는 이미지의 사이즈를 입력하세요." 
echo 'example(2배축소)> zoomin_out.ps1 [image.png] [50 - x], [50 - y]'
echo 'example(크기지정)> zoomin_out.ps1 [image.png] [250x350 - (x)x(y)]'
echo ""
}
