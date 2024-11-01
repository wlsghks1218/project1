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
public class likedGoodsImgVO {
    private int userNo;
    private int gno;
    private Date likeDate;
    private String gname;
    private String uuid;
    private String uploadPath;
    private String fileName;

    @Override
    public String toString() {
        return "likedGoodsImgVO{" +
                "userNo=" + userNo +
                ", gNo=" + gno +
                ", likeDate=" + likeDate +
                ", gName='" + gname + '\'' +
                ", uuid='" + uuid + '\'' +
                ", uploadPath='" + uploadPath + '\'' +
                ", fileName='" + fileName + '\'' +
                '}';
    }
}