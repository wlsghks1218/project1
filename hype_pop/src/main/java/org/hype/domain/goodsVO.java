package org.hype.domain;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class goodsVO {
	
	private int gno; 
	private int psno; 
	private int gprice; 
	private int ghit; 
	private int likeCount; 
	private int replycnt;
	private String gname; 
	private String gexp; 
	private gCatVO gcat; 
	private List<gImgVO> attachList; 
	private Date sellDate; 
	
	private List<MultipartFile> imageFiles;
}