document.getElementById("searchInput").addEventListener('keyup', () => {
	const searchInput = document.getElementById("searchInput").value;
	const category = document.getElementById("categorySelect").value;

	if (searchInput.trim() === "") {
		document.getElementById("searchResults").innerHTML = "";
		return;
	}
	
	fetch(`/party/search?searchText=${encodeURIComponent(searchInput)}&category=${category}`)
		.then(response => response.json())
		.then(data => {
			const resultsDiv = document.getElementById("searchResults");
			const selectedDiv = document.getElementById("selectedResult");
			resultsDiv.innerHTML = "";
			if (data && data.length > 0) {
				data.forEach(item => {
					const resultItem = document.createElement("div");
					resultItem.classList.add("resultItem");
					resultItem.textContent = item.psName;
					resultsDiv.appendChild(resultItem);
                    resultItem.addEventListener('click', () => {
                        selectedDiv.innerHTML = "";
                        selectedDiv.textContent = item.psName;
                    });
				});
			} else {
				resultsDiv.innerHTML = "<div class='noResults'>검색 결과가 없습니다.</div>";
			}
		})
		.catch(error => console.error("Error fetching search results:", error));
});

document.getElementById("resetBtn").addEventListener('click', () => {
    const searchInput = document.getElementById("searchInput");
    const category = document.getElementById("categorySelect");
    const resultsDiv = document.getElementById("searchResults");
    const selectedDiv = document.getElementById("selectedResult");
    const boardTitle = document.getElementById("boardTitle");

    searchInput.value = "";
    category.value = "default";
    resultsDiv.innerHTML = "";
    selectedDiv.innerHTML = "";
    boardTitle.value = "";
});

document.getElementById("goBack").addEventListener('click', () => {
	location.href = "/party/partyBoard";
});

const userNo = 1;
document.getElementById("submitBtn").addEventListener('click', () => {
	document.getElementById("targetName").value = document.getElementById("selectedResult").textContent;

    // userNo 값을 가진 hidden input 추가
    let userNoInput = document.createElement("input");
    userNoInput.type = "hidden";
    userNoInput.name = "userNo";
    userNoInput.value = userNo;
	
    const form = document.getElementById("boardForm");
    form.appendChild(userNoInput);
    form.action = "/party/insertBoard";
    form.submit();
});

