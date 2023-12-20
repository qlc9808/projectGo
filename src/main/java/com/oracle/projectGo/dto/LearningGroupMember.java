package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class LearningGroupMember {
    private int    groupId;      // 그룹번호
    private int    userId;       // 회원번호
    private int    contentId;
    private String status;       // 승인여부 승인:1 , 미승인:0
    private Date   approvalDate; // 승인요청일자
}
