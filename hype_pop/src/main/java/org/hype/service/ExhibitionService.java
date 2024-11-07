package org.hype.service;

import java.util.List;

import org.hype.domain.exhLikeVO;
import org.hype.domain.exhReplyVO;
import org.hype.domain.exhVO;
import org.springframework.stereotype.Service;

@Service
public interface ExhibitionService {
	
	public List<exhVO> getExhibitionsByPage(int page, int pageSize);

	public exhVO getExhibitionByNo(int exhNo);

	public void insertLike(exhLikeVO exhLike);

	public void removeExhLike(exhLikeVO exhLikeVO);

	public void saveReview(exhReplyVO exhReplyVO);

	public List<exhReplyVO> getAllReplies();

	public boolean updateReview(exhReplyVO exhReplyVO);

	public boolean deleteComment(int userNo, int exhReplyNo);

	public boolean isLiked(int exhNo, int userNo);

	public int getLikeCount(int exhNo);

}