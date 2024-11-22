package org.hype.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.Criteria;
import org.hype.domain.exhImgVO;
import org.hype.domain.exhVO;
import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
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
	// 검색어 포함 전시회 페이징 처리 
	// 전시회 리스트 가져오기
	public List<exhVO> getExhList(@Param("cri") Criteria cri, String searchEs);  
	public int getExhTotal(String searchEs);
	// 검색어 포함 회원 페이징 처리 
	// 회원 리스트 가져오기
	public List<signInVO> getMList(Criteria cri, String searchMs);
	public int getMTotal(String searchMs);
	
	// 특정 팝업스토어 조회
	public popStoreVO getPopStoreById (int psNo);  
	// 특정 상품(굿즈) 조회
	public goodsVO getGoodsById (int gno);  
	// 특정 전시회 조회
	public exhVO getExhById (int exhNo); 
	// 특정 회원 조회
	public signInVO getMembersById (String userId); 
	
	// 팝업스토어 등록하기
	public int insertPopStore(popStoreVO pvo); 
	
	// 팝업스토어 수정하기
	public int updatePopStore(popStoreVO pvo);
	public pImgVO getPsImg(int psNo);
	public pCatVO getPsCat(int psNo);
	
	// 팝업스토어 삭제하기
	public int deletePopStore(int psNo);
	
	// 상품(굿즈) 등록하기 
	// selectbox 모든 팝업스토어 가져오기
	public List<popStoreVO> getAllPopStores();	
	// 상품(굿즈) insert
	public int insertGoodsStore(goodsVO gvo);
	
	// 상품(굿즈) 수정하기
	public int updateGoodsStore(goodsVO gvo);
	// 배너 이미지와 상세 이미지 가져오기
    public gImgVO getGImgBanner(int gno);
    public gImgVO getGImgDetail(int gno);
    // 카테고리 가져오기
    public gCatVO getGCat(int gno);
    
    // 상품(굿즈) 삭제하기
    public int deleteGoodsStore(int gno);
	
	// 전시회 등록하기
	public int insertExhibition(exhVO evo);
	
	// 전시회 수정하기
	public int updateExhibition(exhVO evo);
	// 배너 이미지와 상세 이미지 가져오기
    public exhImgVO getExhImgBanner(int exhNo);
    public exhImgVO getExhImgDetail(int exhNo);
	
    // 전시회 삭제하기
    public int deleteExhibition(int exhNo);
    
	// 문의 리스트 확인 페이지 영역
	// 문의 리스트 가져오기	
	public List<qnaVO> getQnaListByType(String qnaType, String qnaAnswer);	

	// 회원 정보 수정 페이지 영역
	// 회원 정보 업데이트
	public int updateMem(signInVO svo); 
	

}