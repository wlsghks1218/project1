// 활성화된 탭을 추적하기 위한 변수
let activeTab = 'popUp';

// form 객체 가져오기
const f = document.forms[0];

// 페이징 처리
let currentPageForPopUp = 1; // 팝업 스토어 현재 페이지
let currentPageForGoods = 1; // 상품 현재 페이지
let currentPageForMembers = 1; // 회원 현재 페이지
let currentPageForExh = 1; // 전시회 현재 페이지
const amount = 14;     // 출력되는 개수
let totalPagesForPopUp = 0; // 팝업 스토어 총 페이지 수
let totalCountForPopUp = 0; // 팝업 스토어 총 아이템 수
let totalPagesForGoods = 0; // 상품 총 페이지 수
let totalCountForGoods = 0; // 상품 총 아이템 수
let totalPagesForMembers = 0; // 회원 총 페이지 수
let totalCountForMembers = 0; // 회원 총 회원 수
let totalPagesForExh = 0;       // 전시회 총 회원 수 
let totalCountForExh = 0;       // 전시회 총 페이지 수 
let isPopUpPage = true; // 팝업 페이지인지 여부
let isMemberPage = false; // 회원 페이지인지 여부
let isGoodsPage = false; // 굿즈 페이지인지 여부
let isExhPage = false; // 전시회 페이지인지 여부

// 등록하기 버튼 상태 설정 함수
function updateRegisterBtnState(text, opacity, isDisabled, cursor) {
    const registerBtn = document.getElementById('registerBtn');
    registerBtn.textContent = text; // 버튼 텍스트 설정
    registerBtn.style.opacity = opacity; // 불투명도 설정
    registerBtn.disabled = isDisabled; // 버튼 비활성화/활성화 설정
    registerBtn.style.cursor = cursor; // 커서 스타일 설정
}

// **** 관리자 Header 영역 (공통) ****
// 탭 클릭 시 해당 기능 활성화
document.getElementById('popUpManage').addEventListener('click', function() {
    activeTab = 'popUp'; // 현재 활성화된 탭 업데이트    
    isPopUpPage = true;
    isMemberPage = false;
    isGoodsPage = false;
    isExhPage = false;
    currentPageForPopUp = 1; // 초기화
    loadPopUpStores(currentPageForPopUp);   
    toggleSearchBox(true); // 검색 박스와 버튼 보이기
    updateRegisterBtnState('팝업스토어 등록하기', '1', false, 'pointer');
});
document.getElementById('storeManage').addEventListener('click', function() {
    activeTab = 'store'; // 현재 활성화된 탭 업데이트
    isPopUpPage = false;
    isMemberPage = false;
    isGoodsPage = true;
    isExhPage = false;
    currentPageForGoods = 1; // 초기화
    loadGoodsStores(currentPageForGoods);
    toggleSearchBox(true); // 검색 박스와 버튼 보이기
    updateRegisterBtnState('쇼핑몰 등록하기', '1', false, 'pointer');
});
document.getElementById('exhManage').addEventListener('click', function() {
    activeTab = 'exh'; // 현재 활성화된 탭 업데이트
    isPopUpPage = false;
    isMemberPage = false;
    isGoodsPage = false;
    isExhPage = true;
    currentPageForExh = 1;  // 초기화
    loadExhibitions(currentPageForExh);
    toggleSearchBox(true); // 검색 박스와 버튼 보이기
    updateRegisterBtnState('전시회 등록하기', '1', false, 'pointer');
});
document.getElementById('memberManage').addEventListener('click', function() {
   activeTab = 'member'; // 현재 활성화된 탭 업데이트
   isPopUpPage = false;
   isMemberPage = true;
   isGoodsPage = false;
   isExhPage = false;
   currentPageForMembers = 1;  // 초기화
   loadMembersStores(currentPageForMembers);
   toggleSearchBox(true); // 검색 박스와 버튼 보이기
   updateRegisterBtnState('등록하기', '0.5', true, 'not-allowed');
});

// 검색 박스와 버튼 보이기/숨기기 함수
function toggleSearchBox(shouldShow) {
    const searchBox = document.getElementById('adminSearchBox');
    const searchButton = document.getElementById('searchBTN');

    if (shouldShow) {
        searchBox.style.display = 'inline'; // 보이기
        searchButton.style.display = 'inline'; // 보이기
    } else {
        searchBox.style.display = 'none'; // 숨기기
        searchButton.style.display = 'none'; // 숨기기
    }
}

