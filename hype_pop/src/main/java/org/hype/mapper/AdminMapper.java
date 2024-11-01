package org.hype.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.Criteria;
import org.hype.domain.goodsVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;

public interface AdminMapper {
	// 페이징O
	public List<popStoreVO> getPList(@Param("cri") Criteria cri, @Param("searchPs") String searchPs); // 관리자 popup 리스트 가져오기
	public int getPTotal(String searchPs);
	public List<goodsVO> getGList(@Param("cri") Criteria cri, @Param("searchGs") String searchGs);  // 관리자 상품 리스트 가져오기 
	public int getGTotal(String searchGs);
	public List<signInVO> getMList(@Param("cri") Criteria cri, @Param("searchMs") String searchMs);  // 관리자 회원 리스트 가져오기
	public int getMTotal(String searchMs);
	public List<qnaVO> getQList();  // 관리자 회원 리스트 가져오기
	
	public popStoreVO getPopStoreById (int psNo);  // 특정 팝업스토어 조회
	public goodsVO getGoodsById (int gNo);  // 특정 굿즈(상품) 조회
	public signInVO getMembersById (String userId);  // 특정 회원 조회
	public int updateMem(signInVO svo); 
}