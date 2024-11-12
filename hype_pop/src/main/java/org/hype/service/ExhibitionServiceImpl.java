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
	public List<exhVO> getExhibitionsByPage(int page, int pageSize, String filter) {
	    int offset = (page - 1) * pageSize;
	    
	    switch (filter) {
	        case "latest":
	            // 최신 전시회 기준으로 가져오는 쿼리
	            return exhibitionmapper.getLatestExhibitions(offset, pageSize);	            
	        case "dueSoon":
	            return exhibitionmapper.getDueSoonExhibitions(offset, pageSize);	        
	        case "lowerPrice":
	            return exhibitionmapper.getExhibitionsOrderByPrice("ASC", offset, pageSize);	        
	        case "higherPrice":
	            return exhibitionmapper.getExhibitionsOrderByPrice("DESC", offset, pageSize);	        
	        case "earlyBird":
	            return exhibitionmapper.getEarlyBirdExhibitions(offset, pageSize);
	        default:
	            return exhibitionmapper.getExhibitionsByPage(offset, pageSize);
	    }
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
	public boolean hasUserReviewed(int exhNo, int userNo) {

		return exhibitionmapper.countReviewsByUser(exhNo, userNo) > 0;
	}
	
	@Override
	public boolean saveReview(exhReplyVO exhReplyVO) {
		int result = exhibitionmapper.insertReply(exhReplyVO);
		return result > 0;
	}

	@Override
	public List<exhReplyVO> getAllReplies(int exhNo) {
		
		return exhibitionmapper.getAllReplies(exhNo);
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