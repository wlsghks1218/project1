document.getElementById("searchReset").addEventListener('click', ()=>{
   location.href="/goodsStore/goodsSearch";
   localStorage.setItem('searchText', "");
})