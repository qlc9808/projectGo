package com.oracle.projectGo.dao;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class PaymentDao {

    private final SqlSession session;
// -----------------------------------------------------------

    // 결제하기 클릭 후 payments 테이블에 insert








}
