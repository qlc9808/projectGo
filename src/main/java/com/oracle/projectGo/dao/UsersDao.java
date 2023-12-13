package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
@Slf4j
@RequiredArgsConstructor
public class UsersDao {

    private final SqlSession session;

    public Users getUserByNickname(String nickname) {
        Users getUserByNickname = null;
    try {
        getUserByNickname = session.selectOne("getUserByNickname",nickname);


    }catch (Exception e){
        log.error("BoardDao boardCount Exception : {}", e.getMessage());

    } return getUserByNickname;

    }
}
