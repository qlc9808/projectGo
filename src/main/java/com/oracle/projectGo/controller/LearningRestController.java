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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    public ResponseEntity<Map<String, Object>> signUpLearningGroup() throws ParseException {
        Map<String, Object> response = new HashMap<>();

        List<LearningGroup> learningGroupList = learningGroupService.signUpLearningGroup();
        formatDate(learningGroupList);
        log.info(learningGroupList.toString());

        response.put("learningGroupList", learningGroupList);

        return ResponseEntity.ok(response);
    }

    private void formatDate(List<LearningGroup> list) throws ParseException {
        SimpleDateFormat newDtFormat = new SimpleDateFormat("yyyy-MM-dd");
        String strNewDtFormat1 = "";
        String strNewDtFormat2 = "";
        출처: https://junghn.tistory.com/entry/JAVA-자바-날짜-포맷-변경-방법SimpleDateFormat-yyyyMMdd [코딩 시그널:티스토리]
        for (int i = 0; i < list.size(); i++) {
            strNewDtFormat1 = newDtFormat.format(list.get(i).getStartDate());
            list.get(i).setFormatStartDate(strNewDtFormat1);
            strNewDtFormat2 = newDtFormat.format(list.get(i).getEndDate());
            list.get(i).setFormatEndDate(strNewDtFormat2);
        }
    }
}
