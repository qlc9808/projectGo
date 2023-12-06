package com.oracle.projectGo.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.UUID;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/homework")
public class HomeworkController {
    @RequestMapping(value = "listHomework")
    public String listHomework(String currentPage, Model model) {
        UUID transactionId = UUID.randomUUID();
        try {
            log.info("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(),"listHomework", "start");

            /* TODO: */

            /* TODO: */

            /* TODO: */


        } catch (Exception e) {
            log.error("[{}]{}:{}:{}", transactionId, this.getClass().getSimpleName(), "listHomework", e.getMessage());
        } finally {
            log.info("[{}]{}:{}:{}", transactionId,  this.getClass().getSimpleName(), "listHomework", "end");
        }
        return "educate/homework/listHomework";
    }
}
