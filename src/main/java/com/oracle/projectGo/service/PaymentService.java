package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.PaymentDao;
import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentDao pd;
// -----------------------------------------------------------

    // 결제하기 클릭 후 payments 테이블에 insert
    @Transactional
    public void subscribePayInsert(int loginUserId, int contentId, String paymentType) {
            Payments payments = new Payments();
            payments.setUserId(loginUserId);
            payments.setContentId(contentId);
            payments.setPaymentType(paymentType);
            System.out.println("PaymentService subscribePayInsert loginUserId->> " + loginUserId);
            System.out.println("PaymentService subscribePayInsert contentId->> " + contentId);
            System.out.println("PaymentService subscribePayInsert paymentType->> " + paymentType);

            try {
                int subscribePayInsert  = pd.subscribePayInsert(payments);
                System.out.println("PaymentDao subscribePayInsert-> " + subscribePayInsert);
            }catch (Exception e){
                System.out.println("PaymentDao subscribePayInsert e-> " + e);
            }
        }

// -----------------------------------------------------------
    // 내가 구독한 게임 컨텐츠 리스트 총 갯수
    public int subscribeUserPayTotalCount(int loginUserId) {
        int subscribeUserPayTotalCount = pd.subscribeUserPayTotalCount(loginUserId);
        System.out.println("PaymentService subscribeUserPayTotalCount-> " + subscribeUserPayTotalCount);

        return subscribeUserPayTotalCount;
    }

    // 내가 구독한 게임 컨텐츠 리스트 조회
    public List<Payments> mySubscribePayList(Payments payments) {
        List<Payments> mySubscribePayList = pd.mySubscribePayList(payments);
        System.out.println("PaymentService mySubscribePayList-> " + mySubscribePayList);

        return mySubscribePayList;
    }

}





