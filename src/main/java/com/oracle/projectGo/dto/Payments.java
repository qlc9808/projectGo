package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Payments {
    private int    id;           // 결제 번호
    private int    userId;       // 회원 번호
    private int    contentId;    // 게임 번호
    private String paymentType;  // 결제방법    무통장입금: 1, 계좌이체: 2, 카카오페이:3
    private String status;       // 결제상태    결제완료:1, 미결제:2
    private Date   purchaseDate; // 구매일자
    private int    price;        // 결제금액
}
