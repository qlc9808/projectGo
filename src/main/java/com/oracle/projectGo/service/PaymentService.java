package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.PaymentDao;
import com.oracle.projectGo.dto.GameContents;
import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentDao pd;
// -----------------------------------------------------------

    // 결제하기 클릭 후 payments 테이블에 insert



}