package com.oracle.projectGo.controller.admin;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/admin/resource")
public class AdminResourceController {

    @RequestMapping(value = "/enrollEducation")
    public String insertEducation() {

        return "admin/resource/enrollEducation";
    }
}
