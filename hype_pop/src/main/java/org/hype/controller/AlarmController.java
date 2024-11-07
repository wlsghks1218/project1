package org.hype.controller;

import java.util.ArrayList;
import java.util.List;

import org.hype.domain.NotificationVO;
import org.hype.service.NotificationService;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/alarm")
@Log4j
public class AlarmController extends TextWebSocketHandler {

    @Autowired
    private NotificationService service;
    
    @Autowired
    private PopUpService popService;

    private List<WebSocketSession> sessions = new ArrayList<>();
    private ObjectMapper objectMapper = new ObjectMapper(); // JSON 변환용

    // 클라이언트가 웹소켓에 연결되면 세션을 목록에 추가
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        log.info("Socket 연결");
        sessions.add(session);
    }

    // 클라이언트가 메시지를 보낼 때마다 처리
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        String payload = message.getPayload();
        NotificationRequest request = objectMapper.readValue(payload, NotificationRequest.class);
        log.info("유저 넘버는? : " + request.getUserNo());

        switch (request.getAction()) {
            case "checkNotifications":
                handleCheckNotifications(session, request.getUserNo());
                break;
            case "deleteNotifications":
                handleDeleteNotifications(session, request.getUserNo(), request.getNotificationNo());
                break;
            default:
                log.warn("알 수 없는 액션: " + request.getAction());
                break;
        }
    }

    private void handleCheckNotifications(WebSocketSession session, int userNo) throws Exception {
        // 사용자 ID로 알림 목록 조회
        List<NotificationVO> notifications = service.getAlarmsForUser(userNo);
        
        if (notifications == null) {
            notifications = new ArrayList<>(); // 기본값으로 빈 리스트 초기화
        }

        // 각 알림의 type에 따라 다르게 처리
        for (NotificationVO notification : notifications) {
            if (notification != null) {
                String type = notification.getType();
                switch (type) {
                    case "psNo":
                        String psName = popService.getStoreNameByPsNo(notification.getReferenceNo());
                        notification.setPsName(psName); // psName 설정
                        break;
                    case "exhNo":
                    case "gNo":
                    case "noticeNo":
                    case "qNo":
                        log.info("처리 중: " + type + " - " + notification.getReferenceNo());
                        break;
                    default:
                        log.warn("정의되지 않은 타입: " + type);
                        break;
                }
            } else {
                log.warn("null notification을 건너뜁니다.");
            }
        }

        // 응답 메시지 작성 및 전송
        String response = objectMapper.writeValueAsString(
            NotificationResponse.createWithAction("sendNotifications", notifications, null) // action만 사용
        );
        session.sendMessage(new TextMessage(response)); // 응답 메시지를 전송
    }
    private void handleDeleteNotifications(WebSocketSession session, int userNo, int notificationNo) throws Exception {
        boolean isDeleted = service.deleteNotification(notificationNo); // deleteNotification 메서드 호출

        // responseMessage 변수를 정의
        String responseMessage = isDeleted ? "알림 삭제 성공" : "알림 삭제 실패";

        // 사용자 알림 목록 가져오기
        List<NotificationVO> notifications = service.getAlarmsForUser(userNo); 

        // 응답 메시지를 생성할 때 action과 message를 설정
        String response = objectMapper.writeValueAsString(
            NotificationResponse.createWithAction("deleteNotifications", notifications, responseMessage) // message 포함
        );
        session.sendMessage(new TextMessage(response)); // TextMessage로 전송
    }

    // 요청 데이터를 담는 내부 클래스
    private static class NotificationRequest {
        private String action;
        private int userNo;
        private int notificationNo; // 삭제할 알림 ID 추가

        // getter, setter
        public String getAction() { return action; }
        public void setAction(String action) { this.action = action; }
        public int getUserNo() { return userNo; }
        public void setUserNo(int userNo) { this.userNo = userNo; }
        public int getNotificationNo() { return notificationNo; }
        public void setNotificationNo(int notificationNo) { this.notificationNo = notificationNo; }
    }

    // 응답 데이터를 담는 내부 클래스
    public static class NotificationResponse {
        private String action;
        private List<NotificationVO> notifications;
        private String message;

        // private constructor to prevent direct instantiation
        private NotificationResponse(String action, List<NotificationVO> notifications, String message) {
            this.action = action;
            this.notifications = notifications;
            this.message = message;
        }

        // 정적 팩토리 메서드 1: action과 notifications를 받는 메서드
        public static NotificationResponse createWithAction(String action, List<NotificationVO> notifications, String message) {
            return new NotificationResponse(action, notifications, message);
        }
        // 정적 팩토리 메서드 2: message와 notifications를 받는 메서드
        public static NotificationResponse createWithMessage(String message, List<NotificationVO> notifications) {
            return new NotificationResponse(null, notifications, message);
        }

        // getter
        public String getAction() { return action; }
        public List<NotificationVO> getNotifications() { return notifications; }
        public String getMessage() { return message; }
    }
}
