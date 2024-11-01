package org.hype.service;

import java.util.List;
import java.util.Map;

import org.hype.domain.Criteria;
import org.hype.domain.psReplyVO;

public interface ReplyService {
	public Integer insertPopUpReply(psReplyVO vo);
	public List<psReplyVO> getUserReviews(int psNo, int userNo);
	public boolean hasUserReviewed(int psNo, int userNo);
	public boolean deleteReview(int reviewId);
	public Integer updateReply(psReplyVO vo);
	public List<psReplyVO> getOtherReviews(Integer psNo, Integer userNo, Criteria cri);
	public int getTotalReviews(Integer psNo, Integer userNo);


	// 윤씨 추가 부분
    public Map<String, Object> getMyPopupReviews(int userNo);

}
