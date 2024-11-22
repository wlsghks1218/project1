	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

// 각 cart-item에 대해 setImageSrc 함수를 실행합니다.
const cartItems = document.querySelectorAll(".cart-item"); // .cart-item 클래스의 요소를 선택
cartItems.forEach((cartItem) => {
	setImageSrc(cartItem); // 각각의 cart-item에 대해 이미지를 설정
});


    // 이미지를 로드하여 src를 설정하는 함수
    function setImageSrc(cartItem) {
        const fileNames = cartItem.querySelectorAll("#fileName"); // 해당 cart-item 내의 모든 fileName 요소를 가져옴
        
        fileNames.forEach((fileNameElement) => {
            const fileName = fileNameElement.value; // fileName을 가져옴
            const imgElement = fileNameElement.closest('.cart-item').querySelector("img"); // 해당 cart-item 내의 img 요소 선택
            
            // 이미지 URL을 fetch로 로드하여 img src에 설정
            fetch(`/goodsStore/goodsBannerImages/${encodeURIComponent(fileName)}`)
                .then(response => response.blob())
                .then(blob => {
                    const imageUrl = URL.createObjectURL(blob); // 이미지 URL 생성
                    imgElement.src = imageUrl; // img 요소의 src를 설정
                })
                .catch(error => {
                    console.error("이미지를 불러오는 중 오류 발생: ", error);
                });
        });
    }





document.getElementById('addToCart').addEventListener('click', function() {
	if(userNo){
	    const urlParams = new URLSearchParams(location.search);
	    const gno = urlParams.get('gno'); // URL에서 gno 추출
	    console.log('Gno:', gno); // gno 콘솔 출력
	    console.log('userNo:', userNo); 
	    
	    // 상품명, 가격, 이미지 파일 추출
	    const gname = document.getElementById('goodsName').textContent.split(': ')[1];
	    console.log("Extracted gname:", gname);
	    const camount = parseInt(document.getElementById('quantity').value, 10); 
	    const gprice = parseFloat(document.getElementById('goodsPrice').textContent.split(': ')[1]); // 가격
	    const cprice = parseInt(document.getElementById('totalPrice').textContent.replace(/,/g, ''), 10); // 총 가격 추출
	    console.log(cprice);
	    
	
	    
	    const data = { gno, userNo, camount, cprice, gprice, gname };
	    console.log("Sending data:", data);
	    
	    // 장바구니에 담기 요청을 보냄
	    fetch('/purchase/api/addCart', {
	        method: 'POST',
	        headers: { 'Content-Type': 'application/json' },
	        body: JSON.stringify(data)
	    })
	    .then(response => {
	        console.log('Response:', response); // 서버 응답 확인
	        return response.text();
	    })
	    .then(text => {
	        console.log('Response Text:', text); // 변환된 데이터 확인
	        alert(text); // 서버에서 받은 메시지를 알림으로 표시
	    });
	}else{
        document.getElementById("loginModal").style.display = "block";
	}
});

function changeAmount(gno, change) {
   
    const quantityInput = document.getElementById(`quantity-${gno}`);
    let currentQuantity = parseInt(quantityInput.value);
    
    // 수량 변경
    currentQuantity += change;

    // 최소 수량 제한
    if (currentQuantity < 1) {
        currentQuantity = 1;
    }

    quantityInput.value = currentQuantity;

    // 가격 계산 및 총 가격 업데이트
    const price = parseInt(quantityInput.closest('.cart-info').querySelector('.price').textContent.replace(/[^0-9]/g, ''));
    const totalPriceElement = quantityInput.closest('.cart-info').querySelector('.total-price');
    const totalPrice = currentQuantity * price;

    totalPriceElement.textContent = totalPrice; // 각 상품의 총 가격 업데이트

    // 전체 장바구니 총 가격 계산
    updateGrandTotal();
    
    // 수량을 서버에 업데이트
    updateAmount(gno, currentQuantity);
}

function updateGrandTotal() {
    const totalPriceElements = document.querySelectorAll('.total-price');
    let grandTotal = 0;
    
   
    
    totalPriceElements.forEach(totalPrice => {
          const value = parseInt(totalPrice.textContent.replace(/[^0-9]/g, ''));
           if (!isNaN(value)) {
               grandTotal += value;
           }    
           });  
    
    document.getElementById('grand-total').textContent = grandTotal.toLocaleString();  // 전체 장바구니 총 가격 업데이트
}

function updateAmount(gno, currentAmount) {
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

    fetch("/purchase/updateAmount", {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ gno, userNo, currentAmount }) // 필요한 데이터 전달
    })
    .then(response => response.text())
    .then(data => {
        if(data === 'ok') {
            console.log("수량 업데이트 성공");
        } else {
            console.log("수량 업데이트 실패");
        }
    })
    .catch(err => console.log(err));
}

