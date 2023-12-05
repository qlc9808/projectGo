package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PaymentGameContents {
    private int paymentId; // 결제ID
    private int contentId; // 게임 콘텐츠ID

}
