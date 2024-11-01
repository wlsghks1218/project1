package org.hype.controller;

import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.hype.domain.ChatContentVO;
import org.hype.service.PartyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.log4j.Log4j;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import javax.websocket.OnClose;

@Log4j
@ServerEndpoint("/chatserver/{bno}")
public class ChatServer {

    // 채팅방 ID(bno)를 키로 사용하여 세션 리스트를 매핑
	private static final ConcurrentHashMap<String, CopyOnWriteArrayList<Session>> chatRooms = new ConcurrentHashMap<>();

    @Autowired
    private PartyService service;

    private Gson gson = new GsonBuilder().setDateFormat("yyyy. MM. dd HH:mm:ss").create();

    @OnOpen
    public void handleOpen(Session session, @PathParam("bno") String bno) {
        chatRooms.putIfAbsent(bno, new CopyOnWriteArrayList<>());
        chatRooms.get(bno).add(session);
        log.info("New session opened in chat room " + bno + ": " + session.getId());
        checkSessionList(bno);
        clearSessionList(bno);
    }

    @OnMessage
    public void handleMessage(String msg, Session session, @PathParam("bno") String bno) {
        log.info("Received message in chat room " + bno + " from session " + session.getId() + ": " + msg);

        try {
            if (service == null) {
                WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
                service = context.getBean(PartyService.class);
            }
        	
            ChatContentVO message = gson.fromJson(msg, ChatContentVO.class);
            

            if ("1".equals(message.getCode())) {
                broadcastMessage(msg, session, bno, "User entered the chat room.");
            } else if ("2".equals(message.getCode())) {
                chatRooms.get(bno).remove(session);
                broadcastMessage(msg, session, bno, "User left the chat room.");
            } else if ("3".equals(message.getCode())) {
                int result = service.insertChatContent(message);
                if (result > 0) {
                    log.info("Message saved to DB successfully.");
                }
                broadcastMessage(msg, session, bno, "New chat message broadcasted.");
            }
        } catch (Exception e) {
            log.error("Message handling error", e);
        }
    }

    private void broadcastMessage(String msg, Session senderSession, String bno, String logMessage) {
        for (Session s : chatRooms.get(bno)) {
            if (s.isOpen() && !s.equals(senderSession)) { // senderSession 제외
                try {
                    s.getBasicRemote().sendText(msg);
                    log.info(logMessage + " Sent to session in room " + bno + ": " + s.getId());
                } catch (Exception e) {
                    log.error("Error sending message to session " + s.getId(), e);
                }
            }
        }
    }

    private void checkSessionList(String bno) {
        log.info("[Session List in Room " + bno + "]");
        for (Session session : chatRooms.get(bno)) {
            log.info("Session ID: " + session.getId());
        }
    }

    private void clearSessionList(String bno) {
        chatRooms.get(bno).removeIf(s -> !s.isOpen());
        log.info("Closed sessions removed from room " + bno);
    }

    @OnClose
    public void handleClose(Session session, @PathParam("bno") String bno) {
        chatRooms.get(bno).remove(session);
        log.info("Session closed in room " + bno + ": " + session.getId());
    }
}

