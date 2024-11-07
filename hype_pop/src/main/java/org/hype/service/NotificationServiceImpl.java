package org.hype.service;

import java.util.List;

import org.hype.domain.NotificationVO;
import org.hype.mapper.NotificationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class NotificationServiceImpl implements NotificationService {

	 
	    @Autowired
	    private NotificationMapper mapper;

	    @Override
	    public List<NotificationVO> getAlarmsForUser(int userNo) {
	        // DAO를 통해 알림을 조회하여 반환
	        List<NotificationVO> result = mapper.findAlarmsByUserNo(userNo);

	        // 결과를 로깅하여 디버깅
	        if (result != null) {
	            log.info("조회된 알림 개수: " + result.size());
	            for (NotificationVO notification : result) {
	                log.info("알림 내용: " + notification.toString()); // toString() 메서드가 오버라이드되어 있어야 내용 확인 가능
	            }
	        } else {
	            log.warn("조회된 알림이 없습니다.");
	        }

	        return result;
	    }
	    @Override
	    public boolean deleteNotification(int notificationNo) {
	        // 삭제 메서드 호출 및 결과 확인
	        int result = mapper.deleteNotification(notificationNo);
	        boolean isDeleted = (result > 0); // result가 1 이상이면 삭제 성공

	        if (isDeleted) {
	            log.info("알림 삭제 성공, ID: " + notificationNo);
	        } else {
	            log.warn("알림 삭제 실패, ID: " + notificationNo);
	        }

	        return isDeleted;
	    }
}
