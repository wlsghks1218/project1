package org.hype.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.noticeVO;
import org.hype.domain.qnaVO;
import org.springframework.stereotype.Service;

@Service
public interface NoticeService {
   public List<noticeVO> getNoticesWithPaging(int pageNum, int amount);
   
   public int getTotalNoticeCount();

   public List<qnaVO> getInquiriesWithPaging(int pageNum, int amount, int userNo);

   public int getTotalInquiryCount(int userNo);
   
   public boolean createNotice(noticeVO notice);

   public noticeVO getNoticeInfo(int noticeNo);

   public int updateNotice(noticeVO nvo);
   
   public int deleteNotice(int noticeNo);

   public boolean createInquiry(qnaVO qna);

   public qnaVO getInquiryInfo(int qnaNo);

   public int updateAnswer(qnaVO qvo);

   public int deleteInquiry(int qnaNo);
   
   
   //추가
   public List<qnaVO> getUserInquiriesWithPaging(int userNo, int pageNum, int amount);
   
   public int getTotalInquiryCountByUser(@Param("userNo") int userNo);

   public List<qnaVO> replyCheckInquiries(int pageNum, int amount, int userNo, boolean answered);

   public int replyCheckCount(int userNo, boolean answered);

   public Map<String, Integer> getInquiryCounts(int userNo);

   
}