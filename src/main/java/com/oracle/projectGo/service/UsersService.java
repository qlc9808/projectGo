package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.UsersDao;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.type.UsersRoleType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class UsersService {

    private final UsersDao ud;
    private final JavaMailSender mailSender;


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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !authentication.getName().equals("anonymousUser") ){

            user = ud.getUserByNickname(authentication.getName());

            return user;
        }
        return user;
    }

    public UsersRoleType getLoggedInUserRole() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        // 로그인하지 않았거나 권한이 없는 경우 ANONYMOUS 리턴
        if (authentication == null || authentication.getAuthorities().isEmpty()) {
            return UsersRoleType.ANONYMOUS;
        }

        String role = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .findFirst()
                .orElseThrow(() -> new RuntimeException("No authority found"));

        // "ROLE_" 접두사 제거
        String roleLabel = role.replace("ROLE_", "");
        log.info("getLoggedInUserRole:{}",roleLabel);

        return UsersRoleType.findByLabel(roleLabel);
    }






    public int insertUsers(Users users) {
        log.info("UsersService start");
        int insertUsers = 0;

        insertUsers = ud.insertUsers(users);
        return insertUsers;

    }

    public int nickCheck(Users users) {
        int result = ud.nickCheck(users);
        return result;
    }

    public Users idSearchByPhone(Users users) {
        Users idSearchByPhone = ud.idSearchByPhone(users);
        return idSearchByPhone;
    }
    public String sendEmail(String userEmail) {

        String token = RandomStringUtils.randomNumeric(6);


        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(userEmail);
        message.setSubject("회원가입 인증 메일");
        message.setText("인증 코드: " + token);

        mailSender.send(message);

        return token;
    }

    public int totalUsers(Users users) {
        int totalUsers = 0;
        totalUsers = ud.totalUsers(users);
        return totalUsers;
    }

    public List<Users> getSearchUserList(Users users) {
        List<Users> getSearchUserList = null;
        getSearchUserList = ud.getSearchUserList(users);
        return getSearchUserList;

    }
}
