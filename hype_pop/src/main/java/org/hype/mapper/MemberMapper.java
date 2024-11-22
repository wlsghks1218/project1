package org.hype.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.likeVO;
import org.hype.domain.likedExhViewVO;
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
	
	public List<likedExhViewVO> eLikeList(@Param("userNo") int userNo);
	
	public int pLikeListDelete(@Param("userNo") int userNo,@Param("psNo") int psNo);
	
	public int gLikeListDelete(@Param("userNo") int userNo,@Param("gno") int gno);
	
	public int eLikeListDelete(@Param("userNo") int userNo,@Param("gno") int exhNo);
	
	public int deleteUserInterest(@Param("userNo") int userNo);
	
	public int changeUserInterest(mCatVO mcvo);
	
	public int checkEmail(signInVO svo);
	
	public String checkMyId(@Param("userName") String userName ,@Param("userEmail") String userEmail);
	
	public int selectId(String userId);
	
	public int checkEmailPw(signInVO svo);
	
	// 회원 정보 테이블에서 삭제
    public int deleteSignInInfo(int userNo);

    // 회원 관심 카테고리 테이블에서 삭제
    public int deleteMemberCategory(int userNo);

    // 팝업스토어 댓글 테이블에서 삭제
    public int deletePopReply(int userNo);

    // 팝업스토어 좋아요 테이블에서 삭제
    public int deleteLikeList(int userNo);

    // 굿즈 정보 댓글 테이블에서 삭제
    public int deleteGoodsReply(int userNo);

    // 굿즈 좋아요 리스트 테이블에서 삭제
    public int deleteGoodsLikeList(int userNo);

    // 장바구니 테이블에서 삭제
    public int deleteCart(int userNo);

    // 결제 내역 테이블에서 삭제
    public int deletePayment(int userNo);

    // Q&A 테이블에서 삭제
    public int deleteQna(int userNo);

    // 파티 정보 테이블에서 삭제
    public int deletePartyInfo(int userNo);

    // 채팅 참여 테이블에서 삭제
    public int deleteChat(int userNo);

    // 채팅 내용 테이블에서 삭제
    public int deleteChatContent(int userNo);

    // 전시 댓글 테이블에서 삭제
    public int deleteExhReply(int userNo);

    // 전시 좋아요 리스트 테이블에서 삭제
    public int deleteExhLikeList(int userNo);
		

}