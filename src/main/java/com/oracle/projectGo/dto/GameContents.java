package com.oracle.projectGo.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;
import java.sql.Date;

@Data
public class GameContents {
    private int    id;                  // 게임콘텐츠ID

    private int    userId;              // 회원번호

    @NotEmpty(message = "필수 입력란입니다")
    private String title;               // 게임명

    private String imageName;           // 이미지명

    private String imagePath;           // 이미지경로

    private int   subscribeDate;       // 구독기간

    private String  gameLevel;              // 난이도 초급:1, 중급:2, 고급:3

    private int     maxSubscribers;         // 구독 가능인원

    @NotEmpty(message = "필수 입력란입니다")
    private String content;                 // 게임 패키지 내용

    private Date subscribleStart;   // 구독 시작 날짜

    private Date subscribleEnd;     // 구독 종료 날짜

    private int    price;               // 정가

    private int    discountRate;        // 할인율

    private int    discountPrice;       // 판매가

    // 페이징 작업
    private int rn;
    private String search;   	private String keyword;
    private String pageNum;		private int total;
    private int start; 		 	private int end;
}
