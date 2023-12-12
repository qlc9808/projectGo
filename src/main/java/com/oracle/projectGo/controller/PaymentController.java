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

    // 구독 신청 - 리스트에서 구독할 컨텐츠 조회 페이지
    @RequestMapping(value = "/gameSubscribe")
    public String gameSubscribe(GameContents gameContents, Model model){

        // 리스트 조회
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());
        model.addAttribute("gameContentsList", gameContentsList);

        return "subscribe/gameSubscribe";
    }

//-----------------------------------------------------------------

    // 구독 신청 - 리스트에서 구독할 컨텐츠 클릭해서 페이지 이동됨
    @RequestMapping(value = "gameSubscribeClick", method = RequestMethod.POST)
    public String gameSubscribePay(@RequestParam List<Integer> gameIds, Model model){
        log.info("gameIds: {}", gameIds);

        /* TODO :유저 정보 불러오기 (맨 마지막에 userService에서 selectUserById 메서드가 만들어지면..) 유저아이디로  정보 가져오기*/
        Users user = new Users();
        user.setId(1);
        user.setName("실제 userId가 1인 userName으로 넣기");
        user.setPhoneNumber("이것도");

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

            /* TODO : 총 금액 구하는 로직*/
            totalPrice += gameContents.getPrice();

            gameContentsList.add(gameContents);     // ArrayList에서 맨 뒤에 데이터 추가
        }
        System.out.println("-----------------");
        // 나중에 아무 클릭 안하고 구독하기 눌렀을 때 validation 커스텀으로 하기
        if(!gameContentsList.isEmpty()){
            title = gameContentsList.get(0).getTitle()+"외" + (gameContentsList.size()-1);
        }

        /* TODO : 화면에 필요한 정보 셋팅 */
        model.addAttribute("title", title);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("user", user);

        return "redirect:/subscribe/index";

        // redirect 해도 index.jsp에 title이랑 totalPrice 의 값이 나오는지 띄어보기 안 나오면 forward 사용
        // index 는 결제하기 페이지로 사용
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