//전체 선택/해제 함수
function toggleAll(source) {
    const checkboxes = document.querySelectorAll('.cart-checkbox');
    checkboxes.forEach(checkbox => checkbox.checked = source.checked);
    calculateTotal(); // 총 가격 재계산
}

// 총 가격 계산 함수
function calculateTotal() {
    let grandTotal = 0;
    document.querySelectorAll('.cart-checkbox:checked').forEach(checkbox => {
        const cartItem = checkbox.closest('.cart-item');
        const price = parseFloat(cartItem.querySelector('.price').innerText.replace(/,/g, '')) || 0;
        const quantity = parseInt(cartItem.querySelector('input[type="number"]').value) || 0;
        const itemTotal = price * quantity;
        
        cartItem.querySelector('.total-price').textContent = itemTotal.toLocaleString(); // 각 상품 총 가격 표시
        grandTotal += itemTotal;
    });
    document.getElementById('grandTotal').innerText = grandTotal.toLocaleString(); // 총 가격 표시
    document.getElementById('grandTotalInput').innerText = grandTotal;

}

// 수량 변경에 따른 가격 변경 함수
function changeAmount(gno, change) {
    const quantityInput = document.getElementById(`quantity-${gno}`);
    const newQuantity = parseInt(quantityInput.value) + change;
    if (newQuantity >= 1) {
        quantityInput.value = newQuantity;
        calculateTotal(); // 수량 변경 시 총 가격 재계산
    }
}


function deleteItem(gno) {
    const isConfirmed = confirm("삭제하시겠습니까?");
    if (!isConfirmed) return;

	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

    fetch(`/purchase/api/deleteItem/${gno}?userNo=${userNo}`, {
        method: 'DELETE',
    })
    .then(response => {
        if (response.ok) {
            alert('상품이 삭제되었습니다.');
            // 삭제된 상품을 UI에서 제거
            const cartItem = document.getElementById(`cart-${gno}`);
            if (cartItem) {
                cartItem.remove();
                
            }
            calculateTotal(); 
        } else {
           return response.text().then(text => {
                console.error("Error response:", text);
                alert("상품 삭제하지 못했습니다. 다시 시도해주세요.");
            });
        }
    })
    .catch(error => { 
        console.log('삭제 중 오류 발생:', error); // 
        alert('서버 오류. 나중에 다시 시도해주세요.');
    });

}



//function goPayInfo(){
//   const grandTotal = document.getElementById("grandTotal").innerText;
//   const userNo = document.getElementById('userNo').value; 
//   location.href="/purchase/getPayInfo?totalPrice=" + grandTotal+"&userNo=" + userNo;
//}

function prepareCartData() {
    const cartItems = document.querySelectorAll('.cart-item');
    const cartData = [];
    const grandTotal = document.getElementById('grandTotal').innerText;
    
	const userNoElement = document.getElementById("userNo");
	const userNo = userNoElement ? userNoElement.value : null;

    cartItems.forEach((item) => {
        const gno = item.id.split('-')[1];
        const gname = item.querySelector('h4').innerText.replace('굿즈 이름 : ', '').trim();
        const gprice = item.querySelector('.price').innerText.trim();
        const camount = item.querySelector(`#quantity-${gno}`).value;

        // 장바구니 데이터 객체 생성
        cartData.push({
            gno: gno,
            gname: gname,
            gprice: parseInt(gprice.replace(',', '')),
            camount: parseInt(camount),
            
        });
    });

    // 데이터를 hidden 필드에 설정
    document.getElementById('hiddenGrandTotal').value = grandTotal.replace(',', '').trim();
    document.getElementById('hiddenCartData').value = JSON.stringify(cartData);

    // 폼 제출
    document.getElementById('cartForm').submit();


}

//바로 결제 버튼 누르기
document.getElementById("directPurchase").addEventListener("click", function () {
	if(userNo){
    // 화면에 표시된 totalPrice 가져오기
    const displayedPrice = document.getElementById("totalPrice").textContent.trim();

    // 숫자만 추출 (예: '12345원' → '12345')
    const numericPrice = displayedPrice.replace(/[^\d]/g, '');

    // 페이지 이동 (GET 요청, totalPrice를 URL의 쿼리 파라미터로 전달)
    window.location.href = `/purchase/payInfoPage?grandTotal=${numericPrice}&userNo=${userNo}`;
	}else{
        document.getElementById("loginModal").style.display = "block";	
	}
});


