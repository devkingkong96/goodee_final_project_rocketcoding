package com.rocket.seoj.logistics.model.service;

import com.rocket.seoj.logistics.model.dao.StockDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j
public class StockService {
    private final StockDao dao;
    private final SqlSession session;

    @Transactional
    public List<Map<String, Object>> selectAllBranch() {
        return dao.selectAllBranch(session);
    }

    @Transactional
    public List<Map<String, Object>> selectAllProduct() {
        return dao.selectAllProduct(session);
    }

    public List<Map<String, Object>> selectDaybyStock(HashMap<String, Object> params) {
        return dao.selectDaybyStock(session, params);
    }

    public List<Map<String, Object>> selectStockByBranch(HashMap<String, Object> params) {
        return dao.selectStockByBranch(session, params);
    }

    public List<Map<String, Object>> selectStockByProduct(HashMap<String, Object> params) {
        return dao.selectStockByProduct(session, params);
    }

    public List<Map<String, Object>> stockLedger(HashMap<String, Object> params) {
        return dao.stockLedger(session, params);
    }
}
