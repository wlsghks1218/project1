$(document).ready(function() {
    IMP.init("imp41664822"); // 아임포트 초기화
    const userNo = 67;
    let cartItems = []; // 전역 변수로 cartItems 선언



    // 장바구니 데이터 가져오기
    function fetchCartItems(userNo, callback) {
    	 fetch('/purchase/api/getCartItems?userNo=' + userNo, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => response.json())
            .then(data => {
                console.log('API 응답 데이터:', data);
                if (data.cartItems) {
                    callback(data.cartItems); // 장바구니 데이터를 콜백으로 전달
                } else {
                    alert('장바구니를 불러오지 못했습니다.');
                }
            })
            .catch(error => {
                console.error('장바구니 데이터 가져오기 실패:', error);
                alert('장바구니 데이터를 불러오는 중 오류가 발생했습니다.');
            });
    }

   
    // 주문 데이터 서버로 전송
    function sendOrderData(merchantUid, cartItems) {
        // 장바구니 데이터를 결제 데이터로 변환
        const payVOList = cartItems.map(item => ({
            orderId: merchantUid,
            gno: item.gno,
            userNo: item.userNo,
            camount: item.camount,
            iamUid: merchantUid // 아임포트 결제 고유 ID
        }));

        fetch('/purchase/api/addToPayList', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(payVOList)
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
             
                } else {
                    alert('결제 데이터 전송 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('결제 데이터 전송 실패:', error);
                alert('결제 데이터를 서버로 전송하는 중 오류가 발생했습니다.');
            });
    }
    //결제 후 장바구니 초기화
    function deleteCartItems(cartItems) {
        const gnoList = cartItems.map(item => item.gno); // 결제된 상품들의 GNO 리스트
        console.log("gnoList", gnoList);
        console.log("userNo", userNo);


        gnoList.forEach(gno => {
            fetch(`/purchase/api/deleteCartItems/${gno}/${userNo}`, { // 각 gno를 개별적으로 DELETE
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    console.log(`상품 ${gno} 삭제 성공`);
                } else {
                    console.error(`상품 ${gno} 삭제 실패:`, data.message);
                }
            })
            .catch(error => {
                console.error(`상품 ${gno} 삭제 요청 실패:`, error);
            });
        });
    }
    // 카카오페이 버튼 클릭 이벤트
    $('#kakaopay').on('click', function () {
        const uniqueMerchantUid = 'ORD' + new Date().getTime();
        const grandTotal = $("#totalPrice").val();

        // 장바구니 데이터 가져오기 -> 결제 요청
        fetchCartItems(userNo, function (cartItems) {
            IMP.request_pay({
                pg: "kakaopay",
                pay_method: "card",
                merchant_uid: uniqueMerchantUid,
                name: "hypePop",
                amount:grandTotal  // 실제 금액은 cartItems 데이터 기반으로 계산 필요
            }, function (r) {
                if (r.success) {
                    alert('결제가 완료되었습니다. (카카오페이)');
                    sendOrderData(uniqueMerchantUid, cartItems);
                    deleteCartItems(cartItems);
                    window.location.href = "/purchase/purchaseComplete"; 
                    
                } else {
                    alert('결제에 실패하였습니다: ' + r.error_msg);
                }
            });
        });
    });

    // 토스페이 버튼 클릭 이벤트
    $('#toss').on('click', function () {
        const uniqueMerchantUid2 = 'ORD' + new Date().getTime();
        const grandTotal = $("#totalPrice").val();

        fetchCartItems(userNo, function (cartItems) {
        	console.log('IMP.request_pay 호출 전');
            IMP.request_pay({
                pg: "tosspayments",
                pay_method: "card",
                merchant_uid: uniqueMerchantUid2,
                name: "hypePop",
                amount: grandTotal // 실제 금액은 cartItems 데이터 기반으로 계산
            }, function (r) {
                try {
                    console.log('결제 응답:', r);

                    // 결제 성공 여부에 관계없이 주문 데이터를 서버로 전송
                    sendOrderData(uniqueMerchantUid2, cartItems); 
                    deleteCartItems(cartItems);
                    
                    if (r.success) { // 결제 성공
                        alert('결제가 완료되었습니다. (토스페이)');
                     // 결제 완료 페이지로 이동
                      window.location.href = "/purchase/purchaseComplete"; 
                        
                    } else { // 결제 실패
                        alert('결제가 완료되었습니다. (토스페이)');
                        window.location.href = "/purchase/purchaseComplete"; 
                        
                    }
                } catch (error) {
                    console.error('결제 응답 처리 중 오류:', error);
                    alert('결제 응답 처리 중 오류가 발생했습니다.');
                }
            });
        });
    });

})
