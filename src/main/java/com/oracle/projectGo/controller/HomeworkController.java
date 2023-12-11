package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.service.HomeworkService;
import com.oracle.projectGo.service.LearningGroupService;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.utils.error.BusinessException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkController {
    private final HomeworkService homeworkService;
    private final LearningGroupService learningGroupService;

    @RequestMapping(value = "listHomework")
    public String listHomework(Homeworks homework, String currentPage, Model model, RedirectAttributes redirectAttributes) {

        /* TODO: GET TOTAL HOMEWORK COUNT  */
        int totalHomeworksCnt = homeworkService.getTotalHomeworksCnt(homework);
        log.info(homework.toString());
        /* TODO: PAGING PROCESS */
        Paging page = new Paging(totalHomeworksCnt, currentPage);
        homework.setStart(page.getStart());
        homework.setEnd(page.getEnd());

        /* TODO: GET HOMEWORK LIST */
        List<Homeworks> homeworkList = homeworkService.getHomeworksList(homework);

        /* TODO: SET ATTRIBUTE */
        model.addAttribute("page", page);
        model.addAttribute("homeworkList", homeworkList);
        model.addAttribute("currentPage", currentPage);

        return "educate/homework/listHomework";
    }

    // 숙제 리스트와 회원 리스트를 보여주는 화면
    @RequestMapping(value = "/distributeHomeworkForm")
    public String distributeHomeworkForm(Homeworks homework, Model model) {
        log.info(homework.toString());

        /* TODO: 학습 그룹 리스트 받아오기 */
        LearningGroup learningGroup = new LearningGroup();
        List<LearningGroup> learningGroupList = learningGroupService.learningGroupList(learningGroup);

        /* TODO: 숙제명에 따라 숙제를 받아오는 로직 */
        List<Homeworks> homeworkList = homeworkService.getHomeworksList(homework);

        /* 학습 그룹은 AJAX로. */

        /* TODO: SET ATTRIBUTES */
        model.addAttribute("learningGroupList", learningGroupList);
        model.addAttribute("homeworkList", homeworkList);
        model.addAttribute("searchOptions", homework);

        return "educate/homework/distributeHomeworkForm";
    }


}
