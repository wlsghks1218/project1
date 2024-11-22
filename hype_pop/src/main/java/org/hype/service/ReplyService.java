package org.hype.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.Criteria;
import org.hype.domain.psReplyVO;

public interface ReplyService {
	public Integer insertPopUpReply(psReplyVO vo);

	public List<psReplyVO> getUserReviews(int psNo, int userNo);

	public boolean hasUserReviewed(int psNo, int userNo);

	public boolean deleteReview(int reviewId);

	public Integer updateReply(psReplyVO vo);

	public List<psReplyVO> getOtherReviews(Integer psNo, Integer userNo, Criteria cri);

	public List<psReplyVO> getAllReviews(Integer psNo, Criteria cri);

	public int getTotalReviews(Integer psNo, Integer userNo);

	public int getAllReviewcount(Integer psNo);

	// 윤씨 추가 부분

	public List<psReplyVO> getPopupRepliesWithPaging(int userNo, int pageNum, int amount);

	public String getPsName(int psNo);

	public int getTotalPopupReplyCount(@Param("userNo") int userNo);

}
