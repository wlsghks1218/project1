document.addEventListener("DOMContentLoaded", () => {
	let userNoElement = document.getElementById("userNo");
	let userNo = userNoElement ? parseInt(userNoElement.value) : null;
	
    const categorySelect = document.getElementById("categorySelect");
    const searchInput = document.getElementById("searchInput");
    const searchLabel = document.querySelector("label[for='searchInput']");
    const searchResults = document.getElementById("searchResults");
    const selectedResultGroup = document.querySelector(".selectedResultGroup");
    const titleInputGroup = document.querySelector(".titleInputGroup");
    const setUserCountGroup = document.querySelector(".setUserCountGroup");

    searchInput.style.display = "none";
    searchLabel.style.display = "none";
    searchResults.style.display = "none";
    selectedResultGroup.style.display = "none";
    titleInputGroup.style.display = "none";
    setUserCountGroup.style.display = "none";

    categorySelect.addEventListener("change", () => {
        if (categorySelect.value !== "default") {
            searchInput.style.display = "block";
            searchLabel.style.display = "block";
            searchResults.style.display = "none";
            selectedResultGroup.style.display = "none";
            titleInputGroup.style.display = "none";
            setUserCountGroup.style.display = "none";
        } else {
            searchInput.style.display = "none";
            searchLabel.style.display = "none";
            searchResults.style.display = "none";
        }
    });

    searchInput.addEventListener("input", () => {
        if (searchInput.value.trim() !== "") {
            searchResults.style.display = "block";
        } else {
            searchResults.style.display = "none";
            selectedResultGroup.style.display = "none";
            titleInputGroup.style.display = "none";
            setUserCountGroup.style.display = "none";
        }
    });

    searchResults.addEventListener("click", (event) => {
        if (event.target.classList.contains("resultItem")) {
            document.getElementById("selectedResult").textContent = event.target.textContent;
            selectedResultGroup.style.display = "block";
            titleInputGroup.style.display = "block";
            setUserCountGroup.style.display = "block";

            searchResults.style.display = "none";
            searchInput.value = "";
        }
    });
});


document.getElementById("categorySelect").addEventListener('change', () => {
    const searchInput = document.getElementById("searchInput");
    const resultsDiv = document.getElementById("searchResults");
    const selectedDiv = document.getElementById("selectedResult");

    searchInput.value = "";
    resultsDiv.innerHTML = "";
    selectedDiv.innerHTML = "";
});

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
        	console.log(data);
            const resultsDiv = document.getElementById("searchResults");
            const selectedDiv = document.getElementById("selectedResult");
            resultsDiv.innerHTML = "";
            if (data && data.length > 0) {
                data.forEach(item => {
                    const resultItem = document.createElement("div");
                    resultItem.classList.add("resultItem");
                    
                    // category에 따라 item의 속성명 조건 분기
                    const itemName = category === "popup" ? item.psName : item.exhName;
                    resultItem.textContent = itemName;
                    
                    resultsDiv.appendChild(resultItem);
                    resultItem.addEventListener('click', () => {
                        selectedDiv.innerHTML = "";
                        selectedDiv.textContent = itemName;
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
    const searchLabel = document.querySelector("label[for='searchInput']");
    const category = document.getElementById("categorySelect");
    const resultsDiv = document.getElementById("searchResults");
    const selectedDiv = document.getElementById("selectedResult");
    const boardTitle = document.getElementById("boardTitle");
    const userMax = document.getElementById("maxUser");
    const selectedResultGroup = document.querySelector(".selectedResultGroup");
    const titleInputGroup = document.querySelector(".titleInputGroup");
    const setUserCountGroup = document.querySelector(".setUserCountGroup");

    // 요소 존재 여부 확인 후 초기화
    if (searchInput) searchInput.style.display = "none";
    if (searchLabel) searchLabel.style.display = "none"; // 검색 label 숨김
    if (resultsDiv) resultsDiv.style.display = "none";
    if (selectedResultGroup) selectedResultGroup.style.display = "none";
    if (titleInputGroup) titleInputGroup.style.display = "none";
    if (setUserCountGroup) setUserCountGroup.style.display = "none";

    if (searchInput) searchInput.value = "";
    if (category) category.value = "default";
    if (resultsDiv) resultsDiv.innerHTML = "";
    if (selectedDiv) selectedDiv.innerHTML = "";
    if (boardTitle) boardTitle.value = "";
    if (userMax) userMax.value = "default";
});


document.getElementById("goBack").addEventListener('click', () => {
	location.href = "/party/partyBoard";
});


document.getElementById("submitBtn").addEventListener('click', (e) => {
	
    const categorySelect = document.getElementById("categorySelect");
    const searchInput = document.getElementById("searchInput");
    const searchResults = document.getElementById("searchResults");
    const selectedResultGroup = document.querySelector(".selectedResultGroup");
    const titleInputGroup = document.querySelector(".titleInputGroup");
    const setUserCountGroup = document.querySelector(".setUserCountGroup");
	
	
	
	document.getElementById("targetName").value = document.getElementById("selectedResult").textContent;
	const selectedCat = document.getElementById("categorySelect").value;
	const searchResult = document.getElementById("searchResults");
	const titleInput = document.getElementById("boardTitle").value;
	const userMaxInfo = document.getElementById("maxUser").value;
	if(selectedCat === "default"){
		alert('카테고리를 선택하세요.');
		return;
	}if(searchResult.textContent.trim() === ""){
		alert('같이 가고싶은 전시횝 또는 팝업스토어를 선택해주세요.')
		return;
	}if(titleInput == ""){
		alert('제목을 입력하세요.');
		return;
	}if(userMaxInfo ==="default"){
		alert('인원수를 선택해주세요.')
		return;
	}

    let userNoInput = document.createElement("input");
    userNoInput.type = "hidden";
    userNoInput.name = "userNo";
    userNoInput.value = userNo;
	
    const form = document.getElementById("boardForm");
    form.appendChild(userNoInput);
    form.action = "/party/insertBoard";
    form.submit();
});