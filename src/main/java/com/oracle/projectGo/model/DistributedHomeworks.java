package com.oracle.projectGo.model;

import lombok.Data;

import java.util.Date;

@Data
public class DistributedHomeworks {
    private int    homeworkId;      // 숙제ID
    private int    studentId;       // 학습자ID
    private Date   submissionDate;  // 숙제 제출일
    private String content;         // 학습 제출내용
    private int    progress;        // 학습 진도
    private String questions;       // 추가 질문내용
    private String evaluation;      // 평가  미흡:1, 보통:2, 우수:3
    private Date   createdAt;       // 생성일
    private Date   updatedAt;       // 수정일
    private String level;           // 난이도
}
