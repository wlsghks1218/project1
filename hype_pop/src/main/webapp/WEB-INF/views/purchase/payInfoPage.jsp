<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .modal {
            display: none;
        }
        .required {
            color: red;
        }
    </style>
</head>
<body>

    <!-- 헤더 -->
    <header class="bg-light py-3">
        <div class="container">
            <h1 class="text-center">결제 정보 입력</h1>
            <a href="home.html" class="btn btn-primary">홈으로 가기</a>
        </div>
    </header>

    <div class="container my-4">
        <!-- 구매자 정보 테이블 -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>구매자 정보</th>
                    <th>상세 입력</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>이름</td>
                    <td><input type="text" class="form-control" id="buyerName" placeholder="이름 입력"></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input type="email" class="form-control" id="buyerEmail" placeholder="이메일 입력"></td>
                </tr>
                <tr>
                    <td>전화번호</td>
                    <td><input type="tel" class="form-control" id="buyerPhone" placeholder="전화번호 입력"></td>
                </tr>
                <tr>
                    <td>배송지 주소</td>
                    <td>
                        <div class="input-group">
                            <input type="text" class="form-control" id="deliveryAddress" placeholder="주소 입력">
                            <div class="input-group-append">
                                <button class="btn btn-outline-secondary" id="searchBtn">검색</button>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>배송지 상세 주소</td>
                    <td><input type="text" class="form-control" id="detailedAddress" placeholder="상세 주소 입력"></td>
                </tr>
                <tr>
                    <td>배송 요청 사항</td>
                    <td>
                        <select class="form-control" id="deliveryRequest">
                            <option value="">선택하세요</option>
                            <option value="부재 시 경비실에 맡겨주세요">부재 시 경비실에 맡겨주세요</option>
                            <option value="직접 전달해 주세요">직접 전달해 주세요</option>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- 결제 정보 테이블 -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>결제 정보</th>
                    <th>상세 입력</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>가격</td>
                    <td><input type="text" class="form-control" id="price" placeholder="가격" readonly></td>
                </tr>
                <tr>
                    <td>배송비</td>
                    <td><input type="text" class="form-control" value="무료" readonly></td>
                </tr>
                <tr>
                    <td>총 결제 금액</td>
                    <td><input type="text" class="form-control" id="totalPrice" placeholder="총 결제 금액" readonly></td>
                </tr>
                <tr>
                    <td>결제 수단</td>
                    <td>
                        <div>
                            <input type="checkbox" id="bankTransfer">
                            <label for="bankTransfer">계좌이체</label>
                            <select id="bankSelect" class="form-control" style="display: none;">
                                <option value="">선택</option>
                                <option value="우리은행">우리은행</option>
                                <option value="신한은행">신한은행</option>
                                <option value="국민은행">국민은행</option>
                            </select>
                            <span class="required">! 은행을 선택해주세요</span>
                        </div>
                        <div>
                            <input type="checkbox" id="creditCard">
                            <label for="creditCard">신용/체크카드</label>
                        </div>
                        <div>
                            <input type="checkbox" id="mobilePayment">
                            <label for="mobilePayment">휴대폰</label>
                        </div>
                        <div>
                            <input type="checkbox" id="virtualAccount">
                            <label for="virtualAccount">무통장입금(가상계좌)</label>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- 결제하기 버튼 -->
        <button class="btn btn-success" id="paymentButton">결제하기</button>
    </div>

    <script>
        // 결제 수단 체크박스 이벤트
        document.getElementById('bankTransfer').addEventListener('change', function() {
            const bankSelect = document.getElementById('bankSelect');
            if (this.checked) {
                bankSelect.style.display = 'block';
            } else {
                bankSelect.style.display = 'none';
            }
        });

        // 결제하기 버튼 클릭 이벤트
        document.getElementById('paymentButton').addEventListener('click', function() {
            const buyerName = document.getElementById('buyerName').value;
            const buyerEmail = document.getElementById('buyerEmail').value;
            const buyerPhone = document.getElementById('buyerPhone').value;
            const deliveryAddress = document.getElementById('deliveryAddress').value;
            const detailedAddress = document.getElementById('detailedAddress').value;
            const deliveryRequest = document.getElementById('deliveryRequest').value;

            const bankTransfer = document.getElementById('bankTransfer').checked;
            const creditCard = document.getElementById('creditCard').checked;
            const mobilePayment = document.getElementById('mobilePayment').checked;
            const virtualAccount = document.getElementById('virtualAccount').checked;

            // 결제 정보 확인
            console.log("구매자 이름: ", buyerName);
            console.log("이메일: ", buyerEmail);
            console.log("전화번호: ", buyerPhone);
            console.log("배송지 주소: ", deliveryAddress);
            console.log("상세 주소: ", detailedAddress);
            console.log("배송 요청 사항: ", deliveryRequest);
            console.log("계좌이체: ", bankTransfer);
            console.log("신용/체크카드: ", creditCard);
            console.log("휴대폰: ", mobilePayment);
            console.log("무통장입금(가상계좌): ", virtualAccount);

            alert("결제가 완료되었습니다!"); // 결제 완료 메시지
        });
    </script>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>