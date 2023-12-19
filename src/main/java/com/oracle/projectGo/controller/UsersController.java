package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping
public class UsersController {

private final UsersService us;

    @RequestMapping(value = "userList")
    public String userList(Model model, Users users,String currentPage) {
        UUID transactionId = UUID.randomUUID();
        List<Users> listUsers = null;
        try {
            log.info("[{}]{}:{}", transactionId, "userList", "start");

            int totalUsersCount = us.totalUsers(users);
            log.info(users.toString());

            Paging page = new Paging(totalUsersCount,currentPage);
            users.setStart(page.getStart());
            users.setEnd(page.getEnd());

            listUsers = us.getSearchUserList(users);
            if (listUsers == null) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
            }
            model.addAttribute("listUsers", listUsers);
            model.addAttribute("page", page);
            model.addAttribute("searchOption", users);
        } catch (Exception e) {
            log.error("[{}]{}:{}", transactionId, "userList", e.getMessage());
        } finally {
            log.info("[{}]{}:{}", transactionId, "userList", "end");
        }
        return "admin/user/userList";
    }
}
