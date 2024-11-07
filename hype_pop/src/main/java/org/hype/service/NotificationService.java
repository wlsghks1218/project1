package org.hype.service;

import java.util.List;

import org.hype.domain.NotificationVO;

public interface NotificationService {

	public List<NotificationVO> getAlarmsForUser(int userNo);

	public boolean deleteNotification(int notificationNo);

}
