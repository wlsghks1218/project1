package org.hype.service;

import java.sql.Date;
import java.util.List;

import org.hype.domain.NotificationVO;

public interface NotificationService {

	public List<NotificationVO> getAlarmsForUser(int userNo);

	public boolean deleteNotification(int notificationNo);

	public boolean updateNotificationReadStatus(int userNo);

	public List<Integer> getLikedPopUpStoresByUser(int userNo);

	public void insertPopUpNotification(NotificationVO notification);

	public List<Integer> getLikedGoodsByUserNo(int userNo);

	public List<Integer> getLikedStartPopUpStoresByUser(int userNo);

	public List<Integer> getLikedEndExhByUserNo(int userNo);

	public List<Integer> getLikedStartExhByUserNo(int userNo);

	public List<Integer> getAllUserNos();

	public int getUserNoByQnaNo(int qnaNo);



}
