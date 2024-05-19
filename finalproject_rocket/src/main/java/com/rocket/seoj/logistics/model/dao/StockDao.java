package com.rocket.seoj.logistics.model.dao;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Repository
@Slf4j
public class StockDao {

    public List<Map<String, Object>> selectAllBranch(SqlSession session) {
        return session.selectList("branch.selectAllBranch");
    }

    public List<Map<String, Object>> selectAllProduct(SqlSession session) {
        return session.selectList("product.selectAllProduct");
    }

    public List<Map<String, Object>> selectDaybyStock(SqlSession session, HashMap<String, Object> params) {
        return session.selectList("stock.selectDaybyStock", params);
    }

    public List<Map<String, Object>> selectStockByBranch(SqlSession session, HashMap<String, Object> params) {
        return session.selectList("stock.selectStockByBranch", params);
    }

    public List<Map<String, Object>> selectStockByProduct(SqlSession session, HashMap<String, Object> params) {
        return session.selectList("stock.selectDaybyStock", params);
    }

    public List<Map<String, Object>> stockLedger(SqlSession session, HashMap<String, Object> params) {
        return session.selectList("stock.selectInventoryReport", params);
    }
}
