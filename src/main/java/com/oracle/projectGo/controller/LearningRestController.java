package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.LearningGroupMember;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.LearningGroupService;
import com.oracle.projectGo.service.LearningRequestService;
import com.oracle.projectGo.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

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
    private final LearningRequestService learningRequestService;
    private final UsersService usersService;

    @GetMapping("/api/signUpLearningGroup")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> signUpLearningGroup() throws ParseException {
        Map<String, Object> response = new HashMap<>();
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();

        List<LearningGroup> learningGroupList = learningGroupService.signUpLearningGroup();
        formatDate(learningGroupList);
        log.info(learningGroupList.toString());
        LearningGroupMember member = learningRequestService.remainRequest(userId);
        int result = 0;
        if (member != null) {
            result = 1;
        }

        response.put("learningGroupList", learningGroupList);
        response.put("userType", users.getUserType());
        response.put("result", result);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/api/requestSignUp")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> requestSignUp(int groupId) {
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();

        Map<String, Object> response = new HashMap<>();
        LearningGroupMember member = new LearningGroupMember();
        member.setUserId(userId);
        member.setGroupId(groupId);
        int result = learningRequestService.requestSignUp(member);
        log.info("성공여부->"+result);

        response.put("result", result);

        return ResponseEntity.ok(response);
    }

    @DeleteMapping(value = "/api/cancelSignUp")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> cancelSignUp(int groupId) {
        Users users = usersService.getLoggedInUserInfo();
        int userId = users.getId();

        Map<String, Object> response = new HashMap<>();
        LearningGroupMember member = new LearningGroupMember();
        member.setUserId(userId);
        member.setGroupId(groupId);
        int result = learningRequestService.cancelSignUp(member);
        log.info("성공여부->"+result);

        response.put("result", result);

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
