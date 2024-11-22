package org.hype.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
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

    // 愿��ъ�ъ�� �곕Ⅸ ���� �ㅽ���� 議고��
    public Map<String, List<popStoreVO>> getTopStoresByInterests(int userno) {
        List<String> interests = mapper.getUserInterests(userno);
        Map<String, List<popStoreVO>> results = new HashMap<>();

        if (interests != null && !interests.isEmpty()) {
            for (String interest : interests) {
                List<popStoreVO> topStores = mapper.getTopStoresByInterest(interest);
                results.put(interest, topStores); // 愿��ъ�ъ�� 愿��⑤�� ���� �ㅽ���� 紐⑸��� Map�� 異�媛�
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
        // 醫����� 紐⑸����� ���� �ъ�⑹���� 醫����� ���� ����
        Map<String, Integer> params = new HashMap<>();
        params.put("psNo", psNo);
        params.put("userNo", userNo);
        
        int likeStatus = mapper.checkLikeStatus(params);
        
        if (likeStatus == 0) {
            // 醫�����媛� ���� 寃쎌��, ���� �ㅽ���댁�� 醫����� �� 利�媛�
            mapper.incrementLikeCount(psNo); // 醫����� �� 1 利�媛�
            
            // 醫����� 紐⑸��� ��濡��� 醫����� 湲곕� 異�媛�
            likeVO newLike = new likeVO();
            newLike.setPsNo(psNo);
            newLike.setUserNo(userNo);
            mapper.insertLike(newLike); // ��濡��� 醫����� 異�媛�
            
            return newLike; // ��濡��� 醫����� ��蹂� 諛���
        } else {
            // 醫�����媛� �대�� ���� 寃쎌��, ���� �ㅽ���댁�� 醫����� �� 媛���
            mapper.decrementLikeCount(psNo); // 醫����� �� 1 媛���
            
            // 醫����� 紐⑸����� �대�� 湲곕� ����
            likeVO likeInfo = new likeVO();
            likeInfo.setPsNo(psNo);
            likeInfo.setUserNo(userNo);
            mapper.deleteLike(likeInfo); // 醫����� ����
            
            return null; // ������ 寃쎌�� null 諛���
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
@Override
public String getStoreNameByPsNo(int referenceNo) {
	String result = mapper.getStoreNameByPsNo(referenceNo);
	return result;
}

// �대�� �����ㅽ���댁�� 援우� ��蹂대�� 諛����ㅺ린
@Transactional
@Override
public List<goodsVO> getGoodsInfoByName(String storeName) {
	
	int psNo = mapper.getPsNo(storeName);
	
	System.out.println("psNo: " + psNo); 
	
	List<goodsVO> result = mapper.getGoodsInfoByName(psNo);
	System.out.println("議고���� ���� ��: " + result.size());
	
	for (goodsVO goods : result) {
	    System.out.println("����紐�: " + goods.getGname() + ", 媛�寃�: " + goods.getGprice());
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
    // 荑쇰━ 寃곌낵媛� �대�� ��洹��� 諛�����誘�濡�, 諛�濡� 由ы��
    return mapper.findRatingsByPsNo(psNo); // 荑쇰━���� �대�� ��洹��� 怨��고��
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

// �����닿굅 蹂��� 遺�遺�
@Override
	public List<popStoreVO> showCalendar() {
	    return mapper.showCalendar();
	}

@Override
	public List<pCatVO> getCategoryData() {
		
		return mapper.getCategoryData();
	}
	// 愿��ъ�� 媛��몄�ㅺ린
	@Override
	public List<mCatVO> getUserInterest(int userNo) {

		return mapper.getUserInterest(userNo);
	}

	// 醫����� �� �����ㅽ���� 媛��몄�ㅺ린
	@Override
	public List<likeVO> getUserLike(int userNo) {

		return mapper.getUserLike(userNo);
	} 
	@Transactional
	@Override
	public Map<String, List<popStoreVO>> getTopCategoriesByLikes() {
		   List<String> interests = mapper.getTopInterestsByLikes();
	        Map<String, List<popStoreVO>> results = new HashMap<>();

	        if (interests != null && !interests.isEmpty()) {
	            for (String interest : interests) {
	            	  System.out.println("받아온 관심사 : " + interest);
	                List<popStoreVO> topStores = mapper.getTopStoresByInterest(interest);
	                results.put(interest, topStores); // 愿��ъ�ъ�� 愿��⑤�� ���� �ㅽ���� 紐⑸��� Map�� 異�媛�
	            }
	        }
	        return results;
	}
	
	@Override
	public pImgVO getImageByStoreId(int psNo) {
		  return mapper.getImageByStoreId(psNo);
	}
@Override
public double getAvgRating(int psNo) {
	double result = mapper.getAvgRating(psNo);
	
	return result;
}
@Override
public boolean checkUserLiked(int psNo, int userNo) {
    // Map�� �ъ�⑺���� ���쇰�명�� ����
    Map<String, Object> params = new HashMap<>();
    params.put("userNo", userNo);  // ���щ�� userNo瑜� Map�� 異�媛�
    params.put("psNo", psNo);      // ���щ�� psNo瑜� Map�� 異�媛�
    
    // 留ㅽ�� 硫����� �몄�
    int result = mapper.checkUserLiked(params);
    System.out.println("荑쇰━ 寃곌낵 result: " + result);  // 荑쇰━ 寃곌낵 ����
    
    // result媛� 0蹂대�� �щ㈃ true, ����硫� false 諛���
    return result > 0;
}
//캘린더에 필요한 이미지 가져오기
	@Override
	public List<pImgVO> getPopImg(int psNo) {
		
		return mapper.getPopImg(psNo);
	} 
}
