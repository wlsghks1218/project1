package org.hype.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class exhImgVO {
	private int exhNo;
	private String uuid, uploadPath, fileName;
}