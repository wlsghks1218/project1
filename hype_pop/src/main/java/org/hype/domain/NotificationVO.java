package org.hype.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationVO {
    private int notificationNo; // 알림 ID
    private int userNo; // 사용자 ID
    private String type; // 알림 유형
    private int referenceNo; // 참조 ID
    private String title; // 알림 제목
    private String message; // 알림 내용
    private int isRead; // 읽음 상태
    private Date notifyAt; // 알림 발송 시간
    private Date createdAt; // 알림 생성 시간
    private String psName;
    private String goodsName;
    private String noticeTitle;
    private String qnaTitle;

    // Getter, Setter, Constructor 등 추가
    @Override
    public String toString() {
        return "NotificationVO{" +
                "notificationNO=" + notificationNo +
                ", userNo=" + userNo +
                ", type='" + type + '\'' +
                ", referenceNo=" + referenceNo +
                ", title='" + title + '\'' +
                ", message='" + message + '\'' +
                ", isRead='" + isRead + '\'' +
                ", notify_at=" + notifyAt +
                ", created_at=" + createdAt +
                '}';
    }

	
}
