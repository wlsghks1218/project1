document.querySelectorAll('.popUpItem').forEach(item => {
  item.addEventListener('click', (event) => {
    event.preventDefault();

    // 이미지 클릭 시, 해당 div의 내부 텍스트(스토어 이름) 가져오기
    const storeName = item.querySelector('.popUpText').textContent; // popUpText 클래스에서 텍스트 추출

    console.log(storeName);

    // 스토어 이름을 URL로 넘겨줌
    location.href = `/hypePop/popUpDetails?storeName=${encodeURIComponent(storeName)}`;
  });
});

document.addEventListener("DOMContentLoaded", () => {
	  // 이미지 설정 함수
	  function setBackgroundImage(item) {
	    const fileName = item.querySelector(".fileData").value; // uuid_filename 값 가져오기
	    const imgElement = item.querySelector(".popUpImage");

	    // 파일 경로 설정 (필요에 따라 경로 조정)
	    const imageUrl = `/hypePop/images/${encodeURIComponent(fileName)}`;

	    // fetch를 사용하여 이미지 로드 및 img 태그의 src 설정
	    fetch(imageUrl)
	      .then(response => response.blob())
	      .then(blob => {
	        const url = URL.createObjectURL(blob);
	        imgElement.src = url;
	      })
	      .catch(error => console.error("이미지를 불러오는 중 오류 발생:", error));
	  }
	  
	  // 스크롤 버튼 관련 기능 입니다!
	    const scrollUpButton = document.getElementById("scrollUp");
	    const scrollDownButton = document.getElementById("scrollDown");

	    // 최상단으로 스크롤
	    function scrollToTop() {
	        window.scrollTo({ top: 0, behavior: 'smooth' });
	    }

	    // 최하단으로 스크롤
	    function scrollToBottom() {
	        window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
	    }

	    // 스크롤 상태에 따라 버튼 보이기/숨기기 설정
	    function checkScrollPosition() {
	        if (window.scrollY === 0) {
	            scrollUpButton.style.display = 'none'; // 위 버튼 숨기기
	            scrollDownButton.style.display = 'block'; // 아래 버튼 보이기
	        } else if (window.innerHeight + window.scrollY >= document.body.offsetHeight) {
	            scrollUpButton.style.display = 'block'; // 위 버튼 보이기
	            scrollDownButton.style.display = 'none'; // 아래 버튼 숨기기
	        } else {
	            scrollUpButton.style.display = 'block'; // 위 버튼 보이기
	            scrollDownButton.style.display = 'block'; // 아래 버튼 보이기
	        }
	    }

	    // 버튼에 클릭 이벤트 리스너 추가
	    scrollUpButton.addEventListener("click", scrollToTop);
	    scrollDownButton.addEventListener("click", scrollToBottom);

	    // 버튼 호버 시 불투명도 변경
	    scrollUpButton.addEventListener("mouseenter", function() {
	        scrollUpButton.style.opacity = 1; // 호버 시 불투명도 1로 설정
	    });
	    scrollUpButton.addEventListener("mouseleave", function() {
	        if (window.scrollY !== 0) {
	            scrollUpButton.style.opacity = 0.5; // 호버를 떼면 불투명도 0.5로 설정
	        }
	    });

	    scrollDownButton.addEventListener("mouseenter", function() {
	        scrollDownButton.style.opacity = 1; // 호버 시 불투명도 1로 설정
	    });
	    scrollDownButton.addEventListener("mouseleave", function() {
	        if (window.innerHeight + window.scrollY < document.body.offsetHeight) {
	            scrollDownButton.style.opacity = 0.5; // 호버를 떼면 불투명도 0.5로 설정
	        }
	    });

	    // 페이지 로드 및 스크롤 시 버튼 상태 업데이트
	    window.addEventListener("scroll", checkScrollPosition);
	    checkScrollPosition(); // 초기 로딩 시 상태 설정

	  // 모든 슬라이더에 대해 이미지 설정
	  document.querySelectorAll('.slider').forEach(slider => {
	    const sliderItems = slider.querySelectorAll('.popUpItem'); // 슬라이더 내 항목들
	    sliderItems.forEach(item => setBackgroundImage(item)); // 각 항목에 대해 이미지 설정
	  });

	  // 슬라이더 설정 함수
	  document.querySelectorAll('.slider-container').forEach(container => {
	    const slider = container.querySelector('.slider');
	    const leftArrow = container.querySelector('.leftArrow');
	    const rightArrow = container.querySelector('.rightArrow');

	    if (slider && leftArrow && rightArrow) {
	      let currentIndex = 0;
	      const totalItems = slider.children.length;
	      const itemsToShow = 4; // 보여줄 항목 수
	      const itemWidth = 25; // 각 항목 너비
	      const margin = -0.1; // 항목 간의 마진

	      function updateSlider() {
	        const offset = currentIndex * (itemWidth + margin); // 마진 포함한 오프셋 계산
	        slider.style.transform = `translateX(-${offset}%)`; // 슬라이더 위치 변경
	      }

	      leftArrow.addEventListener('click', () => {
	        currentIndex = (currentIndex === 0) ? totalItems - itemsToShow : currentIndex - 1;
	        updateSlider();
	      });

	      rightArrow.addEventListener('click', () => {
	        currentIndex = (currentIndex === totalItems - itemsToShow) ? 0 : currentIndex + 1;
	        updateSlider();
	      });
	    } else {
	      console.error("슬라이더 또는 버튼이 누락되었습니다.");
	    }
	    
	    
	  });
	  
	  
	});
