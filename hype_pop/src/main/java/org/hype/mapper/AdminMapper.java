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
	
	// 관리자 전시회 리스트 가져오기
	public List<exhVO> getExhList(@Param("cri") Criteria cri, @Param("searchEs") String searchEs);  
	public int getExhTotal(String searchEs);
	
	// 관리자 회원 리스트 가져오기
	public List<signInVO> getMList(@Param("cri") Criteria cri, @Param("searchMs") String searchMs);  
	public int getMTotal(String searchMs);
	
	// 특정 팝업스토어 조회
	public popStoreVO getPopStoreById (int psNo);
	// 특정 굿즈(상품) 조회
	public goodsVO getGoodsById (int gno);  
//	public goodsVO getGoodsById (int gNo);  
	// 특정 전시회 조회
	public exhVO getExhById (int exhNo); 
	// 특정 회원 조회
	public signInVO getMembersById (String userId);  
	
	// 팝업스토어 등록하기
	public int insertPopStore(popStoreVO pvo);
	public int insertPsImage(pImgVO imgVo);  // 이미지 등록
	public int insertPsCat(pCatVO cvo);  // 카테고리 등록
	
	// 팝업스토어 수정하기
	public pImgVO getPsImg(int psNo);
	public pCatVO getPsCat(int psNo);
	public int updatePopStore(popStoreVO pvo);
	public int updatePsImage(pImgVO imgVo);
	public int updatePsCat(pCatVO cvo);
	
	// 팝업스토어 삭제하기
	public int deletePopStore(int psNo);
	public int deletePsImage(int psNo);
	public int deletePsCat(int psNo);
	public int deletePsReply(int psNo);
	public int deletePsLike(int psNo);
	public List<goodsVO> getPsnoList(int psNo); // 팝업스토어 삭제 위한 mapper 생성
	
	// 상품(굿즈) 등록하기
	public List<popStoreVO> getAllPopStores();	  // select box 모든 팝업스토어 출력
	public int insertGoodsStore(goodsVO gvo);
	public int insertBannerImage(gImgVO gImgVo);  // 배너 이미지 등록
	public int insertDetailImage(gImgVO gImgVo);  // 상세 이미지 등록
	public int insertGcat(gCatVO gvo); 			  // 카테고리 등록
	
	// 상품(굿즈) 수정하기
	public gImgVO getGImgBanner(int gno);
	public gImgVO getGImgDetail(int gno);
	public gCatVO getGCat(int gno);
	public int updateGoodsStore(goodsVO gvo);
	public int updateGImgBanner(gImgVO gImgVo);	  // 배너 이미지 수정
    public int updateGImgDetail(gImgVO gImgVo);   // 상세 이미지 수정
    public int updateGCat(gCatVO gcatVo);
    
    // 상품(굿즈) 삭제하기
    public int deleteGoodsStore(int gno);
    public int deleteGImgBanner(int gno);
    public int deleteGImgDetail(int gno);
    public int deleteGCat(int gno);
    public int deleteGCart(int gno);
    public int deleteGPay(int gno);
    public int deleteGLike(int gno);
    public int deleteGReply(int gno);
    
	// 전시회 등록하기
	public int insertExhibition(exhVO evo);
	public int insertExhBannerImage(exhImgVO exhImgVo);  // 배너 이미지 등록
	public int insertExhDetailImage(exhImgVO exhImgVo);  // 상세 이미지 등록
	
	// 전시회 수정하기
	public exhImgVO getExhImgBanner(int exhNo);
    public exhImgVO getExhImgDetail(int exhNo);
	public int updateExhibition(exhVO evo);
	public int updateExhBannerImage(exhImgVO exhImgVo);  // 배너 이미지 수정
	public int updateExhDetailImage(exhImgVO exhImgVo);  // 상세 이미지 수정
	
	// 전시회 삭제하기
	public int deleteExhibition(int exhNo);
    public int deleteExhImgBanner(int exhNo);
    public int deleteExhImgDetail(int exhNo);
    public int deleteExhLike(int exhNo);
    public int deleteExhReply(int exhNo);
    
	// 관리자 문의 리스트 가져오기	
	public List<qnaVO> getQnaListByType(@Param("qnaType") String qnaType, @Param("qnaAnswer") String qnaAnswer); 	
//	public List<qnaVO> getQList(@Param("cri") Criteria cri, @Param("qnaType") String qnaType);  // 페이징O
//	public int getQTotal(String qnaType);
	
	// 회원 정보 업데이트
	public int updateMem(signInVO svo); 
	
}