package org.hype.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gLikeVO;
import org.hype.domain.likeVO;
import org.hype.domain.likedGoodsImgVO;
import org.hype.domain.likedPopImgVO;
import org.hype.domain.mCatVO;
import org.hype.domain.signInVO;






public interface MemberMapper {
	
	public signInVO loginMember(signInVO svo);

	
	public int joinMember(signInVO svo);
	
	public int insertInterest(mCatVO mcvo);
	
	public int checkDuplicateId(String userId);
	
	public signInVO selectMyPageInfo(int userNo);
	
	public mCatVO selectMyInterest(int userNo);
	
	public  int selectOldPw(@Param("userNo") int userNo, @Param("oldPw") String oldPw);
	
	public int updateNewPw(@Param("oldPw") String oldPw,@Param("newPw") String newPw,@Param("userNo") int userNo);

	public int updateNewEmail(@Param("newEmail") String newEmail,@Param("userNo") int userNo);
	
	public  int selectOldPhoneNum(@Param("userNo") int userNo, @Param("oldPhoneNumber") String oldPhoneNumber);

	public int updateNewPhoneNum(@Param("oldPhoneNumber") String oldPhoneNumber,@Param("newPhoneNumber") String newPhoneNumber,@Param("userNo") int userNo);
	
	public List<likedPopImgVO> pLikeList(@Param("userNo") int userNo);
	
	public List<likedGoodsImgVO> gLikeList(@Param("userNo") int userNo);
	
	public int pLikeListDelete(@Param("userNo") int userNo,@Param("psNo") int psNo);
	
	public int gLikeListDelete(@Param("userNo") int userNo,@Param("gno") int gno);
	
	public int deleteUserInterest(@Param("userNo") int userNo);
	
	public int changeUserInterest(mCatVO mcvo);
	
}