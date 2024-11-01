package org.hype.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class pImgVO {
	private int psNo;
	private String uuid;
	private String uploadPath;
	private String filename;
}