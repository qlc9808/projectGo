package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.dto.LearningGroup;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.*;
import com.oracle.projectGo.utils.error.BusinessException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
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
    private final UsersService usersService;
    private final GameService gameService;

    @RequestMapping(value = "insertHomeworkForm")
    public String insertHomeworkForm(Homeworks homework, String currentPage, Model model, RedirectAttributes redirectAttributes) {
        /* TODO : PRE-PROCESS*/
        int userId = usersService.getLoggedInId();
        homework.setUserId(userId);

        /* TODO: GET TOTAL HOMEWORKS COUNT  */
        int totalHomeworksCnt = homeworkService.getTotalHomeworksCnt(homework);
        log.info(homework.toString());

        /* TODO: GET GameContents LIST */
        List<GameContents> subscribedGameList= gameService.getSubscribedGameContents(userId);
        log.info("getSubscribedGameContents:{}",subscribedGameList);

        /* TODO: PAGING PROCESS */
        Paging page = new Paging(totalHomeworksCnt, currentPage);
        homework.setStart(page.getStart());
        homework.setEnd(page.getEnd());

        /* TODO: GET HOMEWORK LIST */
        List<Homeworks> homeworkList = homeworkService.getHomeworksList(homework);

        /* TODO: SET ATTRIBUTE */
        model.addAttribute("userId",userId);
        model.addAttribute("page", page);
        model.addAttribute("subscribedGameList", subscribedGameList);
        model.addAttribute("homeworkList", homeworkList);
        model.addAttribute("currentPage", currentPage);

        return "educate/homework/insertHomeworkForm";
    }

    // 숙제 리스트와 회원 리스트를 보여주는 화면
    @RequestMapping(value = "/distributeHomeworkForm")
    public String distributeHomeworkForm(Homeworks homework, Model model) {
        /* TODO : PRE-PROCESS*/
        int userId = usersService.getLoggedInId();
        homework.setUserId(userId);

        /* TODO: 학습 그룹 리스트 받아오기 */
        LearningGroup learningGroup = new LearningGroup();
        List<LearningGroup> learningGroupList = learningGroupService.learningGroupList(userId);

        /* TODO: 숙제명에 따라 숙제를 받아오는 로직 */
        List<Homeworks> homeworkList = homeworkService.getHomeworksList(homework);

        /* 학습 그룹은 AJAX로. */

        /* TODO: SET ATTRIBUTES */
        model.addAttribute("userId",userId);
        model.addAttribute("learningGroupList", learningGroupList);
        model.addAttribute("homeworkList", homeworkList);
        model.addAttribute("searchOptions", homework);

        return "educate/homework/distributeHomeworkForm";
    }
    @RequestMapping(value = "/evaluateHomeworkForm")
    public String evaluateHomeworkForm(Homeworks homework, Model model) {
        /* TODO : PRE-PROCESS*/
        int userId = usersService.getLoggedInId();
        homework.setUserId(userId);

        /* TODO: 숙제명에 따라 숙제를 받아오는 로직 */
        List<Homeworks> homeworkList = homeworkService.getHomeworksList(homework);

        /* TODO: SET ATTRIBUTES */
        model.addAttribute("userId",userId);
        model.addAttribute("homeworkList", homeworkList);
        model.addAttribute("searchOptions", homework);

        return "educate/homework/evaluateHomeworkForm";
    }
}
