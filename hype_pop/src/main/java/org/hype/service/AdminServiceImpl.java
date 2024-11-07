package org.hype.service;

import java.util.Date; 
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.hype.domain.Criteria;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.pImgVO;
import org.hype.domain.payVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.hype.mapper.AdminMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	public AdminMapper mapper;
		
	// 페이징 처리
	// 팝업스토어 영역
	// 팝업스토어 리스트 가져오기
	@Override
	public List<popStoreVO> getPList(Criteria cri, String searchPs) {
		return mapper.getPList(cri, searchPs);
	}
	
	@Override
	public int getPTotal(String searchPs) {
		return mapper.getPTotal(searchPs);
	}	

	// 굿즈(상품) 영역
	// 굿즈(상품) 리스트 가져오기
	@Override
	public List<goodsVO> getGList(Criteria cri, String searchGs) {
		return mapper.getGList(cri, searchGs);
	}

	@Override
	public int getGTotal(String searchGs) {
		return mapper.getGTotal(searchGs);
	}	
	
	// 회원 영역
	// 회원 리스트 가져오기 
	@Override
	public List<signInVO> getMList(Criteria cri, String searchMs) {
		return mapper.getMList(cri, searchMs);
	}
	
	@Override
	public int getMTotal(String searchMs) {
		return mapper.getMTotal(searchMs);
	}
	
	// 특정 팝업스토어 조회
	@Override
	public popStoreVO getPopStoreById(int psNo) {
		return mapper.getPopStoreById(psNo);
	}
	
	// 특정 굿즈(상품) 조회
	@Override
	public goodsVO getGoodsById(int gNo) {
		return mapper.getGoodsById(gNo);
	}	
	
	// 특정 회원 조회
	@Override
	public signInVO getMembersById(String userId) {
		return mapper.getMembersById(userId);
	}
	
	// 팝업스토어 등록 페이지 영역
	// 팝업스토어 정보 등록
	@Transactional
	@Override
	public int insertPopStore(popStoreVO pvo) {
		
		int result1 = mapper.insertPopStore(pvo);
		pvo.getPsImg().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
		log.warn(pvo.getPsNo());
		int result2 = mapper.insertPsImage(pvo.getPsImg());	 // vo 가져오기
		
		pvo.getPsCat().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
		
		int result3 = mapper.insertPsCat(pvo.getPsCat());	 // vo 가져오기

		log.warn("result1의 값은 " + result1);
		log.warn("result2의 값은 " + result2);

		return result1;		
	}
	
	// 상품(굿즈) 등록 페이지 영역
	// 상품(굿즈) 정보 등록	
	@Override
	public List<popStoreVO> getAllPopStores() {
		return mapper.getAllPopStores();
	}
	
	@Transactional
	@Override
	public int insertGoodsStore(goodsVO gvo) {
	    // 1. 상품 등록
	    int result1 = mapper.insertGoodsStore(gvo);
	    
	    // gno를 각 이미지에 설정
	    if (gvo.getAttachList() != null && !gvo.getAttachList().isEmpty()) {
	        for (gImgVO img : gvo.getAttachList()) {
	            img.setGno(gvo.getGno()); // gno 설정
	            log.warn("gno 설정: " + gvo.getGno());
	            int result2 = mapper.insertGImage(img); // 각 이미지 등록
	            log.warn("insertGImage 결과: " + result2);
	            if (result2 <= 0) {
	                throw new RuntimeException("이미지 등록 실패: " + img.getFileName());
	            }
	        }
	    }

	    log.warn("result1의 값은 " + result1);
	    return result1;
	}


	// 문의 리스트 확인 페이지 영역
	// 문의 리스트 가져오기
	// 페이징 X
	@Override
    public List<qnaVO> getQnaListByType(String qnaType, String qnaAnswer) {        
        return mapper.getQnaListByType(qnaType, qnaAnswer);
    }
	
	// 페이징O	
//	@Override
//	public List<qnaVO> getQList(Criteria cri, String qnaType) {
//		return mapper.getQList(cri, qnaType);
//	}

//	@Override
//	public int getQTotal(String qnaType) {
//		return mapper.getQTotal(qnaType);
//	}


	// 상품 상태 조회 페이지 영역
    // 상품 상태 리스트 가져오기     
    @Override
    public List<payVO> getPurchaseList() {
    	List<payVO> purchaseList = mapper.getPurchaseList();
    	System.out.println("Fetched purchase list: " + purchaseList); // 로그 추가
        return purchaseList; 
    }
//    @Override
//    public int updatePurchaseList(payVO pvo) {
//        return mapper.updatePurchaseList(pvo);
//    }

    // 회원 정보 수정 페이지 영역
	// 회원 정보 업데이트	
	@Override
	public int updateMem(signInVO svo) {
		return mapper.updateMem(svo);
	}	
		
		
}