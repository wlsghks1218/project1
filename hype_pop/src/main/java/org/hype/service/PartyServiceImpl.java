package org.hype.service;

import java.util.ArrayList;
import java.util.List;

import org.hype.domain.ChatContentVO;
import org.hype.domain.ChatRoomVO;
import org.hype.domain.PartyBoardVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.signInVO;
import org.hype.mapper.PartyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PartyServiceImpl implements PartyService {
	
	@Autowired
	public PartyMapper mapper;
	
	@Override
	public List<popStoreVO> getPopupName(String searchText) {
		return mapper.getPopupName(searchText);
	}
	
	@Transactional
	@Override
	public int insertParty(PartyBoardVO vo) {
		mapper.insertParty(vo);
		int bno = vo.getBno();
		log.warn(bno);
		int userNo = vo.getUserNo();
		log.warn(userNo);
		return mapper.insertChatRoom(bno, userNo); 
	}
	
	@Override
	public List<PartyBoardVO> getAllParty() {
		return mapper.getAllParty();
	}
	
	@Override
	public PartyBoardVO getOneParty(int bno) {
		return mapper.getOneParty(bno);
	}
	
	@Override
	public int insertChatContent(ChatContentVO vo) {
		log.warn(vo.getBno());
		log.warn(vo.getChatDate());
		log.warn(vo.getContent());
		log.warn(vo.getUserId());
		log.warn(vo.getUserNo());
		return mapper.insertChatContent(vo);
	}
	
	@Override
	public int chkJoined(int bno, int userNo) {
		return mapper.chkJoined(bno, userNo);
	}
	
	@Override
	public int joinParty(int bno, int userNo) {
		return mapper.insertChatRoom(bno, userNo);
	}
	
	@Override
	public int updateJoinTime(int bno, int userNo) {
		return mapper.updateJoinTime(bno, userNo);
	}
	
	@Override
	public List<signInVO> getPartyUser(int bno) {
		List<ChatRoomVO> voList = mapper.getPartyUser(bno);
		List<signInVO> userList = new ArrayList<>();
		for(ChatRoomVO vo : voList) {
			signInVO user = mapper.getUserInfo(vo.getUserNo());
			userList.add(user);
		}
		return userList;
	}
	
	@Override
	public List<ChatContentVO> getAllChatContent(int bno) {
		return mapper.getAllChatContent(bno);
	}
	
	@Override
	public List<ChatRoomVO> getPartyInfo(int bno) {
		return mapper.getPartyUser(bno);
	}
	
}
