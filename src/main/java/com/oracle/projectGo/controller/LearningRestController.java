package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.service.LearningGroupService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/learning")
public class LearningRestController {
    private final LearningGroupService learningGroupService;


    @GetMapping("/api/signUpLearningGroup")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> signUpLearningGroup() {
        Map<String, Object> response = new HashMap<>();

        List<LearningGroup> learningGroupList = learningGroupService.signUpLearningGroup();
        response.put("learningGroupList", learningGroupList);

        return ResponseEntity.ok(response);
    }
}
