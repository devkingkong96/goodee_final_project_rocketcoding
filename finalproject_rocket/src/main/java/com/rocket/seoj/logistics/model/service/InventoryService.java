package com.rocket.seoj.logistics.model.service;

import com.rocket.seoj.logistics.model.dao.InventoryDao;
import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import com.rocket.seoj.logistics.model.dto.PrdInventory;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class InventoryService {

    private final InventoryDao dao;
    private final SqlSession session;


    @Transactional
    public List<Map<String, Object>> selectAllInventories(int branchId) {
        return dao.selectAllInventories(session, branchId);
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

        int inventoryDeleteResult = dao.deleteInventoryColumn(session, inventoryId);

        if (inventoryDeleteResult > 0) {
            return true;
        } else {
            return false;
        }
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

    @Transactional
    public List<Map<String, Object>> getEmpListByemployeeId() {
        return dao.getEmpListByemployeeId(session);
    }

    @Transactional
    public List<Map<String, Object>> selectAllProduct() {
        return dao.selectAllProduct(session);
    }

    @Transactional
    public ArrayList<Map<String, Object>> getInventoryInfoForCreateDocument(long generateId) {
        return dao.getInventoryInfoForCreateDocument(session, generateId);
    }
}
