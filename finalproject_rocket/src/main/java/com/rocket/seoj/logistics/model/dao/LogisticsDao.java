package com.rocket.seoj.logistics.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.seoj.logistics.model.dto.Inventory;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Repository
public class LogisticsDao {
	
	public List<Inventory> selectAllInventories(SqlSession session) {
		return session.selectList("inventory.selectAllInventories");
	}
	
}
