 $(document).ready(function() {
            IMP.init("imp41664822"); // 아임포트 초기화

            $('#kakaopay').on('click', function() {
                // 고유한 merchant_uid 생성
                var uniqueMerchantUid = 'ORD' + new Date().getTime();

                IMP.request_pay({
                    pg: "kakaopay",
                    pay_method: "card",
                    merchant_uid: uniqueMerchantUid, // 주문 고유 번호
                    name: "노르웨이 회전 의자",
                    amount: "64900"
                }, function(r) {
                    if (r.success) {
                        alert('결제가 완료되었습니다. (카카오페이)');
                    } else {
                        alert('결제에 실패하였습니다: ' + r.error_msg);
                    }
                });
            });

            $('#toss').on('click', function() {
                // 고유한 merchant_uid 생성
                var uniqueMerchantUid = 'ORD' + new Date().getTime();

                IMP.request_pay({
                    pg: "tosspayments",
                    pay_method: "card",
                    merchant_uid: uniqueMerchantUid, // 주문 고유 번호
                    name: "노르웨이 회전 의자",
                    amount: "64900"
                }, function(r) {
                    if (r.success) {
                        alert('결제가 완료되었습니다. (토스페이)');
                    } else {
                        alert('결제에 실패하였습니다: ' + r.error_msg);
                    }
                });
            });
//            $('#phone').on('click', function() {
//                // 고유한 merchant_uid 생성
//                var uniqueMerchantUid = 'ORD' + new Date().getTime();
//
//                IMP.request_pay({
//                    pg: "kakaopay", // 휴대폰 결제는 PG사에 따라 다를 수 있음
//                    pay_method: "phone",
//                    merchant_uid: uniqueMerchantUid, // 주문 고유 번호
//                    name: "노르웨이 회전 의자",
//                    amount: "64900"
//                }, function(r) {
//                    if (r.success) {
//                        alert('결제가 완료되었습니다. (휴대폰 결제)');
//                    } else {
//                        alert('결제에 실패하였습니다: ' + r.error_msg);
//                    }
//                });
//            });
    });


