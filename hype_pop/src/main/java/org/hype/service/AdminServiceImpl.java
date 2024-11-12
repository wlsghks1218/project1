package org.hype.service;

import java.util.Date; 
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.hype.domain.Criteria;
import org.hype.domain.exhImgVO;
import org.hype.domain.exhVO;
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
	
	// 팝업스토어 수정/삭제 페이지 영역
	// 팝업스토어 정보 수정
//	@Override
//	public int updatePopStores(popStoreVO pvo) {
//		log.info("팝업스토어 수정..." + pvo);
//		
//		int result1 = mapper.updatePopStores(pvo);
//		pvo.getPsImg().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
//		log.warn(pvo.getPsNo());
//		int result2 = mapper.updatePsImage(pvo.getPsImg());	 // vo 가져오기
//		
//		pvo.getPsCat().setPsNo(pvo.getPsNo()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
//		
//		int result3 = mapper.updatePsCat(pvo.getPsCat());	 // vo 가져오기
//
//		log.warn("result1의 값은 " + result1);
//		log.warn("result2의 값은 " + result2);
//
//		return result1;		
//	}
	
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
		log.warn("파일이름 가져오기 " + gvo.getAttachList().get(0).getFileName());
		log.warn(gvo.getAttachList().get(1).getFileName());
	    int result1 = mapper.insertGoodsStore(gvo);
	    log.warn("상품 등록 결과: " + result1);	

	    if (result1 > 0) {

	    	for (gImgVO img : gvo.getAttachList()) {
	    		log.warn("gno는 ? : " + gvo.getGno());
	            img.setGno(gvo.getGno()); // gno를 각 이미지에 설정
	            // 배너 이미지 등록
	            if (img.getUploadPath().contains("굿즈 배너 사진")) {
	                int result2 = mapper.insertBannerImage(img);
	                log.warn("배너 이미지 등록 결과: " + result2);
	            }
	            // 상세 이미지 등록
	            else if (img.getUploadPath().contains("굿즈 상세 사진")) {
	                int result3 = mapper.insertDetailImage(img);
	                log.warn("상세 이미지 등록 결과: " + result3);
	            }
	        }
	    } else {
	        throw new RuntimeException("상품 등록 실패");
	    }
	    
	    gvo.getGcat().setGno(gvo.getGno()); // 시퀀스를 xml에서 처리한 거를 갖고온 것
	    
	    int result4 = mapper.insertGcat(gvo.getGcat());	    

	    return result1;
	}
	
	// 전시회 등록 페이지 영역
	// 전시회 정보 등록	
	@Transactional
	@Override
	public int insertExhibition(exhVO evo) {
	    // 1. 상품 등록
		log.warn("파일이름 가져오기 " + evo.getAttachExhList().get(0).getFileName());
		log.warn(evo.getAttachExhList().get(1).getFileName());
	    int result1 = mapper.insertExhibition(evo);
	    log.warn("전시회 등록 결과: " + result1);

	    if (result1 > 0) {

	    	for (exhImgVO exhImg : evo.getAttachExhList()) {
	    		exhImg.setExhNo(evo.getExhNo()); // exhNo를 각 이미지에 설정
	    		log.warn("전시회 번호 : " + evo.getExhNo());
	            // 배너 이미지 등록
	            if (exhImg.getUploadPath().contains("전시회 배너 사진")) {
	                int result2 = mapper.insertExhBannerImage(exhImg);
	                log.warn("배너 이미지 등록 결과: " + result2);
	            }
	            // 상세 이미지 등록
	            else if (exhImg.getUploadPath().contains("전시회 상세 사진")) {
	                int result3 = mapper.insertExhDetailImage(exhImg);
	                log.warn("상세 이미지 등록 결과: " + result3);
	            }
	        }
	    } else {
	        throw new RuntimeException("전시회 등록 실패");
	    }

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