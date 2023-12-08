package com.oracle.projectGo.service;

import com.oracle.projectGo.dao.AdminAccountDao;
import com.oracle.projectGo.dto.Payments;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminAccountService {
    private final AdminAccountDao adminAccountDao;
    public List<Payments> listSales(Payments payments) {
        return adminAccountDao.listSales(payments);
    }

    public int listSalesCount() {
        return adminAccountDao.listSalesCount();
    }
}
