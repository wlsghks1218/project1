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
        log.info("전달된 qnaNo: " + request.getQnaNo()); // qnaNo 값 로깅

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
            case "sendInqueryNotification":
                sendInqueryNotification(request.getQnaNo()); // qnaNo로 알림 전송
                break;
            case "sendNoticeNotification":
                sendNoticeNotifications(request.getNoticeNo()); // 새로운 액션에 대한 처리
                break;
            default:
                log.warn("알 수 없는 액션: " + request.getAction());
                break;
        }
    
    }

    private void handleCheckNotifications(WebSocketSession session, int userNo) throws Exception {
        // 사용자 ID로 알림 목록 조회
        List<NotificationVO> notifications = service.getAlarmsForUser(userNo);
        
        System.out.println("여기까지 오기는 오냐? : " + notifications);
        
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
    
    // 공지사항 알림
    public void sendNoticeNotifications(int noticeNo) {
        
        List<Integer> allUserNos = service.getAllUserNos(); // 전체 사용자 목록 가져오기

        for (int userNo : allUserNos) {                     
            NotificationVO noticeNotification = createNoticeNotification(noticeNo, userNo);
            try {
                notifySpecificUser(noticeNotification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
        }
    }
    
    public void sendInqueryNotification(int qnaNo) {
    	
    	log.warn("알람 컨트롤러의 qno는 : " + qnaNo);
    	
    	int userNo = service.getUserNoByQnaNo(qnaNo);
    	
    	log.warn("알람의 유저넘버는 : " + userNo);
       
    	// 특정 1대1 문의에 대한 알림 생성
        NotificationVO qnaNotification = createQnaNotification(qnaNo, userNo);
        try {
            // 해당 유저에게 알림 보내기
            notifySpecificUser(qnaNotification, userNo);
        } catch (Exception e) {
            log.error("알림 전송 중 오류 발생: ", e);
        }
    }
    

    @Scheduled(cron = "0 0 0 * * *") // 매일 자정 실행
    public void sendDailyNotifications() {
        List<NotificationVO> notifications = new ArrayList<>();

        // 로그인한 유저에 대해 처리
        int userNo = 5;

        // 해당 유저가 좋아요한 스토어 ID 목록 가져오기
        List<Integer> endStoreIds = service.getLikedPopUpStoresByUser(userNo);
        
        List<Integer> startStoreIds = service.getLikedStartPopUpStoresByUser(userNo);

        // 각 스토어의 정보를 가져와서 알림을 생성
        for (int psNo : endStoreIds) {
            // 종료일 5일 전 알림 생성
            NotificationVO endNotification = createNotificationForUser(psNo, userNo, "end");
            // 시작일 5일 전 알림 생성

      
            try {
                // 해당 유저에게 알림 보내기
                notifySpecificUser(endNotification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
        }
        
        for ( int psNo : startStoreIds) {
        	 NotificationVO startNotification = createNotificationForUser(psNo, userNo, "start");

             try {
                 // 해당 유저에게 알림 보내기
                 notifySpecificUser(startNotification, userNo);
             } catch (Exception e) {
                 log.error("알림 전송 중 오류 발생: ", e);
             }
		}

        // 굿즈에 대해서도 알림 생성
        List<Integer> goodsIds = service.getLikedGoodsByUserNo(userNo);
        for (int gNo : goodsIds) {
            // 굿즈 종료 5일 전 알림 생성
            NotificationVO goodsEndNotification = createGoodsNotification(gNo, userNo);
            try {
                // 해당 유저에게 알림 보내기
                notifySpecificUser(goodsEndNotification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
        }

        // 전시회에 대한 알림 생성
        List<Integer> endExhIds = service.getLikedEndExhByUserNo(userNo);
        for (int exhNo : endExhIds) {
            // 전시회 종료 5일 전 알림 생성
            NotificationVO exhEndNotification = createExhibitionNotification(exhNo, userNo, "end");

            try {
                // 해당 유저에게 알림 보내기
                notifySpecificUser(exhEndNotification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
        }
        List<Integer> startExhIds = service.getLikedStartExhByUserNo(userNo);
        for ( int exhNo : startExhIds) {
       	 NotificationVO exhStartNotification = createExhibitionNotification(exhNo, userNo, "start");

            try {
                // 해당 유저에게 알림 보내기
                notifySpecificUser(exhStartNotification, userNo);
            } catch (Exception e) {
                log.error("알림 전송 중 오류 발생: ", e);
            }
		}
    }

    // 팝업스토어 종료일 및 시작일 알림 생성
    private NotificationVO createNotificationForUser(int psNo, int userNo, String type) {
        NotificationVO notification = new NotificationVO();
        if ("end".equals(type)) {
            notification.setType("psNo");
            notification.setReferenceNo(psNo);
            notification.setTitle("좋아요한");
            notification.setMessage("의 종료일이 5일 남았습니다");
        } else if ("start".equals(type)) {
            notification.setType("psNo");
            notification.setReferenceNo(psNo);
            notification.setTitle("좋아요한");
            notification.setMessage("의 시작일이 5일 남았습니다");
        }
        notification.setUserNo(userNo);
        service.insertPopUpNotification(notification);
        return notification;
    }

    // 굿즈 종료일 알림 생성
    private NotificationVO createGoodsNotification(int gNo, int userNo) {
        NotificationVO notification = new NotificationVO();
        notification.setType("gNo");
        notification.setReferenceNo(gNo);
        notification.setTitle("좋아요한");
        notification.setMessage("굿즈의 판매 종료일이 5일 남았습니다");
        notification.setUserNo(userNo);
        service.insertPopUpNotification(notification);
        return notification;
    }

    // 전시회 종료일 및 시작일 알림 생성
    private NotificationVO createExhibitionNotification(int exhNo, int userNo, String type) {
        NotificationVO notification = new NotificationVO();
        if ("end".equals(type)) {
            notification.setType("exhNo");
            notification.setReferenceNo(exhNo);
            notification.setTitle("좋아요한");
            notification.setMessage("전시회 종료일이 5일 남았습니다");
        } else if ("start".equals(type)) {
            notification.setType("exhNo");
            notification.setReferenceNo(exhNo);
            notification.setTitle("좋아요한");
            notification.setMessage("전시회 시작일이 5일 남았습니다");
        }
        notification.setUserNo(userNo);
        service.insertPopUpNotification(notification);
        return notification;
    }

    // 공지사항 알림 생성
    private NotificationVO createNoticeNotification(int noticeNo, int userNo) {
        NotificationVO notification = new NotificationVO();
        notification.setType("noticeNo");
        notification.setReferenceNo(noticeNo);
        notification.setTitle("새로운 공지사항 등록!");
        notification.setMessage("확인해보세요!");
        notification.setUserNo(userNo);
        service.insertPopUpNotification(notification);
        return notification;
    }

    // 1대1 문의 답변 알림 생성
    private NotificationVO createQnaNotification(int qNo, int userNo) {
        NotificationVO notification = new NotificationVO();
        notification.setType("qNo");
        notification.setReferenceNo(qNo);
        notification.setTitle("답변이 도착했습니다!");
        notification.setMessage("의 답변을 확인해보세요!");
        notification.setUserNo(userNo);
        service.insertPopUpNotification(notification);
        return notification;
    }


    private void notifySpecificUser(NotificationVO notification, int userNo) throws Exception {
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                // session.getAttributes()에서 userNo를 안전하게 가져오고 null 체크
                Object sessionUserNoObj = session.getAttributes().get("userNo");
                if (sessionUserNoObj != null && sessionUserNoObj instanceof Integer) {
                    int sessionUserNo = (Integer) sessionUserNoObj;
                    // userNo와 비교
                    if (sessionUserNo == userNo) {
                        String notificationMessage = objectMapper.writeValueAsString(
                            NotificationResponse.createWithAction("newNotification", List.of(notification), null)
                        );
                        session.sendMessage(new TextMessage(notificationMessage)); // 해당 유저에게 알림 전송
                    }
                } else {
                    log.warn("세션에서 userNo를 찾을 수 없거나 타입이 일치하지 않습니다.");
                }
            }
        }
    }


    private static class NotificationRequest {
        private String action;
        private int userNo;
        private int notificationNo; // 삭제할 알림 ID 추가
        private int qnaNo; // 문의 ID 추가
        private int noticeNo; // 공지 ID 추가 (새롭게 추가된 필드)

        // 기존 getter, setter
        public String getAction() { return action; }
        public void setAction(String action) { this.action = action; }
        public int getUserNo() { return userNo; }
        public void setUserNo(int userNo) { this.userNo = userNo; }
        public int getNotificationNo() { return notificationNo; }
        public void setNotificationNo(int notificationNo) { this.notificationNo = notificationNo; }
        public int getQnaNo() { return qnaNo; }  // qnaNo getter
        public void setQnaNo(int qnaNo) { this.qnaNo = qnaNo; }  // qnaNo setter
        
        // 추가된 noticeNo에 대한 getter, setter
        public int getNoticeNo() {
            return noticeNo;
        }

        public void setNoticeNo(int noticeNo) {
            this.noticeNo = noticeNo;
        }
    }

    // 응답 메시지를 담는 내부 클래스
    private static class NotificationResponse {
        private String action;
        private List<NotificationVO> notifications;
        private String message;

        private NotificationResponse(String action, List<NotificationVO> notifications, String message) {
            this.action = action;
            this.notifications = notifications;
            this.message = message;
        }

        // 생성 메서드
        public static NotificationResponse createWithAction(String action, List<NotificationVO> notifications, String message) {
            return new NotificationResponse(action, notifications, message);
        }

        // getter, setter
        public String getAction() { return action; }
        public void setAction(String action) { this.action = action; }
        public List<NotificationVO> getNotifications() { return notifications; }
        public void setNotifications(List<NotificationVO> notifications) { this.notifications = notifications; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }

}
