package com.oracle.projectgo.dto;

import lombok.Data;

import java.util.Date;

@Data
public class Users {
    private int    id;          // 회원번호
    private String nickname;    // 아이디
    private String type;        // 회원구분
    private String name;        // 이름
    private String password;    // 비밀번호
    private String birthdate;   // 생년월일
    private String address;     // 주소
    private String phoneNumber; // 연락처
    private String email;       // 이메일
    private String consent1;    // 수신동의1
    private String consent2;    // 수신동의2
    private Date   createdAt;   // 가입일자
    private String isDeleted;   // 삭제여부
    private Date   updateAt;    // 수정일
}
