document.addEventListener('DOMContentLoaded', function() {
    let currentMonth = new Date().getMonth(); 
    let currentYear = new Date().getFullYear(); 
    const monthNames = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
    const userNo = localStorage.getItem("userNo");
    const interestCheckbox = document.getElementById('myInterest');
    const likeCheckbox = document.getElementById('myLike');
    
 // 달력 업데이트 함수
    function updateCalendar() {
        const monthLabel = document.getElementById('currentMonth');
        monthLabel.textContent = `${currentYear}년 ${monthNames[currentMonth]}`;
        
        const calendarDays = document.getElementById('calendar-days');
        calendarDays.innerHTML = '<td>HYPEPOP</td>';
        
        const lastDateOfMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
        const today = new Date(); // 오늘 날짜 가져오기

        for (let i = 1; i <= lastDateOfMonth; i++) {
            const currentDate = new Date(currentYear, currentMonth, i);
            const dayOfWeek = currentDate.getDay(); // 요일 (0 = 일요일, 6 = 토요일)

            let dayClass = '';
            if (dayOfWeek === 0) {
                // 일요일은 빨간색
                dayClass = 'style="color: red;"';
            } else if (dayOfWeek === 6) {
                // 토요일은 파란색
                dayClass = 'style="color: blue;"';
            }
            
            // 오늘 날짜와 현재 날짜 비교하여 같은 경우 스타일 적용
            let todayClass = '';
            if (today.toDateString() === currentDate.toDateString()) {
                todayClass = 'class="today"'; 
            }
            // 날짜를 달력에 추가
            calendarDays.insertAdjacentHTML('beforeend', `<td ${dayClass} ${todayClass} class="monthDate">${i}</td>`);
            
        }
        const selectedCategories = Array.from(document.querySelectorAll('.category-checkbox:checked')).map(cb => cb.value);
        const noSelectedCat = selectedCategories.length === 0; 
        const isInterestChecked = document.getElementById('myInterest').checked;
        const isLikeChecked = document.getElementById('myLike').checked;

        // 전체보기 체크박스 해제 시 캘린더와 팝업 리스트 비우기
        if (noSelectedCat && !document.getElementById('selectAll').checked && !isInterestChecked) {
            document.getElementById('calendar-body').innerHTML = '';
            document.getElementById('popUpList').innerHTML = '';
            return; 
        }

        // 유저 넘버가 없을 때 체크박스 비활성화 및 클릭 시 로그인 확인
        if (!userNo) {
        	interestCheckbox.classList.add('checkbox-disabled');
            likeCheckbox.classList.add('checkbox-disabled');
        	
            interestCheckbox.addEventListener('click', (event) => {
                event.preventDefault(); // 체크박스 선택 방지
                if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
                    location.href = '/member/login'; // 로그인 페이지로 이동
                }
            });

            likeCheckbox.addEventListener('click', (event) => {
                event.preventDefault(); // 체크박스 선택 방지
                if (confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?")) {
                    location.href = '/member/login'; // 로그인 페이지로 이동
                }
            });
        } else {
            // userNo가 있을 때 체크박스 이벤트 설정
        	interestCheckbox.classList.remove('checkbox-disabled');
            likeCheckbox.classList.remove('checkbox-disabled');
        }
        
        // 팝업스토어 정보 가져오기
        fetch(`/hypePop/calendarData?year=${currentYear}&month=${currentMonth + 1}`)
            .then(response => { 
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(storeData => {
                return fetch('/hypePop/categoryData').then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json().then(categoryData => {
                        return { storeData, categoryData }; 
                    });
                });
            })
            .then(({storeData, categoryData}) => {
                if (userNo) {
                    // 유저 넘버가 있을 때만 관심사와 좋아요 데이터를 fetch
                    return fetch(`/hypePop/userInterest?userNo=${userNo}`).then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json().then(userInterest => {
                            return { storeData, categoryData, userInterest }; 
                        });
                    }).then(({storeData, categoryData, userInterest}) => {
                        return fetch(`/hypePop/userLike?userNo=${userNo}`).then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json().then(userLike => {
                                return { storeData, categoryData, userInterest, userLike }; 
                            });
                        });
                    });
                } else {
                    return { storeData, categoryData, userInterest: null, userLike: null };
                }
            })
            .then(({ storeData, categoryData, userInterest, userLike }) => {
                const calendarBody = document.getElementById('calendar-body');
                const popUpList = document.getElementById('popUpList');  
                calendarBody.innerHTML = ''; 
                popUpList.innerHTML = ''; 

                const userInterests = userInterest ? userInterest[0] : null; 

                // 필터링된 팝업스토어 가져오기
                const filteredStores = storeData.filter(store => {
                    const categories = categoryData.filter(category => category.psNo === store.psNo);
                    const matchesCategory = selectedCategories.some(selectedCategory => 
                        categories.some(category => category[selectedCategory])
                    );

                    // 관심사 체크박스가 선택된 경우
                    const matchesInterest = userNo && isInterestChecked && userInterests && 
                        Object.keys(userInterests).some(interestKey => {
                            return userInterests[interestKey] === 1 && 
                                categories.some(category => category[interestKey] === 1);                                                      
                        });

                    // like 체크박스가 선택된 경우
                    const matchesLike = userNo && isLikeChecked && userLike && userLike.some(like => like.psNo === store.psNo);

                    // 조건 결합
                    return matchesCategory || matchesInterest || matchesLike;
                });

                filteredStores.forEach(item => {
                    const row = document.createElement('tr');
                    row.innerHTML = `<td class="psName" onclick="location.href='/hypePop/popUpDetails?storeName=${item.psName}'">${item.psName}</td>`;
           
                    const startDate = new Date(item.psStartDate);
                    const endDate = new Date(item.psEndDate);
                    let schedule = false;

                    // 달력에 날짜별로 팝업스토어 표시
                    for (let i = 1; i <= lastDateOfMonth; i++) {
                        const currentDate = new Date(currentYear, currentMonth, i);

                        if (currentDate.toDateString() === startDate.toDateString()) {
                            row.innerHTML += `<td class="schedule schedule-start">${new Date(item.psStartDate).toLocaleDateString()}</td>`;
                            schedule = true; 
                        } else if (currentDate.toDateString() === endDate.toDateString()) {
                            row.innerHTML += `<td class="schedule schedule-end">${new Date(item.psEndDate).toLocaleDateString()}</td>`;
                            schedule = true; 
                        } else if (currentDate > startDate && currentDate < endDate) {
                            row.innerHTML += `<td class="schedule schedule-1"></td>`;
                            schedule = true; 
                        } else {
                            row.innerHTML += `<td class="schedule"></td>`;
                        }
                    }

                    if (schedule) {
                        calendarBody.appendChild(row);

                        const popUpItem = document.createElement('div');
                        popUpItem.classList.add('popUpItem');
                        popUpItem.innerHTML = 
                            `<div class="psImage"></div>
                            <div>
                                <span>${item.psName}</span>
                                <span>${item.psAddress}</span>
                                <span>${new Date(item.psStartDate).toLocaleDateString()} ~ ${new Date(item.psEndDate).toLocaleDateString()}</span>
                            </div>`;

                        // 팝업스토어 클릭 시 상세 페이지로 이동
                        popUpItem.addEventListener('click', function() {
                            location.href = `/hypePop/popUpDetails?storeName=${item.psName}`;
                        });

                        popUpList.appendChild(popUpItem); 
                    }
                });
                addMouseOverEventToPsName();
            })
            .catch(error => console.error('Error fetching data:', error));
    }

