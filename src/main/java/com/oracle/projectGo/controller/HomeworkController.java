package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.HomeworkService;
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
    @RequestMapping(value = "listHomework")
    public String listHomework(Homeworks homework, String currentPage, Model model, RedirectAttributes redirectAttributes) {

        /* TODO: GET TOTAL HOMEWORK COUNT  */
        int totalHomeworksCnt = homeworkService.getTotalHomeworksCnt(homework);

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
}
