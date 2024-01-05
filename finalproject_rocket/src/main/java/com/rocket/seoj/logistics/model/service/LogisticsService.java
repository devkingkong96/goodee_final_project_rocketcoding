package com.rocket.seoj.logistics.model.service;

import java.util.List;
import java.util.Map;

import com.rocket.seoj.logistics.model.dto.Inventory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
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
                            String columnId) throws DataAccessException {

        try {
            return dao.updateColumn(session, id, columnName, tableName, value, parentTableName, parentColumnId,
                                    parentColumnName, columnId);
        } catch (DataAccessException e) {
            throw e;
        }

    }

    @Transactional
    public boolean deleteInventoryAndAttachmentAndPrdIv(Long inventoryId) {
        // TODO Auto-generated method stub
		
		/*		int attachDeleteResult = dao.deleteInventoryAttach(session, inventoryId);
				System.out.println("attachDeleteResult " + attachDeleteResult);
				int prdInventoryDelResult = dao.deletePrdInventory(session, inventoryId);
				System.out.println("prdInventoryDelResult " + prdInventoryDelResult);*/
        int inventoryDeleteResult = dao.deleteInventoryColumn(session, inventoryId);
        System.out.println("inventoryDeleteResult " + inventoryDeleteResult);

        if (inventoryDeleteResult > 0) {
            return true;
        } else {
            return false;
        }
		
		/*		if (attachDeleteResult > 0 && inventoryDeleteResult > 0
				   && prdInventoryDelResult > 0) {
					System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return true;
				} else if (inventoryDeleteResult > 0) {
					System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return true;
				} else {
		
					System.out.println("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 실패ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return false;
				}*/
    }

    @Transactional
    public List<Map<String, Object>> selectWriteInventory() {
        return dao.selectWriteInventory(session);

    }

    public Map<String, Object> getProductInfo(long id) {
        return dao.getProductInfo(session, id);
    }

    public int insertInventory(Inventory formData) {
        return dao.insertInventory(session, formData);
    }
}
