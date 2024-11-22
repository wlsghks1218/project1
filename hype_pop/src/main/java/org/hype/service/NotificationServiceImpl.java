package org.hype.service;

import java.sql.Date;
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
	    @Override
	    public boolean updateNotificationReadStatus(int userNo) {
	        int result = mapper.updateNotificationReadStatus(userNo);
	        boolean isUpdate = (result > 0); // result가 1 이상이면 삭제 성공

	        if (isUpdate) {
	            log.info("알림 삭제 성공, ID: " + userNo);
	        } else {
	            log.warn("알림 삭제 실패, ID: " + userNo);
	        }

	        return isUpdate;
	    }
	    @Override
	    public List<Integer> getLikedPopUpStoresByUser(int userNo) {
	        // 유저가 좋아요한 팝업스토어들의 ID를 반환
	        List<Integer> likedStoreIds = mapper.getLikedPopUpStoresByUser(userNo);
	        
	        // 로깅
	        if (likedStoreIds != null && !likedStoreIds.isEmpty()) {
	            log.info("유저 " + userNo + "가 좋아요한 스토어 개수: " + likedStoreIds.size());
	        } else {
	            log.warn("유저 " + userNo + "가 좋아요한 스토어가 없습니다.");
	        }

	        return likedStoreIds;
	    }
	    @Override
	    public void insertPopUpNotification(NotificationVO notification) {
	    	  mapper.insertPopUpNotification(notification);
	    
	    }
	    @Override
	    public List<Integer> getLikedGoodsByUserNo(int userNo) {
     List<Integer> likedGoodsNo = mapper.getLikedGoodsByUserNo(userNo);
	        
	        // 로깅
	        if (likedGoodsNo != null && !likedGoodsNo.isEmpty()) {
	            log.info("유저 " + userNo + "가 좋아요한 스토어 개수: " + likedGoodsNo.size());
	        } else {
	            log.warn("유저 " + userNo + "가 좋아요한 스토어가 없습니다.");
	        }

	        return likedGoodsNo;
	    }
	    @Override
	    public List<Integer> getLikedStartPopUpStoresByUser(int userNo) {
	    	 // 유저가 좋아요한 팝업스토어들의 ID를 반환
	        List<Integer> likedStoreIds = mapper.getLikedStartPopUpStoresByUser(userNo);
	        
	        // 로깅
	        if (likedStoreIds != null && !likedStoreIds.isEmpty()) {
	            log.info("유저 " + userNo + "가 좋아요한 스토어 개수: " + likedStoreIds.size());
	        } else {
	            log.warn("유저 " + userNo + "가 좋아요한 스토어가 없습니다.");
	        }

	        return likedStoreIds;
	    }
	    @Override
	    public List<Integer> getLikedEndExhByUserNo(int userNo) {
	    	 // 유저가 좋아요한 팝업스토어들의 ID를 반환
	        List<Integer> likedExhNo = mapper.getLikedEndExhByUserNo(userNo);
	        
	        // 로깅
	        if (likedExhNo != null && !likedExhNo.isEmpty()) {
	            log.info("유저 " + userNo + "가 좋아요한 스토어 개수: " + likedExhNo.size());
	        } else {
	            log.warn("유저 " + userNo + "가 좋아요한 스토어가 없습니다.");
	        }

	        return likedExhNo;
	    }
	  @Override
	public List<Integer> getLikedStartExhByUserNo(int userNo) {
    List<Integer> likedExhNo = mapper.getLikedStartExhByUserNo(userNo);
	        
	        // 로깅
	        if (likedExhNo != null && !likedExhNo.isEmpty()) {
	            log.info("유저 " + userNo + "가 좋아요한 스토어 개수: " + likedExhNo.size());
	        } else {
	            log.warn("유저 " + userNo + "가 좋아요한 스토어가 없습니다.");
	        }

	        return likedExhNo;
	}
     @Override
     public List<Integer> getAllUserNos() {
    	 List<Integer> result = mapper.getAllUserNos();
        return result;
}
     @Override
    public int getUserNoByQnaNo(int qnaNo) {
    	 System.out.println("서비스의 qnaNo는 : " + qnaNo);
    	 
        int result = mapper.getUserNoByQnaNo(qnaNo);
        
         System.out.println("결과값은? : " + result);
        return result;
    }
 
}
