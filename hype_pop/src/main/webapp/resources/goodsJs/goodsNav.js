document.getElementById("searchReset").addEventListener('click', ()=>{
   location.href="/goodsStore/goodsSearch";
   localStorage.setItem('searchText', "");
})

function goToGoodsMain() {
    let userNoElement = document.getElementById("userNo");
    let userNo = userNoElement ? parseInt(userNoElement.value) : null;
    if (userNo) {
        location.href = "/goodsStore/goodsMain?userNo=" + userNo;
    } else {
        location.href = "/goodsStore/goodsMain";
    }
}