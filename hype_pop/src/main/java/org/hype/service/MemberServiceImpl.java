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
      public int joinMember(signInVO svo) {
         log.warn("joinMember 호출: " + svo);

         membermapper.joinMember(svo);
         log.warn("회원가입 후 userNo: " + svo.getUserNo());

         // userNo가 null인지 확인
         if (svo.getUserNo() == 0) {
            throw new RuntimeException("회원가입 후 userNo를 가져오지 못했습니다.");
         }

         svo.getUserInterest().setUserNo(svo.getUserNo());
         
         // 관심사 삽입
         return membermapper.insertInterest(svo.getUserInterest());
      }
       
       //아이디 중복 확인
       @Override
       public boolean checkDuplicateId(String userId) {
           return membermapper.checkDuplicateId(userId) > 0; // userId 직접 전달
       }

       @Override
       public signInVO selectMyPageInfo(int userNo) {
          return membermapper.selectMyPageInfo(userNo);
       }
       @Override
       public mCatVO selectMyInterest(int userNo) {
          return membermapper.selectMyInterest(userNo);
       }
       @Override
       public int selectOldPw(int userNo, String oldPw) {
          return membermapper.selectOldPw(userNo, oldPw);
       }
       @Override
       public int updateNewPw( String oldPw,String newPw,int userNo) {
          return membermapper.updateNewPw(oldPw, newPw,userNo);
       }
       
       @Override
       public int updateNewEmail( String newEmail,int userNo) {
          return membermapper.updateNewEmail(newEmail,userNo);
       }
       @Override
       public int selectOldPhoneNum(int userNo, String oldPhoneNumber) {
          return membermapper.selectOldPhoneNum(userNo, oldPhoneNumber);
       }
       @Override
      public int updateNewPhoneNum(@Param("oldPhoneNumber") String oldPhoneNumber,@Param("newPhoneNumber") String newPhoneNumber,@Param("userNo") int userNo) {
         return membermapper.updateNewPhoneNum(oldPhoneNumber,newPhoneNumber,userNo);
      }
       @Override
      public List<likedPopImgVO> pLikeList(@Param("userNo") int userNo){
         return membermapper.pLikeList(userNo);
      }
      @Override
      public List<likedGoodsImgVO> gLikeList(@Param("userNo") int userNo){
         return membermapper.gLikeList(userNo);
      }
      @Override
      public int pLikeListDelete(@Param("userNo") int userNo,@Param("psNo") int psNo) {
         return membermapper.pLikeListDelete(userNo, psNo);
      }
      @Override
      public int gLikeListDelete(@Param("userNo") int userNo,@Param("gno") int gno){
         return membermapper.gLikeListDelete(userNo, gno);
      }
      
      
      //관심사 삽입
      @Transactional
      @Override
       public int changeUserInterest(@Param("userNo") int userNo,mCatVO mcvo) {
         
         
         membermapper.deleteUserInterest(userNo);
      
           
         // 관심사 삽입
          return membermapper.changeUserInterest(mcvo);
          
         
       }
      
      
      //아이디 찾기 이메일 존재 여부 확인
      @Override
      public boolean checkEmail(signInVO svo) {
         return membermapper.checkEmail(svo) > 0; 
      }
      
      //찾은 아이디 조회
      @Override
      public String checkMyId(String userName, String userEmail) {
         return membermapper.checkMyId(userName,userEmail);
      }
      
      //아이디 존재 여부 확인
      @Override
      public int searchId(String userId) {
         return membermapper.selectId(userId);
      }
      
      
      //비밀번호 찾기에서 이메일 전송 
      @Override
      public boolean checkEmailPw(signInVO svo) {
         return membermapper.checkEmailPw(svo) > 0; 
      }
      

}


   

       
   
