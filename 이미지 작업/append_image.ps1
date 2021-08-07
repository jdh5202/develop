param([string]$file_name1, [string]$file_name2, [string]$direction, $white_space=10, $delete_opt, $border)

function marge {
Param ([String]$big_size_image, [String]$result_img_x, [String]$result_img_y, [String]$img_file, [int]$white_space, [String]$direction, [String]$img_dir) 
 
     # 임시 이미지 파일 이름, 최종 파일명
    $cache_file_name = "tmp_cache_img.png"
    $result_img_name = ($big_size_image -replace [System.IO.Path]::GetExtension($big_size_image)) + "_apd" + [System.IO.Path]::GetExtension($big_size_image)
    $result_img = ""
    # 사이즈가 큰 이미지 파일을 축소하여 임시 이미지 파일로 저장
    
    if ( $img_dir -eq "w" ) { $result_img = $result_img_x + "x" + $result_img_y }
    elseif ( $img_dir -eq "h" ) { $result_img = $result_img_x }
    
    magick convert $big_size_image -resize $result_img -quality 100 $cache_file_name
   
    if ( $border -eq "b" ) 
    {
        magick.exe convert $img_file -bordercolor black -border 2 ("border_"+$img_file)
        magick.exe convert $cache_file_name -bordercolor black -border 2 $cache_file_name
    }

    # 임시 이미지 파일 사이즈 획득
    $cache_file_x = magick identify -format '%w' $cache_file_name
    $cache_file_y = magick identify -format '%h' $cache_file_name

    $cache_img_size = ""
    if ( $img_dir -eq "w" ) { $cache_img_size = [String](([Int]$cache_file_x)+$white_space) + "x" + $cache_file_y }
    elseif ( $img_dir -eq "h" ) { $cache_img_size = $cache_file_x + "x" + [String](([int]$cache_file_y+$white_space)) }

    # 임시 이미지 파일에 여백 추가
    ## 가로
    if ( $direction -eq "left" -and $img_dir -eq "w" ) { magick convert -size $cache_img_size xc:white $cache_file_name -gravity east -composite $cache_file_name }
    elseif ( $direction -eq "right" -and $img_dir -eq "w" ) { magick convert -size $cache_img_size xc:white $cache_file_name -gravity west -composite $cache_file_name } 
    
    ## 세로
    if ( $direction -eq "left" -and $img_dir -eq "h" ) { magick convert -size $cache_img_size xc:white $cache_file_name -gravity north -composite $cache_file_name }
    elseif ( $direction -eq "right" -and $img_dir -eq "h" ) { magick convert -size $cache_img_size xc:white $cache_file_name -gravity south -composite $cache_file_name }

    # 이미지 이어붙이기
    
    ## 테두리 존재
    if ( $border -eq "b")
    {
        ### 가로
        if ( $direction -eq "left" -and $img_dir -eq "w" ) { magick convert +append ("border_"+$img_file) $cache_file_name $result_img_name }
        elseif ( $direction -eq "right" -and $img_dir -eq "w" ) { magick convert +append $cache_file_name ("border_"+$img_file) $result_img_name }
        ### 세로
        if ( $direction -eq "left" -and $img_dir -eq "h" ) { magick convert -append $cache_file_name ("border_"+$img_file) $result_img_name }
        elseif ( $direction -eq "right" -and $img_dir -eq "h" ) { magick convert -append ("border_"+$img_file) $cache_file_name $result_img_name }
        remove-item ("border_"+$img_file)

    } else {

    ## 테두리 x
        ### 가로
        if ( $direction -eq "left" -and $img_dir -eq "w" ) { magick convert +append $img_file $cache_file_name $result_img_name }
        elseif ( $direction -eq "right" -and $img_dir -eq "w" ) { magick convert +append $cache_file_name $img_file $result_img_name }
        ### 세로
        if ( $direction -eq "left" -and $img_dir -eq "h" ) { magick convert -append $cache_file_name $img_file $result_img_name }
        elseif ( $direction -eq "right" -and $img_dir -eq "h" ) { magick convert -append $img_file $cache_file_name $result_img_name }
    }
    

    # 임시 이미지 파일 삭제
    Remove-Item $cache_file_name

    if ( $delete_opt -eq "d" )
    {
        Remove-Item $big_size_image
        Remove-Item $img_file
    }

    # 출력
    echo "Create $result_img_name"

}


if ( $file_name1 -ne "" -and $file_name2 -ne "" )
{

# singleinstance, delete single quarter
## get only filename
$dir1 = Split-Path $file_name1 -Qualifier
$dir2 = Split-Path $file_name2 -Qualifier
$file_name1 = Split-Path $file_name1 -leaf
$file_name2 = Split-Path $file_name2 -leaf

#if ( (Test-Path "$file_name1") -eq $false ) 
#{ 
#  $stmp1 = $dir1 + "'" + $file_name1 + "'"
#  echo $stmp1
#  Rename-Item "$stmp1" -NewName $file_name1
#}
#if ( (Test-Path "$file_name2") -eq $false ) 
#{
#  $stmp2 = $dir1 + "'" + $file_name2 + "'"
#  echo $stmp2
#  Rename-Item "$stmp2" -NewName $file_name2
#}


$left_img_x = magick identify -format '%w' $file_name1
$left_img_y = magick identify -format '%h' $file_name1
$right_img_x = magick identify -format '%w' $file_name2
$right_img_y = magick identify -format '%h' $file_name2


    # 이미지 세로 이어붙이기
    if ( $direction -eq 'h' ) 
    {
           # 오른쪽 이미지 가로 사이즈가 더 클 경우
           if ( [int]$left_img_x -lt [int]$right_img_x ) 
           {  
              marge -big_size_image $file_name2 -result_img_x $left_img_x -result_img_y $left_img_y -img_file $file_name1 -white_space $white_space -direction "left" -img_dir "h"
           } else { 
              marge -big_size_image $file_name1 -result_img_x $right_img_x -result_img_y $right_img_y -img_file $file_name2 -white_space $white_space -direction "right" -img_dir "h"
           }

    } else {
       
     # 이미지 가로 이어붙이기
            
           # 오른쪽 이미지의 세로 사이즈가 더 클 경우 // 작은 세로 사이즈로 맞춰줘야함
           if ( [int]$left_img_y -lt [int]$right_img_y ) 
           {
             marge -big_size_image $file_name2 -result_img_x $left_img_x -result_img_y $left_img_y -img_file $file_name1 -white_space $white_space -direction "right" -img_dir "w"
           } else { 
             marge -big_size_image $file_name1 -result_img_x $right_img_x -result_img_y $right_img_y -img_file $file_name2 -white_space $white_space -direction "left" -img_dir "w"
          }
    } 
} else {  
echo ""
echo "파일 이름을 입력하세요." 
echo 'example> append_image.ps1 [img1.png], [img2.png], [direction(w,h)], [white_space(number(default-10))] [orignal img delete(d)] [border(b)]'
echo "example> append_image.ps1 a.png b.png w 5 d b"
echo ""
}
