package org.hype.service;

import java.util.List;
import java.util.Map;

import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;

public interface PopUpService {
	// �멸린留��� 移�援� 8媛� 媛��몄�ㅺ린
    public List<popStoreVO> getPopularPopUps();
    
    // ��泥� 愿��ъ�� 以� 醫����� ��媛� 媛��� 留��� ���� 3媛��� 移댄��怨�由щ�� ������怨� 3媛��� 移댄��怨�由щ� 媛�媛� 8媛��� �ㅽ���대�� 媛��몄�� 
    public Map<String, List<popStoreVO>> getTopCategoriesByLikes();
    //����媛� 怨�瑜� 愿��ъ�� 蹂� ���� 8媛�
    public Map<String, List<popStoreVO>> getTopStoresByInterests(int userno);
    //�대��쇰� �ㅽ���� ��蹂� 媛��몄�ㅺ린
    public popStoreVO getStoreInfoByName(String storeName);
    //醫����� �� 利�媛� 濡�吏�
    public likeVO likeCount(int psNo, int userNo);
    //醫����� �� 媛��몄�ㅺ린
	public Integer getLikeCount(int psNo);
	// ����媛� 醫����� ����吏� ������吏� ����
	public boolean checkUserLike(int psNo, int userNo);
	// �����ㅽ���� �대��쇰� 援우� ��蹂� 諛����ㅺ린
	public List<goodsVO> getGoodsInfoByName(String storeName);
	
	public String getStoreNameByPsNo(int referenceNo);
	// 寃����댁�⑹�쇰� �����ㅽ���� 寃�����湲�
	public List<popStoreVO> popUpSearchByData(String searchData);
	
	// 寃��� 寃곌낵 �����ㅽ���대�ㅼ�� 愿��ъ�� 媛��� �ㅺ린
	public List<Map<String, Object>> getInterestsByPsNo(int psNo);
    // ��洹� ���� 媛��몄�ㅻ�� 硫�����	
	public double calculateAverageRating(int psNo);
    // ��泥� �ㅽ���� �곗�댄�� 議고��
	public List<popStoreVO> getAllPopUpData();
	// 1km �대�� �ㅽ���� 李얘린 濡�吏�
	public List<popStoreVO> findNearbyStores(double lat, double lng, double radius);
	
	public pImgVO getImageByStoreId(int psNo);
	
	public double getAvgRating(int psNo);
	
	// 愿��ъ�� 媛��몄�ㅺ린
	public List<mCatVO> getUserInterest(int userNo);
	
	// 醫������� �����ㅽ���� 媛��몄�ㅺ린
	public List<likeVO> getUserLike(int userNo);
	
	public boolean checkUserLiked(int psNo, int userNo);
	//������ 蹂��⑸�遺� 
	public List<popStoreVO> showCalendar();

	public List<pCatVO> getCategoryData();
	


	public List<pImgVO> getPopImg(int psNo);
}
