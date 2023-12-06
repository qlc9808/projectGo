package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Payments {
    private int    id;           // 결제ID
    private int    userid;       // 회원번호
    private int    contentId;    // 게임번호
    private String paymentType;  // 결제방법
    private String status;       // 결제상태 결제완료:1, 미결제:2
    private Date   purchaseDate; // 구매일자
    private int    price;        // 결제금액
}
