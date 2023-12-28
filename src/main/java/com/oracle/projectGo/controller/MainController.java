package com.oracle.projectGo.controller;

import com.oracle.projectGo.service.UsersService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {

    private final UsersService us;

    @GetMapping("/")
    public String home(HttpServletRequest request, Model model) {
        if (request.getParameter("error") != null) {
            model.addAttribute("error", "접근권한이 없습니다.");
        }
        return "home";
    }
}
