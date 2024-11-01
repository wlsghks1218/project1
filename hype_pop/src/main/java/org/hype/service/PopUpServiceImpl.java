package org.hype.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;
import org.hype.mapper.AttachMapper;
import org.hype.mapper.PopUpMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PopUpServiceImpl implements PopUpService {
	
	
	@Autowired
	public AttachMapper amapper;
	
    
    @Autowired
    PopUpMapper mapper;

    public List<popStoreVO> getPopularPopUps() {
        return mapper.getPopularPopUps();
    }

    // 관심사에 따른 상위 스토어 조회
    public Map<String, List<popStoreVO>> getTopStoresByInterests(int userno) {
        List<String> interests = mapper.getUserInterests(userno);
        Map<String, List<popStoreVO>> results = new HashMap<>();

        if (interests != null && !interests.isEmpty()) {
            for (String interest : interests) {
                List<popStoreVO> topStores = mapper.getTopStoresByInterest(interest);
                results.put(interest, topStores); // 관심사와 관련된 상위 스토어 목록을 Map에 추가
            }
        }
        return results;
    }
    @Override
    public popStoreVO getStoreInfoByName(String storeName) {
    	
    	popStoreVO result = mapper.getStoreInfoByName(storeName);
    	
    	return result;
    }
    
    @Transactional
    @Override
    public likeVO likeCount(int psNo, int userNo) {
        // 좋아요 목록에서 현재 사용자의 좋아요 상태 확인
        Map<String, Integer> params = new HashMap<>();
        params.put("psNo", psNo);
        params.put("userNo", userNo);
        
        int likeStatus = mapper.checkLikeStatus(params);
        
        if (likeStatus == 0) {
            // 좋아요가 없는 경우, 팝업 스토어의 좋아요 수 증가
            mapper.incrementLikeCount(psNo); // 좋아요 수 1 증가
            
            // 좋아요 목록에 새로운 좋아요 기록 추가
            likeVO newLike = new likeVO();
            newLike.setPsNo(psNo);
            newLike.setUserNo(userNo);
            mapper.insertLike(newLike); // 새로운 좋아요 추가
            
            return newLike; // 새로운 좋아요 정보 반환
        } else {
            // 좋아요가 이미 있는 경우, 팝업 스토어의 좋아요 수 감소
            mapper.decrementLikeCount(psNo); // 좋아요 수 1 감소
            
            // 좋아요 목록에서 해당 기록 삭제
            likeVO likeInfo = new likeVO();
            likeInfo.setPsNo(psNo);
            likeInfo.setUserNo(userNo);
            mapper.deleteLike(likeInfo); // 좋아요 삭제
            
            return null; // 삭제된 경우 null 반환
        }
    }

@Override
public Integer getLikeCount(int psNo) {
	Integer result = mapper.getLikeCount(psNo);
	
	return result;
}
@Override
public boolean checkUserLike(int psNo, int userNo) {
	 Map<String, Integer> params = new HashMap<>();
     params.put("psNo", psNo);
     params.put("userNo", userNo);
     
     int likeStatus = mapper.checkLikeStatus(params);
     
     if (likeStatus == 1) {
		return true;
	}
     else {
    	 return false;
		
	}
}

// 해당 팝업스토어의 굿즈 정보들 받아오기
@Transactional
@Override
public List<goodsVO> getGoodsInfoByName(String storeName) {
	
	int psNo = mapper.getPsNo(storeName);
	
	System.out.println("psNo: " + psNo); 
	
	List<goodsVO> result = mapper.getGoodsInfoByName(psNo);
	System.out.println("조회된 상품 수: " + result.size());
	
	for (goodsVO goods : result) {
	    System.out.println("상품명: " + goods.getGname() + ", 가격: " + goods.getGprice());
	}
	
	return result;
}
@Override
public List<popStoreVO> popUpSearchByData(String searchData) {
	List<popStoreVO> result = mapper.popUpSearchByData(searchData);
	
	return result;
}
@Override
public List<Map<String, Object>> getInterestsByPsNo(int psNo) {
	List<Map<String, Object>> result = mapper.getInterestsByPsNo(psNo);
	
	return result;
}
@Override
public double calculateAverageRating(int psNo) {
    // 쿼리 결과가 이미 평균을 반환하므로, 바로 리턴
    return mapper.findRatingsByPsNo(psNo); // 쿼리에서 이미 평균을 계산함
}
@Override
public List<popStoreVO> getAllPopUpData() {
	List<popStoreVO> result = mapper.showCalendar();
	return result;
}

@Override
public List<popStoreVO> findNearbyStores(double lat, double lng, double radius) {
    Map<String, Object> params = new HashMap<>();
    params.put("lat", lat);
    params.put("lng", lng);
    params.put("radius", radius);
    
    return mapper.findNearbyStores(params);
}

// 요셉이거 병합 부분
@Override
	public List<popStoreVO> showCalendar() {
	    return mapper.showCalendar();
	}

@Override
	public List<pCatVO> getCategoryData() {
		
		return mapper.getCategoryData();
	}
	// 관심사 가져오기
	@Override
	public List<mCatVO> getUserInterest(int userNo) {

		return mapper.getUserInterest(userNo);
	}

	// 좋아요 한 팝업스토어 가져오기
	@Override
	public List<likeVO> getUserLike(int userNo) {

		return mapper.getUserLike(userNo);
	} 
	
		

}
