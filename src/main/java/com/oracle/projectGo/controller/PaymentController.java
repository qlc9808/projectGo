package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.PaymentService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
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
    @RequestMapping(value = "gameSubscribeClick", method = RequestMethod.POST)
    public String gameSubscribePay(@RequestParam List<Integer> gameIds, Model model){
        log.info("gameIds:{}",gameIds);

        /* TODO :유저 정보 불러오기 (맨 마지막에 userService에서 selectUserById 메서드가 만들어지면..) 유저아이디로  정보 가져오기*/
        int userId = 1;
        Users user = new Users();
        user.setName("홍길동");
        user.setPhoneNumber("010-1234-5678");


        /* TODO : 게임 ID리스트들로 게임정보 받아오기. 버전1 */
//        List<GameContents> gameContentsList =  gs.gameContentsListByIds(gameIds);
//        log.info("gameContentsList:{}",gameContentsList);

        /* TODO : 게임 ID리스트들로 게임정보 받아오기. 버전2 */
        List<GameContents> gameContentsList = new ArrayList<>();
        int totalPrice = 0;
        String title = "";

        for (Integer gameId : gameIds) {
//            GameContents gameContents = gs.getGameContentsById(gameId);
//
//            /* TODO : 총 금액 구하는 로직*/
//            totalPrice += gameContents.getPrice();
//
//            gameContentsList.add(gameContents);
        }
        if(!gameContentsList.isEmpty()){
            title = gameContentsList.get(0).getTitle()+"외" + (gameContentsList.size()-1);
        }

        /* TODO : 화면에 필요한 정보 셋팅*/
        model.addAttribute("title", title);
        model.addAttribute("totalPrice", totalPrice);
        /* ID리스트 , 유저정보 */

        return "redirect:/subscribe/index";
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
