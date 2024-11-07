package org.hype.mapper;

import java.util.List;
import java.util.Map; // 추가된 import
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;

public interface PopUpMapper {
   public List<popStoreVO> getPopularPopUps();

   public List<String> getUserInterests(int userno);

   public List<popStoreVO> getTopStoresByInterest(@Param("value") String interest);
    
   public popStoreVO getStoreInfoByName(String storeName);

   int checkLikeStatus(Map<String, Integer> params);
   
   public String getStoreNameByPsNo(int referenceNo);
   // 좋아요 추가
   public void insertLike(likeVO newLike);
   
   // 좋아요 수 증가
   public void incrementLikeCount(int psNo);
   
   // 좋아요 수 감소
   public void decrementLikeCount(int psNo);
   
   // 좋아요 삭제
   public void deleteLike(likeVO likeInfo);

   public Integer getLikeCount(int psNo);

   public int getPsNo(String storeName);
   
   public List<goodsVO> getGoodsInfoByName(int psNo);
   
   public List<popStoreVO> popUpSearchByData(String searchData);

   public List<Map<String, Object>> getInterestsByPsNo(int psNo);
   // 평균 평점 가져오기   
   public double findRatingsByPsNo(int psNo);


   public List<popStoreVO> findNearbyStores(Map<String, Object> params);

   
   
   // 요셉이거 통합 부분
   public List<popStoreVO> showCalendar();

   public List<pCatVO> getCategoryData();
   
// 유저 번호로 관심사 가져오기
	public List<mCatVO> getUserInterest(int userNo);

	// 유저 번호로 좋아요 누른 팝업스토어 가져오기
	public List<likeVO> getUserLike(int userNo);











}
