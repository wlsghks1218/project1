package org.hype.mapper;

import java.util.List;

import org.hype.domain.NotificationVO;

public interface NotificationMapper {

	public List<NotificationVO> findAlarmsByUserNo(int userNo);

	public int deleteNotification(int notificationNo);

}
