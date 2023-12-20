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

    private int   subscribeDate;       // 구독기간(개월수)

    private String  gameLevel;              // 난이도 초급:1, 중급:2, 고급:3

    private int     maxSubscribers;         // 구독 가능 인원

    @NotEmpty(message = "필수 입력란입니다")
    private String content;                 // 게임 패키지 내용

    private Date createdAt;                 // 구독 시작 날짜 = sysdate

    private Date updatedAt;                 // 구독 수정 날짜

    private int    price;               // 정가

    private int    discountRate;        // 할인율

    private int    discountPrice;       // 판매가

    // 페이징 작업
    private int rn;
    private String search;   	private String keyword;
    private String pageNum;		private int total;
    private int start; 		 	private int end;

    // users
    private String name;  // 회원 이름
    private int    pay_userId;       // 회원 번호

    // 컨텐츠 그룹 인원
    private int     assignedPeople;    // 컨텐츠 그룹에 가입된 인원

    private Date subscribeEndDate;    //


}