// 관리자 메인페이지(초기 페이지 로드)에서는 검색 박스와 버튼 숨기기
toggleSearchBox(false);

// **** 관리자 페이지 영역 ****
// **** 팝업스토어 영역 ****
// 검색 버튼 클릭 이벤트 추가
document.getElementById('searchBTN').addEventListener('click', function() {
    if (activeTab === 'popUp') {
       loadPopUpStores(currentPageForPopUp);
    } else if (activeTab === 'store') {
        loadGoodsStores(currentPageForGoods);
    } else if (activeTab === 'exh') {
       loadExhibitions(currentPageForExh);
    } else if (activeTab === 'member') {
       loadMembersStores(currentPageForMembers);
    }
});

// 팝업스토어 관리하기 버튼 활성화 
function loadPopUpStores(page = 1) {
   currentPageForPopUp = page; // 현재 페이지 업데이트
    const searchPs = document.getElementById('adminSearchBox').value;
       fetch(`/admin/psList?searchPs=${encodeURIComponent(searchPs)}&pageNum=${page}&amount=${amount}`)
           .then(response => {
               if (!response.ok) {
                   throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
               }
               return response.json();
           })
           .then(data => {
               if (data.list && data.total) {
                  
                   PopUpStoreLists(data.list);

                   totalCountForPopUp = data.total; // 전체 아이템 수 저장
                   totalPagesForPopUp = Math.ceil(totalCountForPopUp / amount); // 총 페이지 수 계산
                   createPagination(totalPagesForPopUp, totalCountForPopUp); // 페이지네이션 생성

               } else {
                   throw new Error('잘못된 데이터 구조입니다. 데이터: ' + JSON.stringify(data));
               }
           })
           .catch(err => {
               console.error('오류:', err);
           });
}

// 팝업스토어 관리하기 버튼 클릭 시 팝업 스토어 리스트 영역 출력
function PopUpStoreLists(popUpStores) {
    const popSList = document.querySelector('#AllList');
    const adminMain = document.querySelector('.adminMain');
    popSList.innerHTML = '';
   
    if (popUpStores.length === 0) {
       adminMain.innerHTML = '<p>팝업 스토어가 없습니다.</p>';
       return;
    }
   
//    psNo 기준으로 정렬 (db에서 던질 때 정렬하기 때문에 따로 할 필요 x)
//    popUpStores.sort((a, b) => a.psNo - b.psNo);

    popUpStores.forEach(store => {   
       // 해당 팝업스토어 클릭 시 수정/삭제 페이지로 이동
        const link = document.createElement('a');
        link.href = `popUpUpdate?psNo=${store.psNo}`;
        link.style.color = 'black'; 
        link.style.textDecoration = 'none'; 
        link.style.display = 'block';

        const psList = document.createElement('p');
        psList.appendChild(document.createTextNode(` ${store.psNo} `));
        psList.appendChild(document.createTextNode(store.psName));
        psList.appendChild(document.createTextNode(` ${new Date(store.psStartDate).toLocaleDateString()} ~ ${new Date(store.psEndDate).toLocaleDateString()}`));
        link.appendChild(psList);
        popSList.appendChild(link);
    });
   
    
    // form 영역 숨기기
    const elements = [
        document.querySelector('form'),
        document.querySelector('#beforeList'),
        document.querySelector('#beforeImg1'),
        document.querySelector('#beforeImg2'),
        document.querySelector('#beforeImg'),
        document.querySelector('#psCancel'),
        document.querySelector('#psDelete'),
        document.querySelector('#psUpdate'),
        document.querySelector('#gCancel'),
        document.querySelector('#gDelete'),
        document.querySelector('#gUpdate'),
        document.querySelector('#exhCancel'),
        document.querySelector('#exhDelete'),
        document.querySelector('#exhUpdate'),
        document.querySelector('#mCancel'),
        document.querySelector('#mUpdate'),
        document.querySelector('#qnaListCat'),
        document.querySelector('#storeList')
    ];

    elements.forEach(element => {
        if (element) {
            element.style.display = 'none';
        }
    });
       
}

