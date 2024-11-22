package org.hype.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hype.domain.ChatContentVO;
import org.hype.domain.ChatRoomVO;
import org.hype.domain.PartyBoardVO;
import org.hype.domain.exhVO;
import org.hype.domain.popStoreVO;
import org.hype.domain.signInVO;
import org.hype.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/party/*")
public class PartyController {
   
   @Autowired
   private PartyService service;
   
   @GetMapping("/partyBoard")
   public String goPartyBoard(Model model) {
      List<PartyBoardVO> pvo = service.getAllParty();
      log.warn("aaaaaaa" + pvo);
      model.addAttribute("voList", pvo);
      return "/party/partyBoard";
   }
   
   @GetMapping(value= "/getAllParty", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public List<PartyBoardVO> getAllParty(){
      return service.getAllParty();
   }
   
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
   @GetMapping("/boardInsert")
   public String goInsertBoard(Model model) {
      return "/party/insertBoard";
   }
   
   @GetMapping(value = "/search", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public Object search(@RequestParam String searchText, @RequestParam String category) {
       if("popup".equals(category)) {
          return service.getPopupName(searchText);
       }
       return service.getExhName(searchText);
   }
   
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
   @PostMapping(value = "/insertBoard")
   public String insertBoard(PartyBoardVO vo) {
      int result = service.insertParty(vo);
      log.warn("result 는 : " + result);
      return "redirect:/party/partyBoard";
   }
   
   @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
   @GetMapping("/boardDetail")
   public String moveToDetail(@RequestParam int bno, Model model) {
      PartyBoardVO mvo = service.getOneParty(bno);
      model.addAttribute("vo", mvo);
      return "/party/boardDetail";
   }
   
   @Transactional
   @GetMapping(value = "/chkJoined/{bno}/{userNo}", produces = "text/plain;charset=UTF-8")
   @ResponseBody
   public String chkJoined(@PathVariable("bno") int bno, @PathVariable("userNo") int userNo) {
      log.warn("bno는 " + bno);
      log.warn("userNo는 " + userNo);
       int result = service.chkJoined(bno, userNo);
       log.warn(result);
       if (result == 0) {
          int resultInsert = service.joinParty(bno, userNo);
           return "채팅방에 진입했습니다.";
       } else {
          int resultUpdate = service.updateJoinTime(bno, userNo);
           return "채팅방에 이미 있는 유저입니다.";
       }
   }
   
   @GetMapping(value = "/getPartyUser/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public List<signInVO> getPartyUser(@PathVariable("bno") int bno){
      List<signInVO> vo = service.getPartyUser(bno);
      return vo;
   }
   
   @GetMapping(value = "/getAllChatContent/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public List<ChatContentVO> getAllChatContent(@PathVariable int bno) {
       List<ChatContentVO> chatContents = service.getAllChatContent(bno);
       return chatContents;
   }
   
   @GetMapping(value = "/getPartyInfo/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public List<ChatRoomVO> getPartyInfo(@PathVariable int bno){
      List<ChatRoomVO> voList = service.getPartyInfo(bno);
      for(ChatRoomVO vo : voList) {
         log.info(vo.getJoinTime());
         log.info(vo.getLastJoinTime());
      }
      return voList;
   }
   
   @GetMapping(value = "/updateLeftTime/{bno}/{userNo}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public int updateLeftTime(@PathVariable("bno") int bno, @PathVariable("userNo") int userNo) {
      log.warn("updateLeftTime에서" + bno + userNo);
      int result = service.updateLeftTime(bno, userNo);
      return result;
   }
   
   @GetMapping(value="/leaveParty")
   public String leaveParty(@RequestParam("bno") int bno, @RequestParam("userNo") int userNo, @RequestParam("isMaster") int isMaster) {
      log.warn("이거 타는거에여?"+bno+userNo+isMaster);
      if(isMaster == 0) {
         int result1 = service.updateLeaveMember(bno, userNo);
         return "redirect:/party/partyBoard";
      }else {
         int result2 = service.deleteAllPartyMember(bno);
         int result3 = service.deleteParty(bno, userNo);
         return "redirect:/party/partyBoard";
      }
   }
   
   @GetMapping(value="/chkJoinedOrNot/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public List<ChatRoomVO> chkJoinedOrNot(@PathVariable("bno") int bno){
      return service.getPartyInfo(bno);
   }
   
   @GetMapping(value="/partyUserCount/{bno}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public PartyBoardVO partyUserCount(@PathVariable("bno") int bno) {
      return service.getOneParty(bno);
   }
   
   @GetMapping(value="/chkMaster/{bno}/{userNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public String chkMaster(@PathVariable("bno") int bno, @PathVariable("userNo") int userNo) {
      int result = service.chkMaster(bno, userNo);
      return Integer.toString(result);
   }
   
   @GetMapping(value="/findExhNo/{psExhName}", produces = MediaType.APPLICATION_JSON_VALUE)
   @ResponseBody
   public exhVO findExhNo(@PathVariable("psExhName") String psExhName) {
      return service.findExhNo(psExhName);
   }
}

