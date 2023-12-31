package com.rocket.seoj.logistics.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.seoj.logistics.model.dao.LogisticsDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LogisticsService {
	
	private final LogisticsDao dao;
	private final SqlSession session;
	
	// 가안
	@Transactional
	public List<Map<String, Object>> selectAllInventories() {
		return dao.selectAllInventories(session);
	}
	
	@Transactional
	public int updateColumn(long id,
	                        String columnName,
	                        String tableName,
	                        String value,
	                        String parentTableName,
	                        String parentColumnId,
	                        String parentColumnName,
	                        String columnId) {
		return dao.updateColumn(session, id, columnName, tableName, value,
		                        parentTableName, parentColumnId, parentColumnName,
		                        columnId);
	}
	
	@Transactional
	public boolean deleteInventoryAndAttachmentAndPrdIv(Long inventoryId) {
		// TODO Auto-generated method stub
		int attachDeleteResult = dao.deleteInventoryAttach(session, inventoryId);
		System.out.println("attachDeleteResult " + attachDeleteResult);
		int prdInventoryDelResult = dao.deletePrdInventory(session, inventoryId);
		System.out.println("prdInventoryDelResult " + prdInventoryDelResult);
		int inventoryDeleteResult
		   = dao.deleteInventoryColumn(session, inventoryId);
		System.out.println("inventoryDeleteResult " + inventoryDeleteResult);
		
		// 두 작업 중 하나라도 실패하면 롤백됩니다.
		if (attachDeleteResult > 0 && inventoryDeleteResult > 0
		   && prdInventoryDelResult > 0) {
			System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
			return true;
		} else if (inventoryDeleteResult > 0) {
			System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
			return true;
		} else {
			// 예외를 던지거나 false를 반환하여 롤백됨을 나타낼 수 있습니다.
			System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 실패ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
			return false;
		}
	}
	
}
