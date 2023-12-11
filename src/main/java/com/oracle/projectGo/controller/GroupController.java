package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.LearningGroupService;
import com.oracle.projectGo.service.Paging;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/group")
public class GroupController {

    private final LearningGroupService groupService;

    @RequestMapping(value = "listGroupContent")
    public String listGroupContent(LearningGroup learningGroup, String currentPage, Model model) {

        try {
            // GroupContent Count 조회
            int totalGroupContentCnt = groupService.totalGroupContentCnt();

            // LearningGroupList 조회
            List<LearningGroup> learningGroupList = groupService.learningGroupList(learningGroup);

            // paging 처리
            Paging page = new Paging(totalGroupContentCnt, currentPage);
            learningGroup.setStart(page.getCurrentPage());
            learningGroup.setEnd(page.getEnd());

            model.addAttribute("GroupContentCnt", totalGroupContentCnt);
            model.addAttribute("learningGroupList", learningGroupList);
            model.addAttribute("currentPage", currentPage);

        } catch (Exception e) {
            log.error("GroupController listGroupContent e.getMessage() -> " + e.getMessage());
        } finally {
            log.info("GroupController listGroupContent end");
        }

        return "/educate/learningGroup/listGroupContent";
    }

    @ResponseBody
    @RequestMapping(value="getGroupMemberByGroupId",method = RequestMethod.GET)
    public ResponseEntity<List<Users>> getGroupMemberByGroupId(@RequestParam int groupId) {

        List<Users> homeworkTitleList = groupService.getGroupMemberByGroupId(groupId);

        return ResponseEntity.ok(homeworkTitleList);
    }

    @ResponseBody
    @RequestMapping(value="getGroupMembersByEducatorId",method = RequestMethod.GET)
    public ResponseEntity<List<Users>> getGroupMembersByEducatorId(@RequestParam int educatorId) {

        List<Users> homeworkTitleList = groupService.getGroupMembersByEducatorId(educatorId);

        return ResponseEntity.ok(homeworkTitleList);
    }
}
