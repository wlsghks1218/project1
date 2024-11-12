package org.hype.service;

import java.util.List;
import java.util.Map;

import org.hype.domain.Criteria;
import org.hype.domain.exhVO;
import org.hype.domain.goodsVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.payVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.springframework.stereotype.Service;

@Service
public interface AdminService {	
	// 공통 Header영역
	// 검색어 포함 팝업스토어 페이징 처리 
	// 팝업스토어 리스트 가져오기
	public List<popStoreVO> getPList(Criteria cri, String searchPs);	
	public int getPTotal(String searchPs);
	// 검색어 포함 굿즈 페이징 처리 
	// 상품 리스트 가져오기
	public List<goodsVO> getGList(Criteria cri, String searchGs);  
	public int getGTotal(String searchGs);
	// 검색어 포함 회원 페이징 처리 
	// 회원 리스트 가져오기
	public List<signInVO> getMList(Criteria cri, String searchMs);
	public int getMTotal(String searchMs);
	
	// 특정 팝업스토어 조회
	public popStoreVO getPopStoreById (int psNo);  
	// 특정 상품(굿즈) 조회
	public goodsVO getGoodsById (int gNo);  
	// 특정 회원 조회
	public signInVO getMembersById (String userId); 
	
	// 팝업스토어 등록하기
	public int insertPopStore(popStoreVO pvo); 
	
	// 팝업스토어 수정하기
//	public int updatePopStores(popStoreVO pvo);
	
	// 굿즈 등록하기 
	// selectbox 모든 팝업스토어 가져오기
	public List<popStoreVO> getAllPopStores();	
	// 굿즈 insert
	public int insertGoodsStore(goodsVO gvo);
	
	// 전시회 등록하기
	public int insertExhibition(exhVO evo);
	
	// 문의 리스트 확인 페이지 영역
	// 문의 리스트 가져오기	
	public List<qnaVO> getQnaListByType(String qnaType, String qnaAnswer);
//	public List<qnaVO> getQList(Criteria cri, String qnaType);  // 페이징O
//	public int getQTotal(String qnaType);
	
	// 상품 상태 조회 페이지 영역
	// 상품 상태 리스트 가져오기 
//	public int updatePurchaseList(payVO pvo); 
	public List<payVO> getPurchaseList(); 	

	// 회원 정보 수정 페이지 영역
	// 회원 정보 업데이트
	public int updateMem(signInVO svo); 
	

}