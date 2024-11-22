package org.hype.service;

import java.util.List;

import org.hype.domain.ChatContentVO;
import org.hype.domain.ChatRoomVO;
import org.hype.domain.PartyBoardVO;
import org.hype.domain.exhVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.signInVO;

public interface PartyService {
	public List<popStoreVO> getPopupName(String searchText);
	public int insertParty(PartyBoardVO vo);
	public List<PartyBoardVO> getAllParty();
	public PartyBoardVO getOneParty(int bno);
	public int insertChatContent(ChatContentVO vo);
	public int chkJoined(int bno, int userNo);
	public int joinParty(int bno, int userNo);
	public int updateJoinTime(int bno, int userNo);
	public List<signInVO> getPartyUser(int bno);
	public List<ChatContentVO> getAllChatContent(int bno);
	public List<ChatRoomVO> getPartyInfo(int bno);
	public int updateLeftTime(int bno, int userNo);
	public int updatePlusJoin(int bno);
	public int updateLeaveMember(int bno, int userNo);
	public int deleteParty(int bno, int userNo);
	public int chkMaster(int bno, int userNo);
	public int deleteAllPartyMember(int bno);
	public List<exhVO> getExhName(String searchText);
	public exhVO findExhNo(String exhName);
}