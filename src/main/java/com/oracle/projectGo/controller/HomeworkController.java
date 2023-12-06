package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.Homeworks;
import com.oracle.projectGo.service.Paging;
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

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkController {
    @RequestMapping(value = "listHomework")
    public String listHomework(Homeworks homework, String currentPage, Model model) {
        UUID transactionId = UUID.randomUUID();
        try {
            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(),"listHomework", "start");

            /* TODO: GET TOTAL HOMEWORK COUNT  */

            /* TODO: PAGING PROCESS */
            Paging page = new Paging(30, currentPage);
            homework.setStart(page.getStart());
            homework.setEnd(page.getEnd());
            /* TODO: GET HOMEWORK LIST */
            List<Homeworks> hwList = new ArrayList<Homeworks>();
            for (int i = 0; i < 10; i++) {
                Homeworks hw = new Homeworks();
                hw.setId(i);
                hw.setTitle("title"+i);
                hwList.add(hw);
            }
            /* TODO: SET ATTRIBUTE */

        } catch (Exception e) {
            log.error("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", e.getMessage());
        } finally {
            log.info("[{}]{}:{}:{}", transactionId,  this.getClass().getSimpleName(), "listHomework", "end");
        }
        return "educate/homework/listHomework";
    }

    @RequestMapping(value = "getRecommendations", method = RequestMethod.POST)
    public ResponseEntity getRecommendations(@RequestBody Homeworks homework) {
        UUID transactionId = UUID.randomUUID();
        try {
            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", "start");

            /* TODO: */

            /* TODO: */

            /* TODO: */
            return ResponseEntity.ok().build();

        } catch (Exception e) {
            log.error("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", "end");
        }
    }
}
