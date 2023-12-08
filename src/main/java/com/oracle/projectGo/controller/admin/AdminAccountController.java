package com.oracle.projectGo.controller.admin;

import com.oracle.projectGo.dto.Payments;
import com.oracle.projectGo.service.AdminAccountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
    public ResponseEntity<Map<String, Object>> salesInfo(Payments payments) {
        // 결제정보 리스트 조회
        List<Payments> salesInfo = adminAccountService.listSales(payments);
        log.info("listSales=>"+salesInfo.toString());

        // 결제 list count
        int count = adminAccountService.listSalesCount();
        log.info("listSalesCount=>"+count);

        Map<String, Object> response = new HashMap<>();
        response.put("salesInfo", salesInfo);
        response.put("count", count);

        return ResponseEntity.ok(response);
    }
}
