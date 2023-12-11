package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.DistributionRequest;
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
    @ResponseBody
    @RequestMapping(value = "distributeHomework", method = RequestMethod.POST)
    public ResponseEntity<String> distributeHomework(@RequestBody DistributionRequest request)  {
        // 숙제 배포 로직...
        // selectedStudentIds와 homeworkIds는 request 객체에서 얻을 수 있습니다.
        log.info(request.toString());
        return ResponseEntity.ok("{\"message\": \"숙제가 성공적으로 배포되었습니다.\"}");
    }
}
