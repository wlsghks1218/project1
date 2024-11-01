const replyService = (function(){
	function add(reply, callback){
		fetch('/gReply/new', 
				{
					method : 'post',
					body : JSON.stringify(reply),
					headers : {'Content-type':'application/json; charset=utf-8'}
				})
			.then(response => response.text())
			.then(data => {
				callback(data);
			})
			.catch(err => console.log(err));
	}
	
    function getList(gno, userNo, page, size, callback) {
        fetch(`/gReply/${gno}/${userNo}/${page}/${size}`)
            .then(response => response.json())
            .then(data => {
                callback(data);
            })
            .catch(err => console.log(err));
    }
	
	function getAvgStars(callback) {
	    fetch('/gReply/avgStars', {
	        headers: {
	            'Accept': 'text/plain'
	        }
	    })
	    .then(response => response.text())
	    .then(data => {
	        callback(data);
	    })
	    .catch(err => console.log(err));
	}
	return {
		add : add,
		getList : getList,
		getAvgStars : getAvgStars
	};
})();