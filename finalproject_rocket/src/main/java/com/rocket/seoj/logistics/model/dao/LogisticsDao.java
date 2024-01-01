package com.rocket.seoj.logistics.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Repository
public class LogisticsDao {
	
	public List<Map<String, Object>> selectAllInventories(SqlSession session) {
		return session.selectList("inventory.selectAllInventories");
	}
	
	public int updateColumn(SqlSession session,
	                        long id,
	                        String columnName,
	                        String tableName,
	                        String value,
	                        String parentTableName,
	                        String parentColumnId,
	                        String parentColumnName,
	                        String columnId) {
		Map<String, Object> params = new HashMap<>();
		params.put("id", id);
		params.put("columnName", columnName);
		params.put("tableName", tableName);
		params.put("value", value);
		params.put("parentTableName", parentTableName);
		params.put("parentColumnId", parentColumnId);
		params.put("parentColumnName", parentColumnName);
		params.put("columnId", columnId);
		
		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + String.valueOf(id) + ", "
		   + columnName + ", " + tableName + ", " + value + ", " + parentTableName
		   + ", " + parentColumnId + ", " + parentColumnName + ", " + columnId);
		
		if (parentTableName.equals(tableName)) {
			return session.update("inventory.updateColumn_sameTable", params);
		} else {
			return session.update("inventory.updateColumn", params);
		}
	}
	
	public int deleteInventoryColumn(SqlSession session,
	                                 Long inventoryId) {
		return session.delete("inventory.deleteInventoryColumn", inventoryId);
	}
	
	public int deleteInventoryAttach(SqlSession session,
	                                 Long inventoryId) {
		return session.delete("inventory.deleteInventoryAttach", inventoryId);
	}
	
	public int deletePrdInventory(SqlSession session,
	                              Long inventoryId) {
		return session.delete("inventory.deletePrdInventory", inventoryId);
	}
	
}
