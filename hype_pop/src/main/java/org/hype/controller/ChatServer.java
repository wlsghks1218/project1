package org.hype.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.hype.domain.ChatContentVO;
import org.hype.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.log4j.Log4j;

@Log4j
@ServerEndpoint("/chatserver.do")
public class ChatServer {

    // bno별로 세션을 관리하는 맵
    private static Map<String, List<Session>> bnoSessionMap = new ConcurrentHashMap<>();

    @Autowired
    private PartyService service;

    private Gson gson = new GsonBuilder().setDateFormat("yyyy. MM. dd HH:mm:ss").create();

    @OnOpen
    public void handleOpen(Session session) {
        if (service == null) {
            WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
            service = context.getBean(PartyService.class);
        }

        String bno = session.getRequestParameterMap().get("bno").get(0);

        // bno에 해당하는 세션 리스트가 없으면 생성하고, 중복되지 않게 세션 추가
        bnoSessionMap.putIfAbsent(bno, new ArrayList<>());
        if (!bnoSessionMap.get(bno).contains(session)) {
            bnoSessionMap.get(bno).add(session);
        }

        log.info("Session connected: " + session.getId() + " for bno: " + bno);
        checkSessionList(bno);
    }

    @OnMessage
    public void handleMessage(String msg, Session session) {
        try {
            ChatContentVO message = gson.fromJson(msg, ChatContentVO.class);
            String bno = message.getBno(); // 메시지에서 bno 추출

            if (message.getCode().equals("3")) { // 메시지 전송
                log.info("Message received for bno " + bno + ": " + message);
                service.insertChatContent(message); // DB에 메시지 저장
            }

            // bno에 해당하는 세션에만 메시지 전송
            List<Session> sessions = bnoSessionMap.get(bno);
            if (sessions != null) {
                for (Session s : sessions) {
                    if (s.isOpen() && s != session) {  // 자신에게는 다시 전송하지 않음
                        s.getBasicRemote().sendText(msg);
                    }
                }
            }

        } catch (Exception e) {
            log.error("Message handling error", e);
        }
    }

    @OnClose
    public void handleClose(Session session) {
        // 모든 bno 목록에서 해당 세션을 제거
        for (String bno : bnoSessionMap.keySet()) {
            bnoSessionMap.get(bno).remove(session);
        }
        log.info("Session closed: " + session.getId());
    }

    private void checkSessionList(String bno) {
        System.out.println();
        System.out.println("[Session List for bno: " + bno + "]");
        List<Session> sessions = bnoSessionMap.get(bno);
        if (sessions != null) {
            for (Session session : sessions) {
                System.out.println(session.getId());
            }
        }
        System.out.println();
    }
}
