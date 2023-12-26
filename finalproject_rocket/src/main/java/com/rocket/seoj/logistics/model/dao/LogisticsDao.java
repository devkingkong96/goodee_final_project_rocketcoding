package com.rocket.seoj.logistics.model.dao;

import com.rocket.seoj.logistics.model.dto.Inventory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Repository
public class LogisticsDao {

    public List<Inventory> getAllItems(SqlSession session) {
        return session.selectList("inventory.getAllItems");
    }
}
