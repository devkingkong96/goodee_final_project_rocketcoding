package com.rocket.seoj.logistics.model.dao;


import com.rocket.seoj.logistics.model.dto.PrdAttach;
import com.rocket.seoj.logistics.model.dto.Product;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@Slf4j
public class ProductDao {

    public List<Map<String, Object>> selectAllProductAndPublisherAndFiles(SqlSession session) {
        return session.selectList("product.selectAllProductAndPublisherAndFiles");
    }

    public List<Map<String, Object>> selectAllPublisher(SqlSession session) {
        return session.selectList("publisher.selectAllPublisher");
    }

    public long insertProduct(SqlSession session, Product params) {
        return session.insert("product.insertProduct", params);
    }


    public List<Integer> insertProductAttach(SqlSession session, List<PrdAttach> fileList) {
        List<Integer> result = new ArrayList<>();

        for (PrdAttach attach : fileList) {
            int resultOne = session.insert("productattach.insertProductAttach", attach);

            result.add(resultOne);
        }

        return result;
    }

    public boolean isdelUpdateProduct(SqlSession session, Long prdId) {
        return session.update("product.isdelUpdateProduct", prdId) > 0;
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

        try {

            if (parentTableName.equals(tableName)) {
                return session.update("product.updateColumn_sameTable", params);
            } else {
                return session.update("product.updateColumn", params);
            }
        } catch (DataAccessException e) {
            throw e;
        }
    }

}
