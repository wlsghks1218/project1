package org.hype.service;

import java.util.List;
import java.util.Map;

import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.mCatVO;
import org.hype.domain.popStoreVO;

public interface GoodsService {
	public List<goodsVO> getGList();  //          ǰ     Ʈ         
	public List<goodsVO> getListBySearchGs(String searchGs);  //         ˻       ߰ 
	public goodsVO getGoodsById (int gNo);  // Ư       (  ǰ)   ȸ
	
	
	
	
	//   ȯ              κ 
	public List<goodsVO> getAllSearchList(String searchText);
	public List<goodsVO> getAllGoodsList();
	public List<goodsVO> getListByLikeCount();
	public Map<String, Object> getListByInterestOneNotLogin();
	public Map<String, Object> getListByInterestTwoNotLogin();
	public Map<String, Object> getListByInterestThreeNotLogin();
	public List<goodsVO> getListByInterestOneLogined(String category);
	public List<goodsVO> getListByInterestTwoLogined(String category);
	public List<goodsVO> getListByInterestThreeLogined(String category);
	public goodsVO getOneByGno(int gno);
	public gCatVO getCategory(int gno);
	public int getUpdatehit(goodsVO vo);
	public int updateLike(int userNo, int gno);
	public int getLikeCount(int gno);
	public int getLikeChk(int userNo, int gno);
	public List<String> getUserInfo(int userNo);
	public gImgVO getImgByGno(int gno);
	public gImgVO getGoodsDetailImg(int gno);
	public List<popStoreVO> getAllStore();
	public String goodsToPopup(int gno);

}