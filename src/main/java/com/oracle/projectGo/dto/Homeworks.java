package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Homeworks {
    private int    id;                // 숙제ID
    private int    userId;            // 회원번호
    private String title;             // 숙제명
    private String content;           // 숙제내용
    private int    progress;          // 진도
    private Date   deadline;          // 제출기한
    private Date   distributionDate;  // 전송일자
    private Date   createdAt;         // 생성일
    private Date   updatedAt;         // 수정일

    /* 페이지 처리 */
    private String pageNum;
    private int    start;
    private int    end;
}
