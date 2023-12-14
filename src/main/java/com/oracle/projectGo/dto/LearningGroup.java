package com.oracle.projectGo.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class LearningGroup {
    private int    id;               // 그룹번호
    private int    contentId;        // 게임번호
    private int    userId;           // 회원번호
    private String name;             // 그룹명
    private Date startDate;          // 학습시작날짜
    private Date   endDate;          // 학습종료날짜
    private int    groupSize;        // 등록가능인원
    private String etc1;             // 기타항목1
    private String etc2;             // 기타항목2

    /* 페이지 처리 */
    private String pageNum;
    private int    start;
    private int    end;

    /* 조회용 */
    private String title;               // 게임명
    private int    subscribeDate;       // 구독기간
    private String gameLevel;           // 난이도 초급:1, 중급:2, 고급:3
    private int    maxSubscribers;      // 구독 가능인원
    private String content;             // 게임 패키지 내용
    private Date   subscribleStart;     // 구독시작 날짜
    private Date   subscribleEnd;       // 구독종료 날짜

    private String userName;            // 교육자명

    /* LearningGroupMember */
    private int    groupId;      // 그룹번호
    private String status;       // 승인여부 승인:1 , 미승인:0
    private Date   approvalDate; // 승인요청일자

    /* users */
    private String nickname;    // 아이디
    private String address;     // 주소
    private String phone;       // 연락처
    private String email;       // 이메일
    private Date   createdAt;   // 가입일자
}
