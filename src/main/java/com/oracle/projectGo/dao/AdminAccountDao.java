package com.oracle.projectGo.dao;

import com.oracle.projectGo.controller.admin.AdminAccountController;
import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class AdminAccountDao {
    private final SqlSession session;

    public List<Payments> listSales() {
        return session.selectList("listSales");
    }

    public int listSalesCount() {
        return session.selectOne("listSalesCount");
    }

    public List<Payments> saleSearchList(AdminAccountController.SearchForSales search) {
        return session.selectList("saleSearchList", search);
    }
}
