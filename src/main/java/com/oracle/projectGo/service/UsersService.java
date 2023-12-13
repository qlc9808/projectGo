package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.UsersDao;
import com.oracle.projectGo.dto.Users;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsersService {

    private final UsersDao ud;


    public Optional<Users> getUserByNickname(String nickname) {
        Users getUserByNickname = ud.getUserByNickname(nickname);
        return Optional.ofNullable(getUserByNickname);

    }

    public int getLoggedInId() {
        Users user =new Users();
        user.setId(0);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !authentication.getName().equals("anonymousUser") ){
            user = ud.getUserByNickname(authentication.getName());


            log.info("로그인아이디:{}",user.getId());
            return user.getId();
        }
        return user.getId();
    }
    public Users getLoggedInUserInfo() {
        Users user =new Users();
        user.setId(0);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !authentication.getName().equals("anonymousUser") ){
            user = ud.getUserByNickname(authentication.getName());

            return user;
        }
        return user;
    }
}
