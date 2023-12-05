package com.oracle.projectgo.dto;

import lombok.Data;

@Data
public class LeamingGroup {
    private int id;                 // 그룹번호
    private int userId;             // 회원번호
    private String name;            // 그룹명
    private String contentName;     // 콘텐츠명
    private String period;          // 학습구독기간
    private int totalLeamers;       // 총 학습인원
    private int assignedLeamers;    // 기 배정인원
    private int availableSlots;     // 등록가능인원
    private String instructorName;  // 교육자명
    private String etc1;            // ETC1
    private String etc2;            // ETC2
}
