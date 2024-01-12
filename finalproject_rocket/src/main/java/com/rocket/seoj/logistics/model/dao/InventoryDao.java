package com.rocket.seoj.logistics.model.dao;

import com.rocket.seoj.logistics.model.dto.Inventory;
import com.rocket.seoj.logistics.model.dto.InventoryAttach;
import com.rocket.seoj.logistics.model.dto.PrdInventory;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Repository
@Slf4j
public class InventoryDao {

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
                            String columnId) throws DataAccessException {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("columnName", columnName);
        params.put("tableName", tableName);
        params.put("value", value);
        params.put("parentTableName", parentTableName);
        params.put("parentColumnId", parentColumnId);
        params.put("parentColumnName", parentColumnName);
        params.put("columnId", columnId);

        log.debug("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + String.valueOf(
                id) + ", " + columnName + ", " + tableName + ", " + value + ", " + parentTableName + ", " + parentColumnId + ", " + parentColumnName + ", " + columnId);

        try {

            if (parentTableName.equals(tableName)) {
                return session.update("inventory.updateColumn_sameTable", params);
            } else {
                return session.update("inventory.updateColumn", params);
            }
        } catch (DataAccessException e) {
            throw e;
        }

    }

    public int deleteInventoryColumn(SqlSession session, Long inventoryId) {
        return session.update("inventory.deleteInventoryColumn", inventoryId);

    }

    public int deleteInventoryAttach(SqlSession session, Long inventoryId) {
        return session.delete("inventoryattach.deleteInventoryAttach", inventoryId);
    }

    public int deletePrdInventory(SqlSession session, Long inventoryId) {
        return session.delete("prdinventory.deletePrdInventory", inventoryId);
    }

    public List<Map<String, Object>> selectWriteInventory(SqlSession session) {
        return session.selectList("inventory.selectWriteInventory");
    }

    public Map<String, Object> getProductInfo(SqlSession session, long id) {
        return session.selectOne("product.getProductInfo", id);
    }

    public long insertInventory(SqlSession session, Inventory formData) {
        return session.insert("inventory.insertInventory", formData);
    }


    public List<Integer> insertInventoryAttach(SqlSession session, List<InventoryAttach> fileList) {
        List<Integer> result = new ArrayList<>();

        for (InventoryAttach attach : fileList) {
            int resultOne = session.insert("inventoryattach.insertInventoryAttach", attach);

            result.add(resultOne);
        }

        return result;
    }

    public List<Integer> insertPrdInventory(SqlSession session, List<PrdInventory> prdInventory) {
        List<Integer> result = new ArrayList<>();
        for (PrdInventory prdIv : prdInventory) {
            int resultOne = session.insert("prdinventory.insertPrdInventory", prdIv);
            log.debug("ㄴㄴㄴㄴㄴㄴㄴㄴresultOneㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ " + resultOne);
            result.add(resultOne);
        }
        return result;
    }

    public List<Map<String, Object>> selectAllBranch(SqlSession session) {
        return session.selectList("branch.selectAllBranch");
    }

    public List<Map<String, Object>> branchempinfo(SqlSession session, long branchId) {
        return session.selectList("branch.branchempinfo", branchId);
    }

    public List<Map<String, Object>> getEmpListByemployeeId(SqlSession session, long branchId) {
        return session.selectList("inventory.employeeListInBranch", branchId);
    }

    public List<Map<String, Object>> selectAllProduct(SqlSession session) {
        return session.selectList("product.selectAllProduct");
    }

    /*    public ArrayList<Map<String, Object>> getInventoryInfoForCreateDocument(SqlSession session,
                                                                                Map<String, Object> paramMap) {
            // MyBatis로부터 List<Map<String, Object>> 형태의 결과를 받습니다.
            List<Map<String, Object>> resultMapList = session.selectList("inventory.getInventoryInfoForCreateDocument",
                                                                         paramMap);

            // 받은 결과를 ArrayList<Map<String, Object>>으로 변환합니다.
            ArrayList<Map<String, Object>> resultList = new ArrayList<>(resultMapList);

            return resultList;
        }*/
    public ArrayList<Map<String, Object>> getInventoryInfoForCreateDocument(SqlSession session, long ivId) {
        // MyBatis로부터 List<Map<String, Object>> 형태의 결과를 받습니다.
        List<Map<String, Object>> resultMapList = session.selectList("inventory.getInventoryInfoForCreateDocument",
                                                                     ivId);

        // 받은 결과를 ArrayList<Map<String, Object>>으로 변환합니다.
        ArrayList<Map<String, Object>> resultList = new ArrayList<>(resultMapList);

        return resultList;
    }

    /*
    public List<Integer> insertInventoryAttach(SqlSession session, List<InventoryAttach> fileList) {
//        return session.insert("inventoryattach.insertInventoryAttach", fileList);

        List<Integer> result = new ArrayList<>();
        try {
            result = new ArrayList<>();
            session = SqlSessionFactory.openSession(ExecutorType.BATCH) {
                for (InventoryAttach attach : fileList) {
                    int resultOne = session.insert("inventoryattach.insertInventoryAttach", attach);
                    result.add(resultOne);
                }
                return result;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } return result;
    }


    public List<Integer> insertInventoryAttach(List<InventoryAttach> fileList) {
        List<Integer> result = new ArrayList<>();

        try (SqlSession session = sqlSessionFactory.openSession(ExecutorType.BATCH)) {
            for (InventoryAttach attach : fileList) {
                int resultOne = session.insert("inventoryattach.insertInventoryAttach", attach);
                result.add(resultOne);
            }
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }*/


/*    public int[] insertInventoryAttachBatch(List<InventoryAttach> attachList) {
        return attachList
                .stream()
                .mapToInt(attach -> insertInventoryAttach(attach))
                .toArray();
    }*/

/*    private int insertInventoryAttach(SqlSession session, InventoryAttach attach) {
        return session.insert("inventoryattach.insertInventoryAttach", attach);
    }*/
}
