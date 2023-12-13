package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.PaymentService;
import com.oracle.projectGo.service.UsersService;
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
    private final UsersService us;
    private final GameService gs;
    private final PaymentService ps;

//-----------------------------------------------------------------

    // 구독 신청 - 리스트에서 구독할 컨텐츠 조회 페이지
    @RequestMapping(value = "/subscribeView")
    public String gameSubscribe(GameContents gameContents, Model model){

        // 리스트 조회
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());
        model.addAttribute("gameContentsList", gameContentsList);

        return "subscribe/subscribeView";
    }

//-----------------------------------------------------------------

    // 구독 신청 - 리스트에서 구독할 컨텐츠 클릭한 값들 처리
    // 교육자와 일반인만 구독할 수 있게 처리하기 !
    @RequestMapping(value = "/subscribeClick", method = RequestMethod.POST)
    public String gameSubscribePay(@RequestParam List<Integer> gameIds, Model model){
        log.info("gameIds: {}", gameIds);

        /* TODO : 로그인 한 유저 정보 = 구매자 정보 */
        Users users = us.getLoggedInUserInfo();
        log.info("로그인 userName : {}", users.getName());
        log.info("로그인 userId : {}", users.getId());
        log.info("로그인 userPhone : {}", users.getPhone());

//        Users users = new Users();
//        users.setId(6);
//        users.setName("차예지");
//        users.setPhone("010-1232-5674");

        /* TODO : 게임 ID리스트들로 게임정보 받아오기. 버전1 */
//        List<GameContents> gameContentsList =  gs.gameContentsListByIds(gameIds);
//        log.info("gameContentsList:{}",gameContentsList);

        /* TODO : 게임 ID리스트들로 게임정보 받아오기. 버전2 */
        List<GameContents> gameContentsList = new ArrayList<>();
        int totalPrice = 0;
        String title = "";

        for (Integer gameId : gameIds) {
            GameContents gameContents = gs.getGameContentsById(gameId);     // 각 아이디의 리스트 조회
            model.addAttribute("gameContents", gameContents);   // model 사용 안해도 될 것 같은데 확인하기

            // 결제 총 금액
            totalPrice += gameContents.getPrice();

            gameContentsList.add(gameContents);     // add()-> ArrayList에서 맨 뒤에 데이터 추가
        }
        System.out.println("-----------------");
        // 나중에 아무 클릭 안하고 구독하기 눌렀을 때 validation 커스텀으로 하기
        if(!gameContentsList.isEmpty()){
            title = gameContentsList.get(0).getTitle()+"외" + (gameContentsList.size()-1);
        }

        model.addAttribute("title", title);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("users", users);

        return "subscribe/subscribePay";        // 값들 처리 후 결제 페이지로 이동
    }

//-----------------------------------------------------------------

    // 결제 - 결제 방법 선택 후 결제
    @PostMapping(value = "subscriblePay")
    public String subscriblePay(){

        // 1. xml 에서 foreach문 비슷한 거 사용
        // 2. xml 에서 insert 문 하나가 서비스에서 for문으로 돌아가서 구독 신청한 게임id 갯수만큼 돌아간만틈 같은 dao가 호출
        // --> 서비스에서 트렌젝션 걸어야 함

        return "redirect:/subscribe/내 구독 상품 페이지";
    }




}
