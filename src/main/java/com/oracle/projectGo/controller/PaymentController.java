package com.oracle.projectGo.controller;

import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.dto.Users;
import com.oracle.projectGo.service.GameService;
import com.oracle.projectGo.service.Paging;
import com.oracle.projectGo.service.PaymentService;
import com.oracle.projectGo.service.UsersService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/subscribe")
public class PaymentController {

    private final UsersService us;
    private final GameService gs;
    private final PaymentService ps;
//-----------------------------------------------------------------

    // 구독 신청 - 리스트에서 구독할 컨텐츠 조회 페이지
    @RequestMapping(value = "/subscribeView")
    public String gameSubscribe(String currentPage, Model model) {

        // 총 갯수
        int gameContentsTotalCount = gs.gameContentsTotalCount();
        System.out.println("GameController gameContentsTotalCount-> " + gameContentsTotalCount);
        model.addAttribute("gameContentsTotalCount", gameContentsTotalCount);

        // 페이징 작업
        GameContents gameContents = new GameContents();
        Paging page = new Paging(gameContentsTotalCount, currentPage);
        gameContents.setStart(page.getStart());
        gameContents.setEnd(page.getEnd());
        model.addAttribute("page", page);

        // 리스트 조회
        List<GameContents> gameContentsList = gs.gameContentsList(gameContents);
        System.out.println("GameController gameContentsList.size()-> " + gameContentsList.size());
        model.addAttribute("gameContentsList", gameContentsList);

        return "subscribe/subscribeView";
    }

//-----------------------------------------------------------------

    // 구독 신청 - 리스트에서 구독할 컨텐츠 클릭한 값들 처리
    @RequestMapping(value = "/subscribeClick", method = RequestMethod.POST)
    public String gameSubscribePay(@RequestParam List<Integer> gameIds, Model model) {
        log.info("gameIds: {}", gameIds);

        // 로그인 한 유저 정보 = 구매자 정보
        Users users = us.getLoggedInUserInfo();
        log.info("로그인 userName  : {}", users.getName());
        log.info("로그인 userId    : {}", users.getId());
        log.info("로그인 userPhone : {}", users.getPhone());

        // 게임 ID 리스트들로 게임정보 받아오기 (버전1)
//      List<GameContents> gameContentsList =  gs.gameContentsListByIds(gameIds);
//      log.info("gameContentsList:{}",gameContentsList);

        // 게임 ID 리스트들로 게임 정보 받아오기 (버전2)
        List<GameContents> gameContentsList = new ArrayList<>();
        int totalPrice = 0;
        String title = "";

        for (Integer gameId : gameIds) {
            GameContents gameContents = gs.getGameContentsById(gameId);     // 각 아이디들의 리스트 조회
            totalPrice += gameContents.getPrice();                          // 결제 총 금액
            gameContentsList.add(gameContents);                             // add()-> ArrayList에서 맨 뒤에 데이터 추가
        }

        // 나중에 아무 클릭 안하고 구독 하기 눌렀을 때 validation 커스텀으로 하기
        if (!gameContentsList.isEmpty()) {
            title = gameContentsList.get(0).getTitle() + " 외 " + (gameContentsList.size() - 1);
        }

        model.addAttribute("gameIds", gameIds);
        model.addAttribute("title", title);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("users", users);

        return "subscribe/subscribePay";
    }

//-----------------------------------------------------------------

    // 결제 - 결제 방법 선택 후 결제
    @PostMapping(value = "/subscribePay")
    public String subscribePay(@RequestParam String gameIds, @RequestParam String paymentType) {
        System.out.println("PaymentController subscribePay !");
        System.out.println("클릭한 gameIds-> " + gameIds);

        // 로그인 한 유저 정보 = 구매자 정보
        Users users = us.getLoggedInUserInfo();
        log.info("로그인 loginUserId : {}", users.getId());
        int loginUserId = users.getId();

        // gameIds 값 확인
        for (String gameId : gameIds.split(",")){
            String cleanGameId = gameId.replaceAll("[^0-9]", ""); // 숫자 이외의 모든 문자 제거
            System.out.println("cleanGameId-> " + cleanGameId);

            // 결제하기 클릭 후 payments 테이블에 insert
            ps.subscribePayInsert(loginUserId, Integer.parseInt(cleanGameId), paymentType);
        }
        return "redirect:/subscribe/subscribeUserPay";
    }

    // 내가 구독한 게임 컨텐츠 리스트 조회
    @GetMapping(value = "/subscribeUserPay")
    public String subscribeUserPay(String currentPage, Model model) {

        Users users = us.getLoggedInUserInfo();
        log.info("로그인 loginUserId : {}", users.getId());
        int loginUserId = users.getId();

        // 내가 구독한 게임 컨텐츠 리스트 총 갯수
        int subscribeUserPayTotalCount = ps.subscribeUserPayTotalCount(loginUserId);
        System.out.println("PaymentController subscribeUserPay subscribeUserPayTotalCount-> " + subscribeUserPayTotalCount);
        model.addAttribute("subscribeUserPayTotalCount", subscribeUserPayTotalCount);

        // 페이징 작업
        Payments payments = new Payments();
        Paging page = new Paging(subscribeUserPayTotalCount, currentPage);
        payments.setStart(page.getStart());
        payments.setEnd(page.getEnd());
        model.addAttribute("page", page);

        // 내가 구독한 게임 컨텐츠 리스트 조회
        payments.setUserId(loginUserId);
        List<Payments> mySubscribePayList = ps.mySubscribePayList(payments);
        System.out.println("PaymentController subscribeUserPay mySubscribePayList-> " + mySubscribePayList);
        model.addAttribute("mySubscribePayList", mySubscribePayList);

        return "subscribe/subscribeUserPay";
    }




}
