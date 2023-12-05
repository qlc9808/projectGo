package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class LeamingGroupMember {
    private int userId;         // 회원번호
    private int groupId;        // 그룹번호
    private Date approvalDate;  // 승인요청일자
    private String status;      // 승인여부
}
