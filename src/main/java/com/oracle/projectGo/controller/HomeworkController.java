package com.oracle.projectGo.controller;


import com.oracle.projectGo.model.Board;
//import com.oracle.projectGo.model.Homeworks;
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

import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkController {
    @RequestMapping(value = "listHomework")
    public String listHomework(String currentPage, Model model) {
        UUID transactionId = UUID.randomUUID();
        Board board = null;
        try {
            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(),"listHomework", "start");

            /* TODO: GET TOTAL HOMEWORK COUNT  */

            /* TODO: PAGING PROCESS */

            /* TODO: GET HOMEWORK LIST */

            /* TODO: SET ATTRIBUTE */
        } catch (Exception e) {
            log.error("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", e.getMessage());
        } finally {
            log.info("[{}]{}:{}:{}", transactionId,  this.getClass().getSimpleName(), "listHomework", "end");
        }
        return "educate/homework/listHomework";
    }

//    @ResponseBody
//    @RequestMapping(value = "insertHomework", method = RequestMethod.POST)
//    public ResponseEntity<Integer> insertHomework(@RequestBody Homeworks homeworks) {
//        UUID transactionId = UUID.randomUUID();
//        try {
//            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(),"insertHomework", "start");
//
//            /* TODO: GET TOTAL HOMEWORK COUNT  */
//
//            /* TODO: PAGING PROCESS */
//
//            /* TODO: GET HOMEWORK LIST */
//
//            return ResponseEntity.ok(1);
//
//        } catch (Exception e) {
//            log.error("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "insertHomework", e.getMessage());
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(0);
//
//        } finally {
//            log.info("[{}]{}:{}:{}", transactionId,  this.getClass().getSimpleName(), "insertHomework", "end");
//        }
//    }

}
