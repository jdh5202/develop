param([string]$file_name, [string]$size)

if ( $file_name -ne ""  )
{
    $file_name = $file_name -replace '.\\',''

    $height = magick identify -format '%h' $file_name
    
    if ($size -eq "") { $size = "1480x" + $height }
    else {  $size = $size + "x" + $height }

    $newfilename = $file_name -replace [System.IO.Path]::GetExtension($file_name) + "_wsp" + [System.IO.Path]::GetExtension($big_size_image)

    magick convert -size $size xc:white $file_name -gravity center -composite $newfilename
    
    $info = magick identify -format '%wx%h' $newfilename
    echo "파일 정보: $info "
} else {  
echo ""
echo "이미지 파일명을 입력하세요." 
echo 'example> margin_image.ps1 [image.png] [height_size - px]'
echo ""
}
