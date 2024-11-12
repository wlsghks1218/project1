package org.hype.mapper;

import java.sql.Date;
import java.util.List;

import org.hype.domain.NotificationVO;

public interface NotificationMapper {

	public List<NotificationVO> findAlarmsByUserNo(int userNo);

	public int deleteNotification(int notificationNo);

	public int updateNotificationReadStatus(int userNo);

	public List<Integer> getLikedPopUpStoresByUser(int userNo);

	public void insertPopUpNotification(NotificationVO notification);


}
