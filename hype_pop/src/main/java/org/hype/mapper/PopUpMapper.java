package org.hype.mapper;

import java.util.List;
import java.util.Map; // 異�媛��� import
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;

public interface PopUpMapper {
   public List<popStoreVO> getPopularPopUps();

   public List<String> getUserInterests(int userno);

   public List<popStoreVO> getTopStoresByInterest(@Param("value") String interest);
    
   public popStoreVO getStoreInfoByName(String storeName);

   int checkLikeStatus(Map<String, Integer> params);
   
   public String getStoreNameByPsNo(int referenceNo);
   // 醫����� 異�媛�
   public void insertLike(likeVO newLike);
   
   // 醫����� �� 利�媛�
   public void incrementLikeCount(int psNo);
   
   // 醫����� �� 媛���
   public void decrementLikeCount(int psNo);
   
   // 醫����� ����
   public void deleteLike(likeVO likeInfo);

   public Integer getLikeCount(int psNo);

   public int getPsNo(String storeName);
   
   public List<goodsVO> getGoodsInfoByName(int psNo);
   
   public List<popStoreVO> popUpSearchByData(String searchData);

   public List<Map<String, Object>> getInterestsByPsNo(int psNo);
   // ��洹� ���� 媛��몄�ㅺ린   
   public double findRatingsByPsNo(int psNo);


   public List<popStoreVO> findNearbyStores(Map<String, Object> params);

   
   
   // �����닿굅 �듯�� 遺�遺�
   public List<popStoreVO> showCalendar();

   public List<pCatVO> getCategoryData();
   
// ���� 踰��몃� 愿��ъ�� 媛��몄�ㅺ린
	public List<mCatVO> getUserInterest(int userNo);

	// ���� 踰��몃� 醫����� ��瑜� �����ㅽ���� 媛��몄�ㅺ린
	public List<likeVO> getUserLike(int userNo);

	public List<String> getTopInterestsByLikes();

	public pImgVO getImageByStoreId(int psNo);

	public double getAvgRating(int psNo);

	int checkUserLiked(Map<String, Object> params);





	public List<pImgVO> getPopImg(@Param("psNo") int psNo);





}
