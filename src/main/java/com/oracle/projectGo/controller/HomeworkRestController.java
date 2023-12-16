package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.DistributedHomeworks;
import com.oracle.projectGo.dto.DistributionRequestDto;
import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.HomeworkService;
import com.oracle.projectGo.service.UsersService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@RestController
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkRestController {
    private final HomeworkService homeworkService;
    private final UsersService usersService;

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
    @RequestMapping(value = "getHomework/{homeworkId}", method = RequestMethod.GET)
    public ResponseEntity<Homeworks> getHomework(@PathVariable int homeworkId) {
        Homeworks homework = homeworkService.getHomework(homeworkId);
        if (homework == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.ok(homework);
    }


    @ResponseBody
    @RequestMapping(value="getHomeworkTitleList",method = RequestMethod.GET)
    public ResponseEntity<List<String>> getHomeworkTitleList() {
        int educatorId = usersService.getLoggedInId();
        List<String> homeworkTitleList = homeworkService.getDistinctHomeworkTitles(educatorId);
        return ResponseEntity.ok(homeworkTitleList);
    }

    @ResponseBody
    @RequestMapping(value="getHomeworkTitleListByKeyword",method = RequestMethod.GET)
    public ResponseEntity<List<String>> getHomeworkTitleListByKeyword(@RequestParam("userId") int userId, @RequestParam("keyword") String keyword) {
        List<String> homeworkTitleList = homeworkService.getDistinctHomeworkTitlesByKeyword(userId, keyword);
        return ResponseEntity.ok(homeworkTitleList);
    }

    @ResponseBody
    @RequestMapping(value = "distributeHomework", method = RequestMethod.POST)
    public ResponseEntity<String> distributeHomework(@RequestBody DistributionRequestDto request)  {
        log.info(request.toString());
        try{
            for (int homeworkId : request.getHomeworkIds()) {
                for (int studentId : request.getStudentIds()) {
                        DistributedHomeworks distributedHomeworks = new DistributedHomeworks();
                        distributedHomeworks.setHomeworkId(homeworkId);
                        distributedHomeworks.setUserId(studentId);
                        DistributedHomeworks getResult = homeworkService.getDistributedHomeworks(distributedHomeworks);
                        if (getResult == null) {
                                int insertResult = homeworkService.insertDistributedHomeworks(distributedHomeworks);
                                log.info("INSERT(user:{})", distributedHomeworks.getUserId());
                        } else {
                            log.info("EXIST(user:{})", distributedHomeworks.getUserId());
                        }
                }
                Homeworks homeworks = new Homeworks();
                homeworks.setId(homeworkId);
                homeworks.setDistributionDate(new Date());
                homeworkService.updateHomeworks(homeworks);
            }
            return ResponseEntity.ok("{\"message\": \"숙제가 성공적으로 배포되었습니다.\"}");
        } catch (Exception e){
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("{\"message\": \"숙제 배포에 실패했습니다.\"}");
        }
    }

    @PostMapping("/getDistributedHomeworks")
    public ResponseEntity<List<DistributedHomeworks>> getDistributedHomeworks(@RequestBody DistributedHomeworks pDistributedHomework) {
        log.info("{}",pDistributedHomework);
        List<DistributedHomeworks> distributedHomeworks = homeworkService.getDistributedHomeworksList(pDistributedHomework);
        log.info(distributedHomeworks.toString());
        return ResponseEntity.ok(distributedHomeworks);
    }

    @ResponseBody
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
    @ResponseBody
    @PostMapping("submissionHomework")
    public ResponseEntity<String> submissionHomework(@RequestBody List<DistributedHomeworks> submissions) {
        try {
            for (DistributedHomeworks distributedHomework : submissions) {
                log.info("distributedHomework:{}",distributedHomework);
            }
            homeworkService.updateSubmissionList(submissions);
            return ResponseEntity.ok("{\"message\": \"숙제가 성공적으로 제출되었습니다.\"}");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("{\"message\": \"숙제 제출에 실패했습니다.\"}");
        }
    }
    @ResponseBody
    @PostMapping("editSubmissionHomework")
    public ResponseEntity<String> editSubmissionHomework(@RequestBody DistributedHomeworks submission) {
        try {
            log.info("submission:{}",submission);
            homeworkService.updateSubmission(submission);
            return ResponseEntity.ok("{\"message\": \"숙제가 성공적으로 수정되었습니다. \"}");
        } catch (Exception e) {
            log.error(e.getMessage());
            return ResponseEntity.internalServerError().body("{\"message\": \"숙제 수정에 실패했습니다.\"}");
        }
    }


}