function createPagination(totalPages, totalCount) {
    const paginationContainer = document.getElementById('pagination');

    // paginationContainer가 null인지 확인
    if (!paginationContainer) {
        console.warn('Pagination container not found!'); // 경고 메시지
        return; // 함수 종료
    }

    paginationContainer.innerHTML = '';

    if (totalPages <= 0) {
        console.log('페이지 수가 0이므로 페이지네이션을 표시하지 않습니다.');
        return;
    }

    const currentPage = isExhPage ? currentPageForExh : 
                    (isMemberPage ? currentPageForMembers : 
                    (isGoodsPage ? currentPageForGoods : currentPageForPopUp));

    // 이전 버튼
    const prevBtn = document.createElement('button');
    prevBtn.textContent = '<';
    prevBtn.disabled = currentPage === 1;
    prevBtn.addEventListener('click', () => {
       if (isExhPage) {
            if (currentPageForExh > 1) {
                currentPageForExh--;
                loadExhibitions(currentPageForExh);
            }
        } else if (isMemberPage) {
            if (currentPageForMembers > 1) {
                currentPageForMembers--;
                loadMembersStores(currentPageForMembers);
            }
        } else if (isGoodsPage) {
            if (currentPageForGoods > 1) {
                currentPageForGoods--;
                loadGoodsStores(currentPageForGoods);
            }
        } else {
            if (currentPageForPopUp > 1) {
                currentPageForPopUp--;
                loadPopUpStores(currentPageForPopUp);
            }
        }
    });
    paginationContainer.appendChild(prevBtn);

    // 페이지 링크 추가
    for (let i = 1; i <= totalPages; i++) {
        const pageLink = document.createElement('a');
        pageLink.href = '#';
        pageLink.textContent = i;
        pageLink.addEventListener('click', (e) => {
            e.preventDefault();
            if (isExhPage) {
                currentPageForExh = i;
                loadExhibitions(currentPageForExh);
            } else if (isMemberPage) {
                currentPageForMembers = i;
                loadMembersStores(currentPageForMembers);
            } else if (isGoodsPage) {
                currentPageForGoods = i;
                loadGoodsStores(currentPageForGoods);
            } else {
                currentPageForPopUp = i;
                loadPopUpStores(currentPageForPopUp);
            }
        });

     // 현재 페이지 강조
        if (isExhPage && i === currentPageForExh ||
            isMemberPage && i === currentPageForMembers ||
            isGoodsPage && i === currentPageForGoods ||
            !isMemberPage && !isGoodsPage && !isExhPage && i === currentPageForPopUp) {
            pageLink.style.fontWeight = 'bold';
        }
        paginationContainer.appendChild(pageLink);
    }

    // 다음 버튼
    const nextBtn = document.createElement('button');
    nextBtn.textContent = '>';
    nextBtn.disabled = currentPage === totalPages;
    nextBtn.addEventListener('click', () => {
       if (isExhPage) {
            if (currentPageForExh < totalPages) {
                currentPageForExh++;
                loadExhibitions(currentPageForExh);
            }
        } else if (isMemberPage) {
            if (currentPageForMembers < totalPages) {
                currentPageForMembers++;
                loadMembersStores(currentPageForMembers);
            }
        } else if (isGoodsPage) {
            if (currentPageForGoods < totalPages) {
                currentPageForGoods++;
                loadGoodsStores(currentPageForGoods);
            }
        } else {
            if (currentPageForPopUp < totalPages) {
                currentPageForPopUp++;
                loadPopUpStores(currentPageForPopUp);
            }
        }
    });
    paginationContainer.appendChild(nextBtn);
}


