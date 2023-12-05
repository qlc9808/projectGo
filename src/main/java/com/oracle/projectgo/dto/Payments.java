package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Payments {
    private int id;            // 결제ID
    private int userid;        // 회원번호
    private String type;       // 결제방법
    private String status;     // 결제상태
    private Date purchaseDate; // 구매일자
}
