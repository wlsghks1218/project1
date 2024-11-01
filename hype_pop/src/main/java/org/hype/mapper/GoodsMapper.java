package org.hype.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gCatVO;
import org.hype.domain.gImgVO;
import org.hype.domain.goodsVO;
import org.hype.domain.mCatVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.rankVO;

public interface GoodsMapper {
	public List<goodsVO> getGList();  //          ǰ     Ʈ         
	public List<goodsVO> getListBySearchGs(String searchGs);  //         ˻       ߰ 
	public goodsVO getGoodsById (int gNo);  // Ư       (  ǰ)   ȸ
	
	
	//  ȯ              κ 
	public List<goodsVO> getListByLikeCount();
	public List<rankVO> getCategoryRankNotLogin();
	public List<goodsVO> getListByInterest(Map<String, String> map);
	public goodsVO getOneByGno(int gno);
	public List<goodsVO> getAllSearchList(String SearchText);
	public List<goodsVO> getAllGoodsList();
	public gCatVO getCategory(int gno);
	public int getUpdatehit(goodsVO vo);
	public int getLike(@Param("userNo") int userNo,@Param("gno") int gno);
	public int insertLike(@Param("userNo") int userNo,@Param("gno") int gno);
	public int deleteLike(@Param("userNo") int userNo,@Param("gno") int gno);
	public int updateLikeCountPlus(@Param("gno") int gno);
	public int updatetLikeCountMinus(@Param("gno") int gno);
	public int getLikeCount(@Param("gno") int gno);
	public mCatVO getUserInfo(int userNo);
	public gImgVO getImgByGno(int gno);
	public gImgVO getGoodsDetailImg(int gno);
	public List<popStoreVO> getAllStore();
	public goodsVO getPsnoByGno(int gno);
	public popStoreVO getStoreName(int psNo);
}