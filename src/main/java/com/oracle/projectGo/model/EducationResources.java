package com.oracle.projectGo.model;

import lombok.Data;

import java.util.Date;

@Data
public class EducationResources {
    private int    id;           // 교육ID(게시판번호)
    private int    contentId;    // 게임콘텐츠ID
    private int    userId;       // 회원번호
    private String title;        // 학습자료명
    private String resourceType; // 학습자료구분 튜토리얼:1, 교육영상:2
    private String fileType;     // 자료유형
    private String fileAddress;  // 파일주소
    private String serviceType;  // 서비스구분 무료(short):1, 유료(full):2
    private String content;      // 학습자료내용
    private String image;        // 썸네일 이미지
    private int    readCount;    // 조회수
    private Date   createdAt;    // 생성일
    private Date   updatedAt;    // 수정일

}