// // 체크박스 상태 저장 및 복원
// function saveCheckboxState() {
// const checkboxStates = {};
// checkboxes.forEach(checkbox => {
// checkboxStates[checkbox.value] = checkbox.checked;
// });
// localStorage.setItem('checkboxStates', JSON.stringify(checkboxStates));
// }

    function loadCheckboxState() {
        const checkboxStates = JSON.parse(localStorage.getItem('checkboxStates'));
        if (checkboxStates) {
            Object.keys(checkboxStates).forEach(key => {
                const checkbox = document.querySelector(`.category-checkbox[value="${key}"]`);
                if (checkbox) {
                    checkbox.checked = checkboxStates[key];
                }
            });
        } else {
            // 체크박스 상태가 없으면 모든 체크박스 선택
            checkboxes.forEach(checkbox => {
                checkbox.checked = true;
            });
            selectAllCheckbox.checked = true; // 전체 선택 체크박스도 체크
        }
    }

    // 체크박스 이벤트 리스너 추가
    const checkboxes = document.querySelectorAll('.category-checkbox');
    const selectAllCheckbox = document.getElementById('selectAll');


    // 전체보기 체크박스 상태 변경 시
    selectAllCheckbox.addEventListener('change', function() {
        const isChecked = this.checked;
        checkboxes.forEach(checkbox => {
            checkbox.checked = isChecked; // 전체보기 체크박스 상태에 따라 모두 체크하거나 해제
        });
// saveCheckboxState();
        updateCalendar(); 
    });

    // 개별 체크박스 상태 변경 시 전체보기 체크박스 상태 업데이트
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allChecked = Array.from(checkboxes).every(cb => cb.checked);
            selectAllCheckbox.checked = allChecked; 
