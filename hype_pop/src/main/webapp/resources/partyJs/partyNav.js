document.getElementById("searchReset").addEventListener('click', ()=>{
   location.href="/goodsStore/goodsSearch";
   localStorage.setItem('searchText', "");
})

document.getElementById("logout").addEventListener('click', () => {
	localStorage.removeItem('userNo');
})