// 페이징 O
// 굿즈는 너무 많아서 amount 30으로 일단 선언함
function loadGoodsStores(page = 1, amount = 30) {
    currentPageForGoods = page;
    const searchGs = document.getElementById('adminSearchBox').value;
     fetch(`/admin/gList?searchGs=${encodeURIComponent(searchGs)}&pageNum=${page}&amount=${amount}`)
         .then(response => {
             if (!response.ok) {
                 throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
             }
             return response.json();
         })
         .then(data => {
//               console.log('API 응답:', JSON.stringify(data, null, 2));
             if (data.list && data.total) {
                GoodsLists(data.list);

               totalCountForGoods = data.total; // 전체 아이템 수 저장
                totalPagesForGoods = Math.ceil(totalCountForGoods / amount); // 총 페이지 수 계산
               
                if (totalPagesForGoods > 0) {
                    createPagination(totalPagesForGoods, totalCountForGoods); // 페이지네이션 생성
                } else {
                    console.log('페이지 수가 0이므로 페이지네이션을 표시하지 않습니다.');
                }
            } else {
                throw new Error('잘못된 데이터 구조입니다. 데이터: ' + JSON.stringify(data));
            }
         })
        .catch(err => {
            console.error('오류:', err);
        });
}

// 쇼핑몰 관리하기 버튼 클릭 시 상품 리스트 영역 출력
function GoodsLists(goods) {
//   console.log('굿즈들을 잘 받아오나요??!:', goods); // 데이터 확인
    const gList = document.querySelector('#AllList');
    const adminMain = document.querySelector('.adminMain');
    
    // 에러 나서 임시로 코드 작성
    if (!gList) {
        console.log('Error: #AllList element not found.');
        return; // 요소가 없으면 함수 종료
    }
    
    gList.innerHTML = '';
   
    if (goods.length === 0) {
       adminMain.innerHTML = '<p>상품이 없습니다.</p>';
       return;
    }
   
    goods.forEach(store => {   
       // 굿즈(상품) 이름 클릭 시 링크로 이동
        const link = document.createElement('a');
        link.href = `goodsUpdate?gno=${store.gno}`;
        link.style.color = 'black'; 
        link.style.textDecoration = 'none';
        link.style.display = 'block';

        const gsList = document.createElement('p');
        gsList.appendChild(document.createTextNode(` ${store.gno} `));
        gsList.appendChild(document.createTextNode(store.gname));
        gsList.appendChild(document.createTextNode(` ${new Date(store.sellDate).toLocaleDateString()} ${store.gprice}`));
        link.appendChild(gsList);
        gList.appendChild(link);
    });
   
    const form = document.querySelector('form');
    if (form) {
        form.style.display = 'none';
    }
    
    // form 영역 숨기기
    const elements = [
        document.querySelector('form'),
        document.querySelector('#beforeList'),
        document.querySelector('#beforeImg1'),
        document.querySelector('#beforeImg2'),
        document.querySelector('#beforeImg'),
        document.querySelector('#psCancel'),
        document.querySelector('#psDelete'),
        document.querySelector('#psUpdate'),
        document.querySelector('#gCancel'),
        document.querySelector('#gDelete'),
        document.querySelector('#gUpdate'),
        document.querySelector('#exhCancel'),
        document.querySelector('#exhDelete'),
        document.querySelector('#exhUpdate'),
        document.querySelector('#mCancel'),
        document.querySelector('#mUpdate'),
        document.querySelector('#qnaListCat'),
        document.querySelector('#storeList')
    ];

    elements.forEach(element => {
        if (element) {
            element.style.display = 'none';
        }
    });
}

// 전시회 관리하기 버튼 활성화 
function loadExhibitions(page = 1) {
   currentPageForExh = page; // 현재 페이지 업데이트
    const searchEs = document.getElementById('adminSearchBox').value;
       fetch(`/admin/exhList?searchEs=${encodeURIComponent(searchEs)}&pageNum=${page}&amount=${amount}`)
           .then(response => {
               if (!response.ok) {
                   throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
               }
               return response.json();
           })
           .then(data => {
               if (data.list && data.total) {
                  
                   ExhibitionLists(data.list);

                   totalCountForExh = data.total; // 전체 아이템 수 저장
                   totalPagesForExh = Math.ceil(totalCountForExh / amount); // 총 페이지 수 계산
                   createPagination(totalPagesForExh, totalCountForExh); // 페이지네이션 생성

               } else {
                   throw new Error('잘못된 데이터 구조입니다. 데이터: ' + JSON.stringify(data));
               }
           })
           .catch(err => {
               console.error('오류:', err);
           });
}

