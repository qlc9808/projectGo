package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class LearningGroup {
    private int    id;               // 그룹번호
    private int    contentId;        // 게임번호
    private int    userId;           // 회원번호
    private String name;             // 그룹명
    private Date   startDate;        // 학습시작날짜
    private Date   endDate;          // 학습종료날짜
    private int    availableSlots;   // 등록가능인원
    private String etc1;             // 기타항목1
    private String etc2;             // 기타항목2

    /* 페이지 처리 */
    private String pageNum;
    private int    start;
    private int    end;
}
