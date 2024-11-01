package org.hype.service;

import java.util.List;

import org.hype.domain.Criteria;
import org.hype.domain.goodsVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.springframework.stereotype.Service;

@Service
public interface AdminService {	
	// 검색어 포함 팝업스토어 페이징 처리 
	public List<popStoreVO> getPList(Criteria cri, String searchPs);	
	public int getPTotal(String searchPs);
	// 검색어 포함 굿즈 페이징 처리 
	public List<goodsVO> getGList(Criteria cri, String searchGs);  // 관리자 상품 리스트 가져오기
	public int getGTotal(String searchGs);
	// 검색어 포함 회원 페이징 처리 
	public List<signInVO> getMList(Criteria cri, String searchMs);  // 관리자 회원 리스트 가져오기
	public int getMTotal(String searchMs);
	// 검색어 포함 문의 페이징 처리
	public List<qnaVO> getQList(); // 페이징X
//	public List<qnaVO> getQList(Criteria cri, String searchQs);  // 페이징O
	
    public popStoreVO getPopStoreById (int psNo);  // 특정 팝업스토어 조회
	public goodsVO getGoodsById (int gNo);  // 특정 굿즈(상품) 조회
	public signInVO getMembersById (String userId);  // 특정 회원 조회
	public int updateMem(signInVO svo); 
}