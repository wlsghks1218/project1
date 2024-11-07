package org.hype.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gImgVO;
import org.hype.domain.gLikeVO;
import org.hype.domain.likeVO;
import org.hype.domain.likedGoodsImgVO;
import org.hype.domain.likedPopImgVO;
import org.hype.domain.mCatVO;
import org.hype.domain.pImgVO;
import org.hype.domain.signInVO;
import org.hype.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;


@Log4j
@Service
public class MemberServiceImpl implements MemberService{

	
	
	   @Autowired
	    private MemberMapper membermapper;

	    
	    @Override
	    public signInVO loginMember(signInVO svo) {
	        log.info("login user: {}"+ svo);
	        return membermapper.loginMember(svo);
	    }

	    @Transactional
	    @Override
	    public int joinMember(signInVO svo, mCatVO mcvo) {
	        log.warn("joinMember �몄�: " + svo);

	        membermapper.joinMember(svo);
	        log.warn("����媛��� �� userNo: " + svo.getUserNo());

	        // userNo媛� null�몄� ����
	        if (svo.getUserNo() == 0) {
	            throw new RuntimeException("����媛��� �� userNo瑜� 媛��몄�ㅼ� 紐삵���듬����.");
	        }

	        // 愿��ъ�� �쎌��
	        mcvo.setUserNo(svo.getUserNo());
	        return membermapper.insertInterest(mcvo);
	        

	    }
	    
	    //���대�� 以�蹂� ����
	    public boolean checkDuplicateId(String userId) {
	        return membermapper.checkDuplicateId(userId) > 0; // userId 吏��� ����
	    }

	    
	    public signInVO selectMyPageInfo(int userNo) {
	    	return membermapper.selectMyPageInfo(userNo);
	    }
	    
	    public mCatVO selectMyInterest(int userNo) {
	    	return membermapper.selectMyInterest(userNo);
	    }
	    
	    public int selectOldPw(int userNo, String oldPw) {
	    	return membermapper.selectOldPw(userNo, oldPw);
	    }
	    public int updateNewPw( String oldPw,String newPw,int userNo) {
	       return membermapper.updateNewPw(oldPw, newPw,userNo);
	    }
	    

	    public int updateNewEmail( String newEmail,int userNo) {
	       return membermapper.updateNewEmail(newEmail,userNo);
	    }
	    
	    public int selectOldPhoneNum(int userNo, String oldPhoneNumber) {
	    	return membermapper.selectOldPhoneNum(userNo, oldPhoneNumber);
	    }
	    
		public int updateNewPhoneNum(@Param("oldPhoneNumber") String oldPhoneNumber,@Param("newPhoneNumber") String newPhoneNumber,@Param("userNo") int userNo) {
			return membermapper.updateNewPhoneNum(oldPhoneNumber,newPhoneNumber,userNo);
		}
		
		public List<likedPopImgVO> pLikeList(@Param("userNo") int userNo){
			return membermapper.pLikeList(userNo);
		}
		
		public List<likedGoodsImgVO> gLikeList(@Param("userNo") int userNo){
			return membermapper.gLikeList(userNo);
		}
		
		public int pLikeListDelete(@Param("userNo") int userNo,@Param("psNo") int psNo) {
			return membermapper.pLikeListDelete(userNo, psNo);
		}
		public int gLikeListDelete(@Param("userNo") int userNo,@Param("gno") int gno){
			return membermapper.gLikeListDelete(userNo, gno);
		}
		
		@Transactional
		@Override
	    public int changeUserInterest(@Param("userNo") int userNo,mCatVO mcvo) {
			
			
			membermapper.deleteUserInterest(userNo);
		
			  
			// 愿��ъ�� �쎌��
		    return membermapper.changeUserInterest(mcvo);
			
	    }
		
		
		

}


	

	    
	