// 전시회 관리하기 버튼 클릭 시 전시회 리스트 영역 출력
function ExhibitionLists(exhibitions) {
   const exhList = document.querySelector('#AllList');
    const adminMain = document.querySelector('.adminMain');
    
    // 기존 목록 초기화
    exhList.innerHTML = '';
   
    if (exhibitions.length === 0) {
        adminMain.innerHTML = '<p>전시회가 없습니다.</p>';
        return;
    }
   
    exhibitions.forEach(store => {  
        // 해당 팝업스토어 클릭 시 수정/삭제 페이지로 이동
        const link = document.createElement('a');
        link.href = `exhUpdateDelete?exhNo=${store.exhNo}`;
        link.style.color = 'black'; 
        link.style.textDecoration = 'none'; 
        link.style.display = 'block';

        // 새로운 <p> 요소 생성
        const exhItem = document.createElement('p');
        exhItem.appendChild(document.createTextNode(` ${store.exhNo} `));
        exhItem.appendChild(document.createTextNode(store.exhName));
        exhItem.appendChild(document.createTextNode(` ${new Date(store.exhStartDate).toLocaleDateString()} ~ ${new Date(store.exhEndDate).toLocaleDateString()}`));

        // <p> 요소를 링크 안에 추가
        link.appendChild(exhItem);

        // 최종적으로 링크를 exhList에 추가
        exhList.appendChild(link);
    });
   
    const form = document.querySelector('form');
    if (form) {
        form.style.display = 'none';
    }
    
    // form 영역 숨기기
    const elements = [
        document.querySelector('form'),
        document.querySelector('#beforeList'),
        document.querySelector('#beforeImg1'),
        document.querySelector('#beforeImg2'),
        document.querySelector('#beforeImg'),
        document.querySelector('#psCancel'),
        document.querySelector('#psDelete'),
        document.querySelector('#psUpdate'),
        document.querySelector('#gCancel'),
        document.querySelector('#gDelete'),
        document.querySelector('#gUpdate'),
        document.querySelector('#exhCancel'),
        document.querySelector('#exhDelete'),
        document.querySelector('#exhUpdate'),
        document.querySelector('#mCancel'),
        document.querySelector('#mUpdate'),
        document.querySelector('#qnaListCat'),
        document.querySelector('#storeList')
    ];

    elements.forEach(element => {
        if (element) {
            element.style.display = 'none';
        }
    });
   
}

//**** 회원 영역 ****
// 회원 관리하기 활성화
function loadMembersStores(page = 1) {
   currentPageForMembers = page; // 현재 페이지 업데이트 (추가된 코드)
   const searchMs = document.getElementById('adminSearchBox').value;
       fetch(`/admin/mList?searchMs=${encodeURIComponent(searchMs)}&pageNum=${page}&amount=${amount}`)
           .then(response => {
               if (!response.ok) {
                   throw new Error('리스트가 출력되지 않았습니다: ' + response.statusText);
               }
               return response.json();
           })
           .then(data => {
               if (data.list && data.total) {
                                    
                  MemberLists(data.list);

                  totalCountForMembers = data.total; // 전체 아이템 수 저장
                  totalPagesForMembers = Math.ceil(totalCountForMembers / amount); // 총 페이지 수 계산
                   
//                   createPagination(totalPagesForMembers, totalCountForMembers, false); // 페이지네이션 생성
                   
                   if (totalPagesForMembers > 0) {
                       createPagination(totalPagesForMembers, totalCountForMembers); // 페이지네이션 생성
                   } else {
                       console.log('페이지 수가 0이므로 페이지네이션을 표시하지 않습니다.');
                   }
               } else {
                   throw new Error('잘못된 데이터 구조입니다. 데이터: ' + JSON.stringify(data));
               }
           })
           .catch(err => {
               console.error('오류:', err);
           });
}

