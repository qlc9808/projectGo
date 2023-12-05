package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class GameContents {
    private int id;             // 게임콘텐츠ID
    private int userId;         // 회원번호
    private String title;       // 게임명
    private String imageName;   // 이미지명
    private String imagePath;   // 이미지경로
    private int price;          // 가격
    private Date startDate;     // 구독시작날짜
    private Date endDate;       // 구독종료날짜
    private String description; // 게임소개
    private String level;       // 난이도
    private int maxSubscribers; // 구독 가능인원
    private String content;     // 게임 패키지 내용
    private Date createdAt;     // 생성일
    private Date updatedAt;     // 수정일
}
