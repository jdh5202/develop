#!/bin/bash
 
echo ""
echo "1. 초기화"
echo "2. git 파일 동기화"
echo "3. git 파일 권한 부여"
 
echo "입력:"
read vars
 
if [ $vars -eq 1 ]; then

echo ""
echo "1. longrun"
echo "2. Docker"
echo "입력:"
read reposit

repo_name='Docker'
if [ $reposit -eq 1 ]; then
repo_name='longrun'
fi

git config --global user.name jdh5202
git config --global user.email jdh5202@naver.com
mkdir github_folder && cd github_folder
git clone "https://github.com/jdh5202/$repo_name"
git init
git remote add origin "https://github.com/jdh5202/$repo_name"
echo "github_folder 생성 및 원격 서버 동기화 완료"
 
 
elif [ $vars -eq 2 ]; then
	
git add .
git commit -m "init"
git push -u origin master # jdh5202@naver.com, gi..
echo "파일을 동기화하였습니다."
 
elif [ $vars -eq 3 ]; then
 
git update-index --chmod=+x *.sh
echo "권한을 부여하였습니다."
 
else 
	echo "잘못된 입력"	
fi