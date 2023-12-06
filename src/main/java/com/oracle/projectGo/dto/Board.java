package com.oracle.projectGo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Board {
    private int    id;              // 게시판ID
    private int    userid;          // 회원번호
    private String boardType;       // 게시판유형 공지:1, FAQ:2, QnA:3
    private String title;           // 제목
    private String content;         // 내용
    private String status;          // 상태 공개:1, 비공개:0
    private int    readCount;       // 조회수
    private String fileName;        // 파일이름
    private int    fileSize;        // 파일용량
    private String filePath;        // 저장경로
    private int    commentGroupId;  // 댓글그룹
    private int    commentIndent;   // 댓글밀기
    private String commentStep;     // 댓글최신
    private Date   createdAt;       // 생성일
    private Date   updateAt;        // 수정일
}
