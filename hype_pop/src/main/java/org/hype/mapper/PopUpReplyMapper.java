package org.hype.mapper;

import java.util.List;
import java.util.Map;

import org.hype.domain.psReplyVO;

public interface PopUpReplyMapper {
     public Integer insertPopUpReply(psReplyVO vo);

	public List<psReplyVO> getUserReviews(Map<String, Integer> params);

	public int countUserReviews(Map<String, Integer> params);

	public String getUserIdByUserNo(int userNo);

	public int deleteReviewById(int reviewId);

	public Integer updateReply(psReplyVO vo);

	public List<psReplyVO> getOtherReviews(Map<String, Integer> params);

	public int getTotalReviews(Map<String, Integer> params);
	
	
	// 윤씨 추가 된 부분
	
	
	// 유저의 댓글을 가져오는 메서드
    public List<psReplyVO> getMyPopupReviews(int userNo);
		
	// psNo로 psName을 가져오는 메서드
	public String getPsName(int psNo);
}
