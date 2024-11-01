package org.hype.service;

import java.util.List;

import org.hype.domain.ChatContentVO;
import org.hype.domain.PartyBoardVO;
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
}
