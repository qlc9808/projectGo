package com.oracle.projectGo.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.util.Date;

@Data
public class GameContents {
    private int    id;                  // 게임콘텐츠ID
    private int    userId;              // 회원번호

    @NotEmpty(message = "필수 입력란입니다")
    private String title;               // 게임명

    private String imageName;           // 이미지명

    private String imagePath;           // 이미지경로

    @NotEmpty(message = "필수 입력란입니다")
    private String   subscribeDate;       // 구독기간

    @NotEmpty(message = "필수 입력란입니다")
    private String  gameLevel;           // 난이도 초급:1, 중급:2, 고급:3

    private int     maxSubscribers;      // 구독 가능인원

    @NotEmpty(message = "필수 입력란입니다")
    private String content;             // 게임 패키지 내용

    private Date   createdAt;           // 생성일

    private Date   updatedAt;           // 수정일

    private int    price;               // 정가

    private int    discountRate;        // 할인율

    private int    discountPrice;       // 판매가
}
