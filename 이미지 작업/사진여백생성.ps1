param([string]$file_name, [string]$size, [string]$path = ".\")

if ( $file_name -ne ""  )
{
  
    $height = magick identify -format '%h' $file_name
    
    if ($size -eq "") { $size = "1480x" + $height }

    $newfilename = " _wspace " + $file_name

    magick convert -size $size xc:white $file_name -gravity center -composite $newfilename
    
    $info = magick identify -format '%wx%h' $newfilename
    echo "파일 정보: $info "
} else {  echo "파일 이름을 입력하세요." }
