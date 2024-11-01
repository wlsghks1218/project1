package org.hype.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class signInVO {
	private int userNo; // 회원 번호
	private String userId; // 아이디
	private String userPw; // 비밀번호
	private String userEmail; // 이메일
	private String userName; // 이름
	private String userNumber; // 전화번호
	private Date regDate; // 가입일
	private Date lastLoginDate; // 마지막 로그인 날짜
	private int enabled; // 계정 활성화 여부
	private int auth; // 권한
	private String snsToken; // Access Token
	private String snsType; // sns 종류
	
	private mCatVO userInterest; // 관심사
	private List<popStoreVO> gLikeList; // 굿즈 좋아요 목록
	private List<goodsVO> pLikeList; // 스토어 좋아요 목록
}