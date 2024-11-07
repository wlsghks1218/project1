document.querySelectorAll('.popUpItem').forEach(a => {
  a.addEventListener('click', (event) => {
    event.preventDefault();
    
    let storeName = a.textContent;
    
    console.log(storeName);
    
    location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(storeName)}`;
  });
});


document.addEventListener("DOMContentLoaded", () => {

  // 슬라이더 관련 설정
  const sliderContainers = [
    { slider: document.getElementById('hotPopUpStore'), leftArrow: document.getElementById('leftArrow'), rightArrow: document.getElementById('rightArrow') },
    { slider: document.getElementById('hotCatSlider1'), leftArrow: document.getElementById('leftArrow1'), rightArrow: document.getElementById('rightArrow1') },
    { slider: document.getElementById('hotCatSlider2'), leftArrow: document.getElementById('leftArrow2'), rightArrow: document.getElementById('rightArrow2') },
    { slider: document.getElementById('hotCatSlider3'), leftArrow: document.getElementById('leftArrow3'), rightArrow: document.getElementById('rightArrow3') }
  ];

  sliderContainers.forEach(({ slider, leftArrow, rightArrow }) => {
    if (slider && leftArrow && rightArrow) { // 슬라이더와 버튼이 존재하는지 확인
      let currentIndex = 0;
      const totalItems = slider.children.length;
      const itemsToShow = 4; // 보여줄 항목 수
      const itemWidth = 25; // 각 항목 너비(100%를 itemsToShow로 나눔)
      const margin = 0.5; // 항목 간의 마진
      
      function updateSlider() {
        const offset = currentIndex * (itemWidth + margin); // 마진을 포함한 오프셋 계산
        slider.style.transform = `translateX(-${offset}%)`; // 슬라이더 위치 변경
      }

      leftArrow.addEventListener('click', () => {
        currentIndex = (currentIndex === 0) ? totalItems - itemsToShow : currentIndex - 1; // 첫 번째 요소에서 왼쪽 버튼 클릭 시 마지막 요소로 이동
        updateSlider();
      });

      rightArrow.addEventListener('click', () => {
        currentIndex = (currentIndex === totalItems - itemsToShow) ? 0 : currentIndex + 1; // 마지막 요소에서 오른쪽 버튼 클릭 시 처음으로 이동
        updateSlider();
      });
    } else {
      console.error(`Slider or buttons not found for: ${slider}`);
    }
  });
});
