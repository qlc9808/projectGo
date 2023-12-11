package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.service.LearningGroupService;
import com.oracle.projectGo.service.Paging;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}
