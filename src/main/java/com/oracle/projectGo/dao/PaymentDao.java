package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class PaymentDao {

    private final SqlSession session;
// -----------------------------------------------------------

    // 결제하기 클릭 후 payments 테이블에 insert
    public int subscribePayInsert(Payments payments) {
        int subscribePayInsert = 0;
        try {
            subscribePayInsert = session.insert("subscribePayInsert", payments);
            System.out.println("PaymentDao subscribePayInsert-> " + subscribePayInsert);
        }catch (Exception e){
            System.out.println("PaymentDao subscribePayInsert e-> " + e);
        }
        return subscribePayInsert;
    }

// -----------------------------------------------------------

    // 내가 구독한 게임 컨텐츠 리스트 총 갯수
    public int subscribeUserPayTotalCount(int loginUserId) {
        int subscribeUserPayTotalCount = 0;
        try {
            subscribeUserPayTotalCount = session.selectOne("subscribeUserPayTotalCount", loginUserId);
            System.out.println("PaymentDao subscribeUserPayTotalCount-> " + subscribeUserPayTotalCount);
        } catch (Exception e) {
            System.out.println("PaymentDao subscribeUserPayTotalCount e-> " + e);
        }
        return subscribeUserPayTotalCount;
    }

    // 내가 구독한 게임 컨텐츠 리스트 조회
    public List<Payments> mySubscribePayList(Payments payments) {
        List<Payments> mySubscribePayList = new ArrayList<Payments>();
        try {
            mySubscribePayList = session.selectList("mySubscribePayList", payments);
            System.out.println("PaymentDao mySubscribePayList-> " + mySubscribePayList);
        }catch (Exception e){
            System.out.println("PaymentDao mySubscribePayList e-> " + e);
        }
        return mySubscribePayList;
    }

}

