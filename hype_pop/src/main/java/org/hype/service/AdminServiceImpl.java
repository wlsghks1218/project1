package org.hype.service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import org.hype.domain.Criteria;
import org.hype.domain.goodsVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.qnaVO;
import org.hype.domain.signInVO;
import org.hype.mapper.AdminMapper;
import org.hype.mapper.AttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	public AdminMapper mapper;
	
	@Autowired
	public AttachMapper amapper;
	
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
	
	// 문의 영역
	// 문의 리스트 가져오기
	@Override
	public List<qnaVO> getQList() {
		return mapper.getQList();
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
		
	@Override
   public int updateMem(signInVO svo) {
      return mapper.updateMem(svo);
   }   

}