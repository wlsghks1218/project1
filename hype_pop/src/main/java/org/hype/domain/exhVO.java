package org.hype.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class exhVO {
	private int exhNo, exhWatchTime, exhPrice;
	private String exhName, exhLocation, exhWatchAge, exhInfo;
	private Date exhStartDate, exhEndDate;
	private List<exhImgVO> attachExhList; 	
	private List<MultipartFile> imageExhFiles;
}