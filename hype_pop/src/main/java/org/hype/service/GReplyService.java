package org.hype.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.gReplyVO;

public interface GReplyService {
	public int insertGReply(gReplyVO gVo);
	public List<gReplyVO> getAllReplyList(@Param("gno") int gno,@Param("userNo") int userNo);
	public gReplyVO getMyReply(@Param("gno") int gno,@Param("userNo") int userNo);
	public double getAvgStars(int gno);
	public String chkReplied(@Param("userNo") int userNo, @Param("gno") int gno);
	public int deleteReply(int gno, int userNo);
	public int updateReply(gReplyVO vo);
	public List<gReplyVO> getAllReplyListWithPaging(@Param("gno") int gno, @Param("userNo") int userNo, @Param("offset") int offset, @Param("size") int size);
	public int getReplyCount(@Param("gno") int gno,@Param("userNo") int userNo);
	
	// 윤씨 추가 부분 
	public String getGName(int gno) ;
	
	public int getTotalUserReplyCount(@Param("userNo") int userNo);
	
	public List<gReplyVO> getUserRepliesWithPaging(int userNo, int pageNum, int amount);

}