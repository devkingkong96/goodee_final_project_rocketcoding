package com.rocket.seoj.logistics.model.service;

import java.util.List;
import java.util.Map;

import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import com.rocket.seoj.logistics.model.dto.PrdInventory;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.seoj.logistics.model.dao.InventoryDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Log4j2
public class InventoryService {

    private final InventoryDao dao;
    private final SqlSession session;


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
		
		/*		int attachDeleteResult = dao.deleteInventoryAttach(session, inventoryId);
				log.debug("attachDeleteResult " + attachDeleteResult);
				int prdInventoryDelResult = dao.deletePrdInventory(session, inventoryId);
				log.debug("prdInventoryDelResult " + prdInventoryDelResult);*/
        int inventoryDeleteResult = dao.deleteInventoryColumn(session, inventoryId);

        // if문으로 감싸줘야함
        log.debug("inventoryDeleteResult " + inventoryDeleteResult);

        if (inventoryDeleteResult > 0) {
            return true;
        } else {
            return false;
        }
		
		/*		if (attachDeleteResult > 0 && inventoryDeleteResult > 0
				   && prdInventoryDelResult > 0) {
					log.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return true;
				} else if (inventoryDeleteResult > 0) {
					log.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 성공ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return true;
				} else {
		
					log.debug("ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ인벤토리 딜리트 실패ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
					return false;
				}*/
    }

    @Transactional
    public List<Map<String, Object>> selectWriteInventory() {
        return dao.selectWriteInventory(session);

    }

    @Transactional
    public Map<String, Object> getProductInfo(long id) {
        return dao.getProductInfo(session, id);
    }

    @Transactional
    public long insertInventory(Inventory formData) {
        dao.insertInventory(session, formData);
        return formData.getIvId();
    }

/*    public void insertInventoryAttachBatch(List<InventoryAttach> attachList) {
        try (

                int[] result = session
                        .getMapper(InventoryDao.class)
                        .insertInventoryAttachBatch(attachList)) {
            session.commit();
        } catch (Exception e) {
            session.rollback();
            throw e;
        }
    }*/

    @Transactional
    public List<Integer> insertInventoryAttach(List<InventoryAttach> fileList) {

        return dao.insertInventoryAttach(session, fileList);
    }

    @Transactional
    public List<Integer> insertPrdInventory(List<PrdInventory> prdInventory) {
        return dao.insertPrdInventory(session, prdInventory);
    }

    @Transactional
    public List<Map<String, Object>> selectAllBranch() {
        return dao.selectAllBranch(session);
    }

    @Transactional
    public List<Map<String, Object>> branchempinfo(long branchId) {
        return dao.branchempinfo(session, branchId);
    }
}
