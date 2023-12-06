package com.oracle.projectGo.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/learning")
public class LearningController {

    @RequestMapping("/learningSign")
    public String test(){
        return "learning/learningSign";
    }
}
