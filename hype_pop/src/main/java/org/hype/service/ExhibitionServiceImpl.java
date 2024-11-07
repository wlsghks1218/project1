package org.hype.service;

import java.util.Date;
import java.util.List;

import org.hype.domain.exhLikeVO;
import org.hype.domain.exhReplyVO;
import org.hype.domain.exhVO;
import org.hype.mapper.ExhibitionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExhibitionServiceImpl implements ExhibitionService {

	@Autowired
	public ExhibitionMapper exhibitionmapper;
	
	@Override
	public List<exhVO> getExhibitionsByPage(int page, int pageSize) {
	    int offset = (page - 1) * pageSize;
	    return exhibitionmapper.getExhibitionsByPage(offset, pageSize);
	}

	@Override
	public exhVO getExhibitionByNo(int exhNo) {
		
		return exhibitionmapper.getExhibitionByNo(exhNo);
	}

	@Override
	public void insertLike(exhLikeVO exhLike) {

		exhibitionmapper.insertLike(exhLike);
	}

	@Override
	public void removeExhLike(exhLikeVO exhLikeVO) {
		
		exhibitionmapper.deleteLike(exhLikeVO);
	}

	@Override
	public void saveReview(exhReplyVO exhReplyVO) {
		exhibitionmapper.insertReply(exhReplyVO);
	}

	@Override
	public List<exhReplyVO> getAllReplies() {
		
		return exhibitionmapper.getAllReplies();
	}

	@Override
	public boolean updateReview(exhReplyVO exhReplyVO) {
		int result = exhibitionmapper.updateReview(exhReplyVO);
        return result > 0;
	}

	@Override
	public boolean deleteComment(int userNo, int exhReplyNo) {
        return exhibitionmapper.deleteComment(userNo, exhReplyNo) > 0; 
    }

	@Override
	public boolean isLiked(int exhNo, int userNo) {
		Integer likeCount = exhibitionmapper.isLiked(exhNo, userNo);
	    return (likeCount != null && likeCount > 0); // null 체크와 비교
	}

	@Override
	public int getLikeCount(int exhNo) {

		return exhibitionmapper.getLikeCount(exhNo);
	}

}