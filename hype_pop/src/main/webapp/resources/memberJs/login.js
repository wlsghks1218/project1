document.querySelectorAll('button').forEach(btn => {
	btn.addEventListener('click', (e) => {
    	e.preventDefault();
    	
    	let type = btn.getAttribute('id'); 
    	
    	

        if ( type === "loginBtn") {
            
        	location.href = "/member/login";
            }
      
    });
});

document.querySelectorAll('span').forEach(a => {
    a.addEventListener('click', (event) => {
       
    	let clickVal = a.id;

        if (clickVal === "searchId") {
        	
        	location.href = "/member/searchId";
        	
        }else if (clickVal === "searchPw") {
        	
        	location.href = "/member/searchPw";
        	
		}else if (clickVal === "signIn") {
			
			location.href = "/member/signIn";
			
		}else if (clickVal === "mainLogo") {
			location.href = "/";
		}
      
    });
});