// 회원 관리하기 버튼 클릭 시 회원 리스트 출력
function MemberLists(members) {
   const mList = document.querySelector('#AllList');
    const adminMain = document.querySelector('.adminMain');
    
    // 에러 나서 임시로 코드 작성
    if (!mList) {
        console.log('Error: #AllList element not found in MemberLists.');
        return; // 요소가 없으면 함수 종료
    }
    
    mList.innerHTML = '';

    if (members.length === 0) {
        adminMain.innerHTML = '<p>회원이 없습니다.</p>';
        return;
    }

    members.forEach(member => {       
       // 회원아이디 클릭 시 회원 정보 수정 페이지로 이동
        const link = document.createElement('a');
        link.href = `memberUpdate?userNo=${member.userNo}`;
        link.style.color = 'black';    
        link.style.textDecoration = 'none'; 
        link.style.display = 'block';

        const msList = document.createElement('p');
        
        const mauth = `${member.auth}` == "1" ? "일반 유저" : "관리자";
              
      msList.appendChild(document.createTextNode(`유저 넘버 : ${member.userNo} | `) );
      msList.appendChild(document.createTextNode("유저 아이디 : " + member.userId + " | "));
      msList.appendChild(document.createTextNode(`유저 이메일 : ${member.userEmail} | 권한 : ${mauth}`));
       
      link.appendChild(msList);
      mList.appendChild(link);
    });
    
    const form = document.querySelector('form');
    if (form) {
        form.style.display = 'none';
    }
    
    // form 영역 숨기기
    const elements = [
        document.querySelector('form'),
        document.querySelector('#beforeList'),
        document.querySelector('#beforeImg1'),
        document.querySelector('#beforeImg2'),
        document.querySelector('#beforeImg'),
        document.querySelector('#psCancel'),
        document.querySelector('#psDelete'),
        document.querySelector('#psUpdate'),
        document.querySelector('#gCancel'),
        document.querySelector('#gDelete'),
        document.querySelector('#gUpdate'),
        document.querySelector('#exhCancel'),
        document.querySelector('#exhDelete'),
        document.querySelector('#exhUpdate'),
        document.querySelector('#mCancel'),
        document.querySelector('#mUpdate'),
        document.querySelector('#qnaListCat'),
        document.querySelector('#storeList')
    ];

    elements.forEach(element => {
        if (element) {
            element.style.display = 'none';
        }
    });
}

//**** footer 영역 ****
// 문의 리스트 확인 버튼 클릭 시 문의 리스트 확인 페이지로 이동
// const로 변수 설정해서 한 이유는 관리자 페이지를 제외한 페이지에서는
// footer을 쓰지 않지만 admin.js는 전체 페이지에서 사용하므로
// 변수 설정한 후 기본값이 null이므로 만약에 askList가 null이 아니면
// 즉, askList가 있으면 아래 코드 실행하라는 코드임 (footer 영역 전체에 적용)
const askList = document.querySelector('#askList');
if(askList != null){
   document.querySelector('#askList').addEventListener('click', function() {
      location.href = '/admin/askListCheck'; // JSP 페이지로 이동
   });
}

// 상품 상태 조회 버튼 클릭 시 상품 상태 조회 페이지로 이동
const goodsState = document.querySelector('#goodsState');
if(goodsState !== null){
   document.querySelector('#goodsState').addEventListener('click', checkGoodsState);
   
   function checkGoodsState() {
      window.location.href = '/admin/goodsState'; // JSP 페이지로 이동
   }   
}

// 등록, 메인페이지 버튼 클릭 시 페이지 이동 함수
function goToPage(url) {
   window.location.href = url;
}

// 등록하기 버튼 클릭 시 이동
const registerBtn = document.querySelector('#registerBtn');
if(registerBtn != null){
   document.getElementById('registerBtn').addEventListener('click', function() {
      if (activeTab === 'popUp') {
         goToPage('/admin/popUpRegister'); // 팝업스토어 관리 탭에서 버튼 클릭 시 팝업 스토어 등록 페이지로 이동 (컨트롤러 경로)
      } else if (activeTab === 'store') {
         goToPage('/admin/goodsRegister'); // 쇼핑몰 관리 탭에서 버튼 클릭 시 상품(굿즈) 등록 페이지로 이동 (컨트롤러 경로)
      } else if(activeTab === 'exh') {
         goToPage('/admin/exhRegister'); // 전시회 관리 탭에서 버튼 클릭 시 전시회 등록 페이지로 이동 (컨트롤러 경로)
      }
   });   
}

// 메인페이지 버튼 클릭 시 이동
const backToMainPage = document.getElementById('backToMainPage');
if(backToMainPage != null){
   document.getElementById('backToMainPage').addEventListener('click', function() {
         goToPage('/admin/adminPage'); // 전시회 관리 탭에서 버튼 클릭 시 전시회 등록 페이지로 이동 (컨트롤러 경로)
   });   
}