// saveCheckboxState();
            updateCalendar(); 
        });
    });

    // 이전 달로 이동
    document.getElementById('prevMonth').addEventListener('click', function() {
        currentMonth--;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        }
        updateCalendar(); 
    });

    // 다음 달로 이동
    document.getElementById('nextMonth').addEventListener('click', function() {
        currentMonth++;
        if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        updateCalendar(); 
    });
    
 // 현재 날짜가 포함하는 달로 이동
    document.getElementById('currentDateMonth').addEventListener('click', function() {
        const today = new Date(); 
        currentMonth = today.getMonth(); 
        currentYear = today.getFullYear();
        updateCalendar();
    });
    
 // 캘린더에서 이름에 마우스를 가져다 대면 오른쪽 리스트에 표시하기
    function addMouseOverEventToPsName() {
        const psNames = document.querySelectorAll('.psName'); // 모든 psName 요소
        const popUpItems = document.querySelectorAll('.popUpItem'); // popUpList의
                                                   // 아이템들 가져오기
        
        // 메시지를 표시할 요소 생성
        const tooltip = document.createElement('div');
        tooltip.className = 'tooltip'; // 클래스 추가 (CSS 스타일을 위해)
        tooltip.style.position = 'absolute';
        tooltip.style.backgroundColor = 'lightgray';
        tooltip.style.border = '1px solid black';
        tooltip.style.padding = '5px';
        tooltip.style.display = 'none'; // 기본적으로 숨김
        document.body.appendChild(tooltip); // 문서에 추가

        popUpItems.forEach((item) => {
            item.setAttribute('tabindex', '0'); // div 요소에 포커스 속성 추가
        });
        
        psNames.forEach((name, index) => {
            name.addEventListener('mouseover', function(event) {
                name.style.backgroundColor = 'lightblue';
                popUpItems[index].style.backgroundColor = 'lightyellow';
                popUpItems[index].focus(); // list에 포커스

                // tooltip 위치 및 내용 설정
                tooltip.style.display = 'block';
                tooltip.style.left = `${event.pageX}px`; // 마우스 위치에 따라
                tooltip.style.top = `${event.pageY + 20}px`; // 약간 아래에 위치
                tooltip.innerText = '클릭 시 상세 페이지로 이동';
            });

            name.addEventListener('mouseout', function() {
                // 마우스아웃 시 원래 상태로 복귀
                name.style.backgroundColor = '';
                popUpItems[index].style.backgroundColor = '';
                popUpItems[index].blur(); // list에 포커스
                tooltip.style.display = 'none'; // tooltip 숨김
            });
        });
    }
    
    // 초기 화면 로드시 데이터 불러오기
    loadCheckboxState(); // 체크박스 상태 복원 및 초기화
    updateCalendar();
});