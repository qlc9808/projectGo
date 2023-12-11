package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.service.AdminAccountService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpCookie;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/admin/account")
public class AdminAccountController {
    private final AdminAccountService adminAccountService;


    @GetMapping("/listSales")
    public String listSales(Payments payments, Model model) {
        return "/admin/account/listSales";
    }


    @GetMapping("/api/listSales")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> salesInfo() {
        // 결제정보 리스트 조회
        List<Payments> salesInfo = adminAccountService.listSales();
        log.info("listSales=>"+salesInfo.toString());

        for (Payments item: salesInfo) {
            switch (item.getPaymentType()) {
                case "1":
                    item.setPaymentType("무통장입금");
                    break;
                case "2":
                    item.setPaymentType("계좌이체");
                    break;
                case "3":
                    item.setPaymentType("카카오페이");
                    break;
            }
        }

        for (Payments item: salesInfo) {
            switch (item.getStatus()) {
                case "1":
                    item.setStatus("결제완료");
                    break;
                case "2":
                    item.setStatus("미결제");
                    break;
            }
        }

        // 결제 list count
        int count = adminAccountService.listSalesCount();
        log.info("listSalesCount=>"+count);

        Map<String, Object> response = new HashMap<>();
        response.put("salesInfo", salesInfo);
        response.put("count", count);

        System.out.println(salesInfo);

        return ResponseEntity.ok(response);
    }

    @GetMapping("/api/listSaleSearch")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> searchInfo(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "keywordDate1", required = false) String keywordDate1,
            @RequestParam(value = "keywordDate2", required = false) String keywordDate2,
            @RequestParam(value = "status", required = false) int status,
            @RequestParam(value = "searchType", required = false) String searchType
    ) {
        Map<String, Object> response = new HashMap<>();
        System.out.println("status->"+status);
        System.out.println("date->"+keywordDate1);
        System.out.println("date2->+"+keywordDate2);
        if (status == 3) {
            List<Payments> searchInfo = adminAccountService.listSales();

            for (Payments item: searchInfo) {
                switch (item.getPaymentType()) {
                    case "1":
                        item.setPaymentType("무통장입금");
                        break;
                    case "2":
                        item.setPaymentType("계좌이체");
                        break;
                    case "3":
                        item.setPaymentType("카카오페이");
                        break;
                }
            }

            for (Payments item: searchInfo) {
                switch (item.getStatus()) {
                    case "1":
                        item.setStatus("결제완료");
                        break;
                    case "2":
                        item.setStatus("미결제");
                        break;
                }
            }

            response.put("searchInfo", searchInfo);
            return ResponseEntity.ok(response);
        }

        // ajax 요청에서 불러온 parameter 값을 search 객체에 저장
        SearchForSales search = new SearchForSales();
        search.setKeyword(keyword);
        search.setKeywordDate1(keywordDate1);
        search.setKeywordDate2(keywordDate2);
        search.setStatus(status);
        search.setSearchType(searchType);

        List<Payments> saleSearchList = adminAccountService.saleSearchList(search);

        for (Payments item: saleSearchList) {
            switch (item.getPaymentType()) {
                case "1":
                    item.setPaymentType("무통장입금");
                    break;
                case "2":
                    item.setPaymentType("계좌이체");
                    break;
                case "3":
                    item.setPaymentType("카카오페이");
                    break;
            }
        }

        for (Payments item: saleSearchList) {
            switch (item.getStatus()) {
                case "1":
                    item.setStatus("결제완료");
                    break;
                case "2":
                    item.setStatus("미결제");
                    break;
            }
        }

        response.put("searchInfo", saleSearchList);

        return ResponseEntity.ok(response);
    }

    @Data
    public static class SearchForSales {
        private String keyword;
        private String keywordDate1;
        private String keywordDate2;
        private String searchType;
        private int status;
    }
}

