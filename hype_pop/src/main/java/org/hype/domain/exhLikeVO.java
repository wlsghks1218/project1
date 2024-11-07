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
public class exhLikeVO {
	private int exhNo, userNo, likeCount;
	private Date likeDate;
	private boolean isLiked;
	
	// boolean 값을 위한 생성자 추가
    public exhLikeVO(boolean isLiked) {
        this.isLiked = isLiked;
    }
}