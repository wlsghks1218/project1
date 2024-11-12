package org.hype.mapper;

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

public interface AdminMapper {
	// 페이징O
	// 관리자 팝업스토어 리스트 가져오기
	public List<popStoreVO> getPList(@Param("cri") Criteria cri, @Param("searchPs") String searchPs); 
	public int getPTotal(String searchPs);
	
	// 관리자 상품 리스트 가져오기 
	public List<goodsVO> getGList(@Param("cri") Criteria cri, @Param("searchGs") String searchGs);  
	public int getGTotal(String searchGs);
	
	// 관리자 회원 리스트 가져오기
	public List<signInVO> getMList(@Param("cri") Criteria cri, @Param("searchMs") String searchMs);  
	public int getMTotal(String searchMs);
	
	// 특정 팝업스토어 조회
	public popStoreVO getPopStoreById (int psNo);
	// 특정 굿즈(상품) 조회
	public goodsVO getGoodsById (int gNo);  
	// 특정 회원 조회
	public signInVO getMembersById (String userId);  
	
	// 팝업스토어 등록하기
	public int insertPopStore(popStoreVO pvo);
	public int insertPsImage(pImgVO imgVo);  // 이미지 등록
	public int insertPsCat(pCatVO cvo);  // 카테고리 등록
	
	// 팝업스토어 수정하기
//	public int updatePopStores(popStoreVO pvo);
	
	// 굿즈 등록하기
	public List<popStoreVO> getAllPopStores();	  // select box 모든 팝업스토어 출력
	public int insertGoodsStore(goodsVO gvo);
	public int insertBannerImage(gImgVO gImgVo);  // 배너 이미지 등록
	public int insertDetailImage(gImgVO gImgVo);  // 상세 이미지 등록
	public int insertGcat(gCatVO gvo); 			  // 카테고리 등록
	
	// 전시회 등록하기
	public int insertExhibition(exhVO evo);
	public int insertExhBannerImage(exhImgVO exhImgVo);  // 배너 이미지 등록
	public int insertExhDetailImage(exhImgVO exhImgVo);  // 상세 이미지 등록
	
	
	// 관리자 문의 리스트 가져오기	
	public List<qnaVO> getQnaListByType(@Param("qnaType") String qnaType, @Param("qnaAnswer") String qnaAnswer); 	
//	public List<qnaVO> getQList(@Param("cri") Criteria cri, @Param("qnaType") String qnaType);  // 페이징O
//	public int getQTotal(String qnaType);
	
	// 상품 상태 조회 리스트 가져오기
//	public int updatePurchaseList(payVO pvo);  
	public List<payVO> getPurchaseList(); 	
	
	// 회원 정보 업데이트
	public int updateMem(signInVO svo); 
	
}