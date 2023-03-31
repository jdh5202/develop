function displayRunningApps(title) {
    // 서버에 실행 중인 앱 목록을 요청합니다.
    $("#frm").hide();
    socket.emit('request_running_apps');

    var title = title.innerText;
    document.getElementById('result-title').innerText += 'Running app process'
    document.getElementById('result-subtitle').innerText += title + '을 적용할 앱을 선택하세요.';
}

var socket = io.connect('http://' + document.domain + ':' + location.port);

socket.on('connect', function() {
    console.log("Connected to the server");
    
});

// 서버에서 running_apps_data 이벤트가 발생하면 테이블에 데이터를 추가합니다.
socket.on("running_apps_data", function (data) {
    var table = "<table class='table table-striped'><thead><tr><th>PID</th><th>Appname</th><th>PackageName</th></tr></thead><tbody>";
    for (var i = 0; i < data.length; i++) {
      table += "<tr><td>" + data[i].pid + "</td><td>" + data[i].name + "</td><td>" + data[i].identifier + "</td></tr>";
    }
    table += "</tbody></table>";
    $("#table-container").show();
    $("#table-container").html(table); // table-container에 테이블 삽입

    $("#table-container tbody tr").click(function() {
        var pid = $(this).find("td:nth-child(1)").text();
        var appname = $(this).find("td:nth-child(2)").text();
        var identifier = $(this).find("td:nth-child(3)").text();
        var modal = "<div id='myModal' class='modal'><div class='modal-content'><span class='modal-close'>&times;</span><p>PID: " + pid + "</p><p>Appname: " + appname + "</p><p>PackageName: " + identifier + "</p><button class='execute-btn'>실행</button></div></div>";
        $("#table-container").append(modal);
        $(".modal").css("display", "block");
        $(".modal-close").click(function() {
          $(".modal").css("display", "none");
        });

        $(".execute-btn").click(function() {
            console.log("Execute button clicked");
            socket.emit('request_logcat', pid);
            console.log("request_logcat event emitted");

               // 로그를 받기 시작하면 search-container div를 생성합니다.
            if (!$('#search-container').length) {
              $(".modal").css("display", "none");
              $("#table-container").hide();
              $("#result-subtitle").hide();
              $("#result-title").hide();
              $('body').css('overflow', 'hidden'); // 웹 스크롤 잠금, 검색 창 스크롤 활성
              createSearchContainer();
            }

            var lineNumber = 0;
            // logcat 출력 결과를 받아서 화면에 출력합니다.
            socket.on('logcat_output', function(output_line) {
              lineNumber++;
              const lineId = 'line-' + lineNumber;
              $('#search-container').append('<p id="' + lineId + '" class="highlight">' + output_line + '</p>');

              const lineElement = $('#' + lineId);
              scrollToBottom();
          
              // 강조 효과가 사라지도록 설정
              setTimeout(function() {
                  lineElement.removeClass('highlight');
              }, 300); // 0.3초 후에 강조 효과를 제거


            });
        });
      });
});


// 검색 창 및 search-container div를 생성하는 함수입니다.
function createSearchContainer() {
// 먼저, 푸터의 위치를 가져옵니다.
  const footer = $('.container-fluid.px-4');
  // 먼저 searchContainer를 생성합니다.
  const searchContainer = $('<div id="search-container" style="position: relative; overflow-y: scroll; overflow-x: hidden; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 5px; padding: 10px; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);"></div>');
  // 생성된 searchContainer를 원하는 위치에 추가합니다.
  // 예를 들어, result div에 추가하려면 아래 코드를 사용하세요.
  $('#result').append(searchContainer);
  // search-container의 위치를 가져옵니다.
  const searchContainerPosition = $('#search-container').offset().top;
  // 그 다음, 푸터의 상단 위치 (offset)를 가져옵니다.
  const footerTopPosition = footer.offset().top;
  // 푸터와 search-container 사이의 높이를 계산합니다.
  const maxHeight = footerTopPosition - searchContainerPosition;
  // searchContainer의 max-height를 계산한 높이로 설정합니다.
  searchContainer.css('max-height', maxHeight + 'px');
  const searchInput = $('<input type="text" id="search" placeholder="검색...">');
    searchContainer.append(searchInput);
  

  // 검색 기능 구현
  $('#search').on('input', function() {
      const searchTerm = $(this).val().toLowerCase();

      $('#result p').each(function() {
          const text = $(this).text().toLowerCase();
          if (text.includes(searchTerm)) {
              $(this).show();
          } else {
              $(this).hide();
          }
      });
  });
}

function scrollToBottom() {
  const container = $('#search-container');
  container.scrollTop(container.prop("scrollHeight"));
}


// socket.on('logcat_data', function(data) {
//     var result_div = document.getElementById('result');
//     var p = document.createElement('p');
//     p.appendChild(document.createTextNode(data));
//     result_div.appendChild(p);
// });
