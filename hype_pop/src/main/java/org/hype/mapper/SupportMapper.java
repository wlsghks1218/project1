package org.hype.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.noticeVO;
import org.hype.domain.qnaVO;

public interface SupportMapper {
   public List<noticeVO> getNoticesWithPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);

   public List<qnaVO> getInquiriesWithPaging(@Param("startRow") int startRow, @Param("endRow") int endRow, @Param("userNo") int userNo);

   
   public boolean insertNotice(noticeVO notice);

   public noticeVO getNoticeInfo(int noticeNo);

   public int updateNotice(noticeVO nvo);

   public int deleteNotice(int noticeNo);

   public boolean insertQna(qnaVO qna);

   public qnaVO getInquiryInfo(int qnaNo);

   public int updateAnswer(qnaVO qvo);

   public int deleteInquiry(int qnaNo);

   public int getTotalNoticeCount();

   public int getTotalInquiryCount(int userNo);
   
   //추가
   public List<qnaVO> getUserInquiriesWithPaging(@Param("userNo") int userNo, @Param("startRow") int startRow, @Param("endRow") int endRow);

   public int getTotalInquiryCountByUser(@Param("userNo") int userNo);


   

}