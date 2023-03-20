// nodejs
const express = require('express');
const request = require('request');
const cheerio = require('cheerio');
const app = express();

// 프록시 요청을 처리하는 라우터
app.get('/proxy', (req, res) => {
  const url = req.query.url;

  request.get(url, (error, response, body) => {
    if (error) {
      return res.status(500).send(error.message);
    }

    // 도메인과 프로토콜 추출
    const { protocol, host } = new URL(url);

    // 클라이언트에게 응답받은 페이지를 전달
    const updatedBody = body.replace(/href="\//g, `href="http://127.0.0.1:3000/proxy?url=${protocol}//${host}/`);
    res.send(updatedBody);
  });
});

app.listen(3000, () => console.log('Server started on port 3000'));
