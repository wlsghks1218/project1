package org.hype.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class goodsVO {
	private int gno, psno, gprice, ghit, likeCount, replycnt;
	private String gname, gexp;
	private Date sellDate;
	private List<gImgVO> attachList;
	private gCatVO gcat;
}