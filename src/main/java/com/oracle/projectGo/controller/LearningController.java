package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.DistributedHomeworks;
import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.HomeworkService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/learning")
public class LearningController {
    private final HomeworkService homeworkService;

    @RequestMapping("/learningSign")
    public String test(){
        return "learning/learningSign";
    }

    @RequestMapping(value = "submitHomeworkForm")
    public String submitHomeworkForm(DistributedHomeworks distributedHomeworks, Model model) {
        distributedHomeworks.setUserId(2);
        List<DistributedHomeworks> distributedHomeworksList = homeworkService.getDistributedHomeworks(distributedHomeworks);
        for (DistributedHomeworks homeworks : distributedHomeworksList) {
            log.info("{}", homeworks);
        }
        model.addAttribute("distributedHomeworksList", distributedHomeworksList);

        return "learning/submitHomeworkForm";
    }



}
