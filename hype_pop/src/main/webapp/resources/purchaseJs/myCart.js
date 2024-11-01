document.getElementById('addToCart').addEventListener('click', function() {
         const urlParams = new URLSearchParams(location.search);
         const gno = urlParams.get('gno'); //url 에 있는 gno 
         console.log('Gno:',gno);//gno 콘솔
         const userNo = 2; //사용자 번호 지정
         
         // 상품명, 가격, 이미지 파일 추출
         const gname = document.getElementById('goodsName').textContent.split(': ')[1];
         console.log("Extracted gname:", gname);
         const camount = parseInt(document.getElementById('quantity').value, 10); 
          const gprice = parseFloat(document.getElementById('goodsPrice').textContent.split(': ')[1]); // 가격
//          const cprice = parseFloat(document.getElementById('totalPrice').textContent.split(': ')[1]); // 가격
//          const cprice= document.getElementById('totalPrice').textContent; // "총 가격: 10,000" 가져오기
          const cprice = parseInt(document.getElementById('totalPrice').textContent.replace(/,/g, ''), 10);
          console.log(cprice);
          //console.log(cprice); // "10,000" 출력
          
          
//          const cartItem = {
//                  gno: gno,
//                  userNo: userNo,
//                  gname: gname,
//                  camount: camount,
//                  gprice: gprice,
//                  cprice: cprice
//              };
          
          const data = { gno, userNo, camount, cprice, gprice, gname };
          console.log("Sending data:", data);
          
          //장바구니에 담기 요청을 보냄
          fetch('/purchase/addCart',{
               method:'POST',
               headers:{ 'Content-Type': 'application/json' },
               body : JSON.stringify(data)
   
            })
            .then(response => {
                console.log('Response:', response); // 서버 응답 확인
                return response.text();
        
            })
            .then(text=> {
                
                console.log('Response Text:', text); // 변환된 데이터 확인
                   alert(text); // 서버에서 받은 메시지를 알림으로 표시
            })
            });


           
      

