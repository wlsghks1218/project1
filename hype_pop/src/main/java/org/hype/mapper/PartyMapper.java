package org.hype.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.ChatContentVO;
import org.hype.domain.ChatRoomVO;
import org.hype.domain.PartyBoardVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.signInVO;

public interface PartyMapper {
	public List<popStoreVO> getPopupName(String searchText);
	public int insertParty(PartyBoardVO vo);
	public List<PartyBoardVO> getAllParty();
	public PartyBoardVO getOneParty(int bno);
	public int insertChatContent(ChatContentVO vo);
	public int insertChatRoom(@Param("bno") int bno, @Param("userNo") int userNo);
	public int chkJoined(@Param("bno") int bno,@Param("userNo") int userNo);
	public int updateJoinTime(@Param("bno") int bno, @Param("userNo") int userNo);
	public List<ChatRoomVO> getPartyUser(int bno);
	public signInVO getUserInfo(int userNo);
	public List<ChatContentVO> getAllChatContent(int bno);
}
