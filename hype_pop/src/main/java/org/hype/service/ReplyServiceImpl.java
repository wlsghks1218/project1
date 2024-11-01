package org.hype.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.Criteria;
import org.hype.domain.psReplyVO;
import org.hype.mapper.PopUpReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	PopUpReplyMapper mapper;
	
	@Transactional
	@Override
	public Integer insertPopUpReply(psReplyVO vo) {
	    // userNo로 userId 조회
	    String userId = mapper.getUserIdByUserNo(vo.getUserNo());
	    
	    // 조회한 userId를 vo에 설정
	    vo.setUserId(userId);
	    
	    // 리뷰 데이터 삽입
	    Integer result = mapper.insertPopUpReply(vo);
	    
	    return result;
	}
	@Override
	public List<psReplyVO> getUserReviews(int psNo, int userNo) {
	    Map<String, Integer> params = new HashMap<>();
	    params.put("psNo", psNo);
	    params.put("userNo", userNo);
	    
	    List<psReplyVO> result = mapper.getUserReviews(params);
	    return result;
	}
	@Override
	public boolean hasUserReviewed(int psNo, int userNo) {
	    // psNo와 userNo를 매개변수로 전달하여 리뷰 개수를 조회
	    Map<String, Integer> params = new HashMap<>();
	    params.put("psNo", psNo);
	    params.put("userNo", userNo);
	    
	    int count = mapper.countUserReviews(params);
	    
	    // 리뷰가 존재하면 true, 아니면 false 반환
	    return count > 0;
	}
	@Override
	public boolean deleteReview(int reviewId) {
	    // reviewId로 리뷰 삭제
	    int rowsAffected = mapper.deleteReviewById(reviewId); // 삭제된 행 수 반환
	    return rowsAffected > 0; // 삭제 성공 여부 반환
	}
	@Override
	public Integer updateReply(psReplyVO vo) {
		  
	    // 댓글 수정
	    Integer result = mapper.updateReply(vo);
	    
	    return result;
	}
	@Override
	public List<psReplyVO> getOtherReviews(Integer psNo, Integer userNo, Criteria cri) {
	    Map<String, Integer> params = new HashMap<>();
	    params.put("psNo", psNo);
	    params.put("userNo", userNo);
	    params.put("pageNum", cri.getPageNum());  // 현재 페이지 번호 추가
	    params.put("amount", cri.getAmount());    // 페이지당 항목 수 추가

	    // Mapper 호출 시 params 맵을 사용
	    List<psReplyVO> result = mapper.getOtherReviews(params);
	    return result;
	}
	@Override
	public int getTotalReviews(Integer psNo, Integer userNo) {
	    Map<String, Integer> params = new HashMap<>();
	    params.put("psNo", psNo);
	    params.put("userNo", userNo);

	    // Mapper 호출 시 params 맵을 사용
	    return mapper.getTotalReviews(params);
	}
	//새로 추가(김윤)
		@Override
		@Transactional
		public Map<String, Object> getMyPopupReviews(int userNo) {
		 
			//내 댓글 리스트
			List<psReplyVO>replies = mapper.getMyPopupReviews(userNo);
			// psName 저장할 리스트
			List<String> psNames = new ArrayList<>();
		    
			// 각 psNo에 대해 psName 가져오기
			 for (psReplyVO reply : replies) {
			        String psName = mapper.getPsName(reply.getPsNo()); 
			        psNames.add(psName);
			    }
			
			
			    Map<String, Object> result = new HashMap<>();
			    result.put("replies", replies);
			    result.put("psNames", psNames);
			    return result; // 결과를 Map 형태로 반환 
		}
}
