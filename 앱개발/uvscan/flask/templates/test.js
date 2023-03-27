// 결과 숨기기 버튼 생성
const titles = document.querySelectorAll('.title');
titles.forEach(title => {
  const button = document.createElement('button');
  button.type = 'button';
  button.className = 'hideresult';
  button.style.backgroundColor = 'transparent';
  button.style.border = 'none';
  button.style.cursor = 'pointer';
  button.innerHTML = `
    <svg width="1.2em" height="1.2em" viewBox="0 0 16 16" class="bi bi-chevron-up" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
      <path fill-rule="evenodd" d="M1.646 4.646a.5.5 0 01.708 0L8 10.293l5.646-5.647a.5.5 0 01.708.708l-6 6a.5.5 0 01-.708 0l-6-6a.5.5 0 010-.708z" />
    </svg>
  `;
  title.insertAdjacentElement('afterend', button);
});


// 숨기기 버튼 액션
const hideresults = document.querySelectorAll('.hideresult');
hideresults.forEach(function(hideresult) {
  const searchresult = hideresult.closest('.card-body').querySelector('.result-container');
  const chevronIcon = hideresult.querySelector('.bi-chevron-up');

  hideresult.addEventListener('click', function() {
    searchresult.style.display = searchresult.style.display === 'none' ? '' : 'none';
    if (chevronIcon.style.transform === 'rotate(180deg)') {
      chevronIcon.style.transform = 'rotate(0deg)';
    } else {
      chevronIcon.style.transform = 'rotate(180deg)';
    }
  });
});