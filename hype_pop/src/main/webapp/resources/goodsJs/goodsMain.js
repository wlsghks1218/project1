localStorage.setItem('searchText', ""); // 검색어 저장

document.addEventListener("DOMContentLoaded", function() {
    function setBackgroundImage(item) {
        const fileName = item.querySelector("#fileName").value;

        fetch(`/goodsStore/goodsBannerImages/${encodeURIComponent(fileName)}`)
            .then(response => response.blob())
            .then(blob => {
                const imageUrl = URL.createObjectURL(blob);
                item.style.backgroundImage = `url(${imageUrl})`;
                item.style.backgroundSize = "cover";
                item.style.backgroundPosition = "center center";
                item.style.backgroundRepeat = "no-repeat";
            })
            .catch(error => {
                console.error("이미지를 불러오는 중 오류 발생: ", error);
            });
    }

    for (let i = 1; i <= 7; i++) {
        const goodsItems = document.querySelectorAll(`.goodsItem${i}`);
        goodsItems.forEach((item) => {
            setBackgroundImage(item);
        });
    }
});


function setupSlider(containerClass, itemClass, prevBtnId, nextBtnId, itemsToShow, totalItems) {
    let currentIndex = 0;

    const nextBtn = document.getElementById(nextBtnId);
    const prevBtn = document.getElementById(prevBtnId);

    if (nextBtn) {
        nextBtn.addEventListener('click', () => {
            currentIndex = (currentIndex + itemsToShow) % totalItems;
            updateDisplay(containerClass, itemClass, currentIndex, itemsToShow);
        });
    }

    if (prevBtn) {
        prevBtn.addEventListener('click', () => {
            currentIndex = (currentIndex - itemsToShow + totalItems) % totalItems;
            updateDisplay(containerClass, itemClass, currentIndex, itemsToShow);
        });
    }

    updateDisplay(containerClass, itemClass, currentIndex, itemsToShow);
}

function updateDisplay(containerClass, itemClass, currentIndex, itemsToShow) {
    const items = document.querySelectorAll(`.${itemClass}`);
    items.forEach((item, index) => {
        item.style.display = (index >= currentIndex && index < currentIndex + itemsToShow) ? 'block' : 'none';
    });
}

setupSlider('goodsContainer1', 'goodsItem1', 'prevBtn1', 'nextBtn1', 4, 8);
setupSlider('goodsContainer2', 'goodsItem2', 'prevBtn2', 'nextBtn2', 4, 8);
setupSlider('goodsContainer3', 'goodsItem3', 'prevBtn3', 'nextBtn3', 4, 8);
setupSlider('goodsContainer4', 'goodsItem4', 'prevBtn4', 'nextBtn4', 4, 8);
setupSlider('goodsContainer5', 'goodsItem5', 'prevBtn5', 'nextBtn5', 4, 8);
setupSlider('goodsContainer6', 'goodsItem6', 'prevBtn6', 'nextBtn6', 4, 8);
setupSlider('goodsContainer7', 'goodsItem7', 'prevBtn7', 'nextBtn7', 4, 8);

const goodsNames = document.querySelectorAll('.goodsName');
const maxLength = 40;
goodsNames.forEach((element) => {
    let displayName = element.textContent;
    if (displayName.length > maxLength) {
        displayName = displayName.substring(0, maxLength) + "...";
    }
    element.textContent = displayName;
});

function setupGoodsItemClick(itemClass) {
    document.querySelectorAll(`.${itemClass}`).forEach(item => {
        item.addEventListener('click', () => {
            const gno = item.querySelector('input[type="hidden"]').value;
            location.href = `/goodsStore/goodsDetails?gno=${gno}`;
        });
    });
}

setupGoodsItemClick('goodsItem1');
setupGoodsItemClick('goodsItem2');
setupGoodsItemClick('goodsItem3');
setupGoodsItemClick('goodsItem4');
setupGoodsItemClick('goodsItem5');
setupGoodsItemClick('goodsItem6');
setupGoodsItemClick('goodsItem7');

function checkExtension(fileName, fileSize){
	if(fileSize >= MAX_SIZE){
		alert("파일 사이즈 초과");
		return false;
	}
	if(regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.")
		return false;
	}
	return true;
}