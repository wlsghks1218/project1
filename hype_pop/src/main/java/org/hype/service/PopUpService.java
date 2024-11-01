package org.hype.service;

import java.util.List;
import java.util.Map;

import org.hype.domain.goodsVO;
import org.hype.domain.likeVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.psReplyVO;

public interface PopUpService {
	// 인기많은 친구 8개 가져오기
    public List<popStoreVO> getPopularPopUps();
    //유저가 고른 관심사 별 상위 8개
    public Map<String, List<popStoreVO>> getTopStoresByInterests(int userno);
    //이름으로 스토어 정보 가져오기
    public popStoreVO getStoreInfoByName(String storeName);
    //좋아요 수 증가 로직
    public likeVO likeCount(int psNo, int userNo);
    //좋아요 수 가져오기
	public Integer getLikeCount(int psNo);
	// 유저가 좋아요 했는지 안했는지 확인
	public boolean checkUserLike(int psNo, int userNo);
	
	// 팝업스토어 이름으로 굿즈 정보 받아오기
	public List<goodsVO> getGoodsInfoByName(String storeName);
	
	// 검색내용으로 팝업스토어 검색하기
	public List<popStoreVO> popUpSearchByData(String searchData);
	
	// 검색 결과 팝업스토어들의 관심사 가져 오기
	public List<Map<String, Object>> getInterestsByPsNo(int psNo);
    // 평균 평점 가져오는 메서드	
	public double calculateAverageRating(int psNo);
    // 전체 스토어 데이터 조회
	public List<popStoreVO> getAllPopUpData();
	// 1km 이내 스토어 찾기 로직
	public List<popStoreVO> findNearbyStores(double lat, double lng, double radius);
	
	//요셉이 병합부분 
	public List<popStoreVO> showCalendar();

	public List<pCatVO> getCategoryData();
	
	    // 관심사 가져오기
		public List<mCatVO> getUserInterest(int userNo);

		// 좋아요한 팝업스토어 가져오기
		public List<likeVO> getUserLike(int userNo);
}
