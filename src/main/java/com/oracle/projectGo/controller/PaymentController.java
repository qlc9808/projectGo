package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.PaymentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/payment")
public class PaymentController {

    private final GameService gs;
    private final PaymentService ps;

//-----------------------------------------------------------------

    // 구독 신청 - 리스트 조회
    @RequestMapping(value = "/gameSubscribe")
    public String gameSubscribe(GameContents gameContents, Model model){

        // 리스트 조회
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());
        model.addAttribute("gameContentsList", gameContentsList);

        return "subscribe/gameSubscribe";
    }

    // 구독 신청 - 리스트에서 구독할 컨텐츠 클릭
    @PostMapping(value = "/gameSubscribeClick")
    public String gameSubscribePay(Payments payments, Model model){

        return "redirect:gameContent";
    }

//-----------------------------------------------------------------

    // 결제 - 결제 할 내용 조회
    @RequestMapping(value = "/subscribleContent")
    public String subscribleContent(){

        return "subscribe/subscriblePay";
    }

    // 결제 - 결제 방법 선택 후 결제
    @PostMapping(value = "subscriblePay")
    public String subscriblePay(){

        return "subscribe/subscriblePay";
    }




}
