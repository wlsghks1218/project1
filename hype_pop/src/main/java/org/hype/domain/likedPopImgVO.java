package org.hype.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class likedPopImgVO {

	
	private int userNo; // ????�???
	private int psNo; // ?????��???? �???
	private Date likeDate; // �????? ??�?
	private String uuid; // uuid
	private String uploadPath; // ??�??? 경�?
	private String fileName; // ???? ?��?
	private String psName; // ?????��???? ?��?
}