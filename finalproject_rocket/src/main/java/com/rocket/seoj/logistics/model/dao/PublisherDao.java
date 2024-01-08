package com.rocket.seoj.logistics.model.dao;

import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

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
@Log4j2
public class PublisherDao {


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
                return session.update("publisher.updateColumn_sameTable", params);
            } else {
                return session.update("publisher.updateColumn", params);
            }
        } catch (DataAccessException e) {
            throw e;
        }

    }

    public List<Map<String, Object>> selectAllPublisher(SqlSession session) {
        return session.selectList("publisher.selectAllPublisher");
    }

}
