import requests
import json
import sys

import os 
arglist=[]
for arg in sys.argv:
    arglist.append(arg)

access_token = arglist[1]
blog_name = arglist[2]
content = open(arglist[3], 'rt', encoding='euc-kr').read()
url_post = "https://www.tistory.com/apis/post/write"
visibility = 3
category = 0
title= arglist[4]
tag = ''
acceptComment = 1 # 댓글 허용


headers = {'Content-Type': 'application/json; charset=utf-8'}
params = {
    'access_token': access_token,
    'output': 'json',
    'blogName': blog_name,
    'title': title,
    'content': content,
    'visibility': visibility,
    'category': category,
    'published':'',
    'slogan':'',
    'tag': tag,
    'acceptComment': acceptComment,
    'password':''
}
data = json.dumps(params)

rw = requests.post(url_post, headers=headers, data=data)
if rw.status_code == 200:
    print(title + ' 포스팅 완료')
else:
    print(title + ' 포스팅 실패 - error code:' + str(rw.status_code))
    print(rw.text + "\n")
    print(rw.content)
