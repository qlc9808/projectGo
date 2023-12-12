package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.DistributedHomeworks;
import com.oracle.projectGo.dto.DistributionRequestDto;
import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.HomeworkService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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
    public ResponseEntity<String> distributeHomework(@RequestBody DistributionRequestDto request)  {
        log.info(request.toString());
        try{
            List<DistributedHomeworks> distributedHomeworksList = new ArrayList<>();
            for (int studentId : request.getStudentIds()) {
                for (int homeworkId : request.getHomeworkIds()) {
                    DistributedHomeworks distributedHomeworks = new DistributedHomeworks();
                    distributedHomeworks.setHomeworkId(homeworkId);
                    distributedHomeworks.setUserId(studentId);
                    distributedHomeworksList.add(distributedHomeworks);
                }
            }
            homeworkService.distributedHomeworksBulkInsert(distributedHomeworksList);
            return ResponseEntity.ok("{\"message\": \"숙제가 성공적으로 배포되었습니다.\"}");
        } catch (Exception e){
            return ResponseEntity.internalServerError().body("{\"message\": \"숙제 배포에 실패했습니다.\"}");
        }
    }

    @PostMapping("/getDistributedHomeworks")
    public ResponseEntity<List<DistributedHomeworks>> getDistributedHomeworks(@RequestBody DistributedHomeworks pDistributedHomework) {
        log.info("{}",pDistributedHomework);
        List<DistributedHomeworks> distributedHomeworks = homeworkService.getDistributedHomeworks(pDistributedHomework);
        log.info(distributedHomeworks.toString());
        return ResponseEntity.ok(distributedHomeworks);
    }

    @PostMapping("/updateEvaluations")
    public ResponseEntity<String> updateEvaluations(@RequestBody List<DistributedHomeworks> evaluations) {
        try {
            log.info("{}",evaluations);
            homeworkService.updateEvaluation(evaluations);
            return ResponseEntity.ok("{\"message\": \"평가가 성공적으로 저장되었습니다.\"}");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("{\"message\": \"평가 저장에 실패했습니다.\"}");
        }
    }
}
