package org.hype.service;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gImgVO;
import org.hype.domain.likeVO;
import org.hype.domain.likedExhViewVO;
import org.hype.domain.likedGoodsImgVO;
import org.hype.domain.likedPopImgVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.signInVO;
import org.springframework.stereotype.Service;




@Service
public interface MemberService {

	
	//db에 저장
	
	public signInVO loginMember(signInVO svo);

	public int joinMember(signInVO svo);
	
	public boolean checkDuplicateId(String userId);
	
	public signInVO selectMyPageInfo(int userNo);
	
	public mCatVO selectMyInterest(int userNo);
	
	public int selectOldPw(int userNo,String oldPw);
	
	public int updateNewPw(String oldPw, String newPw,int userNo);
	
	public int updateNewEmail(String newEmail,int userNo);

    public int selectOldPhoneNum(int userNo, String oldPhoneNumber);
    
	public int updateNewPhoneNum(@Param("oldPhoneNumber") String oldPhoneNumber,@Param("newPhoneNumber") String newPhoneNumber,@Param("userNo") int userNo);

	public List<likedPopImgVO> pLikeList(@Param("userNo") int userNo);
	
	public List<likedGoodsImgVO> gLikeList(@Param("userNo") int userNo);
	
	public List<likedExhViewVO> eLikeList(@Param("userNo") int userNo);
	
	public int pLikeListDelete(@Param("userNo") int userNo,@Param("psNo") int psNo);
	
	public int gLikeListDelete(@Param("userNo") int userNo,@Param("gno") int gno);

	public int eLikeListDelete(@Param("userNo") int userNo,@Param("exhNo") int exhNo);
	
	public int changeUserInterest(@Param("userNo") int userNo,mCatVO mcvo);
	
	public boolean checkEmail(signInVO svo);
	
	public String checkMyId(@Param("userName") String userName,@Param("userEmail") String userEmail );
	
	public int searchId(String userId);
	
	public boolean checkEmailPw(signInVO svo);

	public boolean deleteUserData(int userNo);


	
	
	
	
}