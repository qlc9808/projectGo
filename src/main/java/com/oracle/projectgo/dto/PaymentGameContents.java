package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PaymentGameContents {
    private int id;             // 결제ID
    private int userId;         // 회원번호
    private String type;        // 결제방법 !!!!type바꿔야됨!!!!
    private String status;      // 결제상태
    private Date purchaseDate;  // 구매일자
}
