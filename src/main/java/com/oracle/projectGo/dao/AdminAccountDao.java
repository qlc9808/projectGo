package com.oracle.projectGo.dao;

import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class AdminAccountDao {
    private final SqlSession session;

    public List<Payments> listSales(Payments payments) {
        return session.selectList("listSales",payments);
    }

    public int listSalesCount() {
        return session.selectOne("listSalesCount");
    }
}
