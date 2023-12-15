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

    public int insertUsers(Users users) {
        log.info("UsersDao insertUsers start");
        int insertUsers = 0;
        try {
            insertUsers = session.insert("insertUsers", users);

        } catch (Exception e) {
            log.info("UsersDao insertUsers => " + e.getMessage());
        }
        log.info("insertUsers="+insertUsers);

        return insertUsers;


    }

    public int nickCheck(Users users) {
        log.info("UsersDao nickCheck start");
        int nickCheck = 0;
        try {
            nickCheck = session.selectOne("usersNicknameCheck", users);

        } catch (Exception e) {
            log.info("UsersDao nickCheck => " + e.getMessage());
        }
        log.info("result="+nickCheck);

        return nickCheck;
    }
}
