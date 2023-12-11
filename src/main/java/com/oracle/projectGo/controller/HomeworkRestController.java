package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.HomeworkService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkRestController {
    private final HomeworkService homeworkService;

    @ResponseBody
    @RequestMapping(value = "insertHomework", method = RequestMethod.POST)
    public ResponseEntity<String> insertHomework(@Valid @RequestBody Homeworks homework)  {
        /* TODO: CHECK PARAMETERS  */
        log.info(homework.toString());

        /* TODO: INSERT PROCESS */
        int result = homeworkService.insertHomework(homework);

        return ResponseEntity.ok("{\"message\": \"숙제가 정상적으로 등록 되었습니다.\"}");
    }

    @ResponseBody
    @RequestMapping(value="getHomeworkTitleList",method = RequestMethod.GET)
    public ResponseEntity<List<String>> getHomeworkTitleList() {
        int educatorId = 1;
//        int userId = getLogginedUserId();

        List<String> homeworkTitleList = homeworkService.getDistinctHomeworkTitles(educatorId);

        return ResponseEntity.ok(homeworkTitleList);
    }

}
