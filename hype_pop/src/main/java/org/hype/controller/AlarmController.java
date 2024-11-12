package org.hype.controller;

import java.util.ArrayList;
import java.util.List;

import org.hype.domain.NotificationVO;
import org.hype.domain.exhVO;
import org.hype.domain.goodsVO;
import org.hype.domain.noticeVO;
import org.hype.domain.qnaVO;
import org.hype.service.ExhibitionService;
import org.hype.service.GoodsService;
import org.hype.service.NoticeService;
import org.hype.service.NotificationService;
import org.hype.service.PopUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
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
    
    @Autowired
    private ExhibitionService exhService;
    
    @Autowired 
    private GoodsService gService;
    
    @Autowired
    private NoticeService nService;


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
            case "markNotificationsAsRead":
                handleMarkNotificationsAsRead(session, request.getUserNo());
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
                        String storeName = popService.getStoreNameByPsNo(notification.getReferenceNo());
                        notification.setPsName(storeName); // storeName만 설정
                        break;
                    case "exhNo": exhVO exh = exhService.getExhibitionByNo(notification.getReferenceNo());
                        notification.setPsName(exh.getExhName());
                        break;
                    case "gNo": goodsVO gvo = gService.getOneByGno(notification.getReferenceNo());
                        notification.setGoodsName(gvo.getGname());
                        break;
                    case "noticeNo": noticeVO nvo = nService.getNoticeInfo(notification.getReferenceNo());
                        notification.setNoticeTitle(nvo.getNoticeTitle());
                        break;
                    case "qNo": qnaVO qvo = nService.getInquiryInfo(notification.getReferenceNo());
                        log.warn("문의 제목은 "+qvo.getQnaTitle());
                        notification.setQnaTitle(qvo.getQnaTitle());
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

    // 알림을 읽음 상태로 업데이트하는 메서드 추가
    private void handleMarkNotificationsAsRead(WebSocketSession session, int userNo) throws Exception {
        // 사용자의 모든 알림을 읽음 상태로 업데이트
        boolean isUpdated = service.updateNotificationReadStatus(userNo);

        // 업데이트가 성공했는지 여부에 따라 응답 메시지 설정
        String responseMessage = isUpdated ? "알림 읽음 상태 업데이트 성공" : "알림 읽음 상태 업데이트 실패";

        // 업데이트 후 알림 목록을 다시 가져오기
        List<NotificationVO> notifications = service.getAlarmsForUser(userNo);

        // 응답 메시지를 생성 및 전송
        String response = objectMapper.writeValueAsString(
            NotificationResponse.createWithAction("markNotificationsAsRead", notifications, responseMessage)
        );
        session.sendMessage(new TextMessage(response)); // 응답 메시지 전송
    }

    // 모든 클라이언트에게 새 알림 전송
    private void notifyAllUsers(NotificationVO notification) throws Exception {
        String notificationMessage = objectMapper.writeValueAsString(
            NotificationResponse.createWithAction("newNotification", List.of(notification), null)
        );

        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                session.sendMessage(new TextMessage(notificationMessage));
            }
        }
    }

    // 유저가 좋아요한 팝업스토어에 대해 알림을 자동으로 생성
    @Scheduled(cron = "0 0 0 * * *") // 매일 자정 실행
    public void sendDailyNotifications() {
        List<NotificationVO> notifications = new ArrayList<>();

        // 로그인한 유저에 대해 처리
        // 예시로 userNo는 이미 로그인된 유저의 값이라고 가정
        int userNo = 5;

        // 해당 유저가 좋아요한 스토어 ID 목록 가져오기
        List<Integer> likedStoreIds = service.getLikedPopUpStoresByUser(userNo); // 해당 유저가 좋아요한 스토어들의 ID

        // 각 스토어의 정보를 가져와서 알림을 생성
        for (int psNo : likedStoreIds) {

            // 유저에게 보낼 알림 생성
            NotificationVO notification = createNotificationForUser(psNo , userNo);
            //notifications.add(notification);

            try {
                // 해당 유저에게 알림 보내기
                notifySpecificUser(notification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
        }
    }

    // 알림을 생성하는 메서드 (스토어 정보를 기반으로)
    private NotificationVO createNotificationForUser(int psNo, int userNo) {
        NotificationVO notification = new NotificationVO();
        // 알림에 필요한 정보 설정 (예: 좋아요한 팝업스토어 정보)
        notification.setType("psNo");
        notification.setReferenceNo(psNo);
        notification.setTitle("좋아요한");
        notification.setMessage("의 종료일이 5일남았습니다");
        notification.setUserNo(userNo); 
        service.insertPopUpNotification(notification);
        return notification;
        
    }

    // 특정 유저에게 알림을 전송하는 메서드 추가
    private void notifySpecificUser(NotificationVO notification, int userNo) throws Exception {
        for (WebSocketSession session : sessions) {
            if (session.isOpen() && session.getAttributes().get("userNo").equals(userNo)) {
                String notificationMessage = objectMapper.writeValueAsString(
                    NotificationResponse.createWithAction("newNotification", List.of(notification), null)
                );
                session.sendMessage(new TextMessage(notificationMessage)); // 해당 유저에게 알림 전송
            }
        }
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
