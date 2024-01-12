package com.rocket.seoj.logistics.model.service;

import com.rocket.seoj.logistics.model.dao.ProductDao;
import com.rocket.seoj.logistics.model.dto.PrdAttach;
import com.rocket.seoj.logistics.model.dto.Product;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {

    private final ProductDao dao;
    private final SqlSession session;

/*    @Transactional
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

    }*/

    @Transactional
    public List<Map<String, Object>> selectAllProductAndPublisherAndFiles() {
        return dao.selectAllProductAndPublisherAndFiles(session);
    }

    @Transactional
    public List<Map<String, Object>> selectAllPublisher() {
        return dao.selectAllPublisher(session);
    }

    @Transactional
    public long insertProduct(Product params) {
        return dao.insertProduct(session, params);
    }

    @Transactional
    public List<Integer> insertProductAttach(List<PrdAttach> fileList) {
        return dao.insertProductAttach(session, fileList);
    }

    @Transactional
    public boolean isdelUpdateProduct(Long prdId) {
        return dao.isdelUpdateProduct(session, prdId);
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
        try {
            return dao.updateColumn(session, id, columnName, tableName, value, parentTableName, parentColumnId,
                                    parentColumnName, columnId);
        } catch (DataAccessException e) {
            throw e;
        }


    }

/*
    public boolean isdelUpdatePublisher(Long pubId) {
        return dao.isdelUpdatePublisher(session, pubId);
    }

    public long insertPublisher(HashMap<String, Object> params) {
        return dao.insertPublisher(session, params);
    }*/
}
