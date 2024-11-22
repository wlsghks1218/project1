package org.hype.service;

import java.util.List;

import org.hype.domain.exhImgVO;
import org.hype.domain.exhLikeVO;
import org.hype.domain.exhReplyVO;
import org.hype.domain.exhVO;
import org.springframework.stereotype.Service;

@Service
public interface ExhibitionService {
	
	public List<exhVO> getExhibitionsByPage(int page, int pageSize, String filter, String query);
	
	public exhVO getExhibitionByNo(int exhNo);

	public void insertLike(exhLikeVO exhLike);

	public void removeExhLike(exhLikeVO exhLikeVO);

	public boolean hasUserReviewed(int exhNo, int userNo);
	
	public boolean saveReview(exhReplyVO exhReplyVO);

	public boolean updateReview(exhReplyVO exhReplyVO);

	public boolean deleteComment(int userNo, int exhReplyNo);

	public boolean isLiked(int exhNo, int userNo);

	public int getLikeCount(int exhNo);

	public Double getAverageRating(Integer exhNo);

	public List<exhReplyVO> getUserReviews(int exhNo, int startRow, int endRow);

	public int getTotalReviewCount(int exhNo);

	public List<exhImgVO> getPopularExhs();

	public List<exhImgVO> getExhBannerImg();

	public List<exhImgVO> getExhDetailImg(int exhNo);

	public List<exhImgVO> getExhImg(int exhNo);

}