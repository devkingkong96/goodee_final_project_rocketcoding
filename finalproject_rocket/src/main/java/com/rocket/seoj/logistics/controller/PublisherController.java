package com.rocket.seoj.logistics.controller;


import com.rocket.common.Getrequest;
import com.rocket.seoj.logistics.model.dto.Publisher;
import com.rocket.seoj.logistics.model.service.PublisherService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.*;

import static com.rocket.common.Getrequest.getParameterMap;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-25
 */
@Controller
@RequestMapping("/logistics")
@RequiredArgsConstructor
@Slf4j
public class PublisherController {

    private final PublisherService service;

    /*	@ExceptionHandler (DataAccessException.class)
        public ResponseEntity<Object>
               handleDataAccessException(DataAccessException ex,
                                         WebRequest request) {
            Map<String, Object> body = new LinkedHashMap<>();
            body.put("timestamp", LocalDateTime.now());
            body.put("message", "업데이트 실패");

            return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
        }*/
/*    public static HashMap<String, Object> getParameterMap(HttpServletRequest request) {

        HashMap<String, Object> parameterMap = new HashMap<String, Object>();
        Enumeration enums = request.getParameterNames();

        while (enums.hasMoreElements()) {
            String paramName = (String)enums.nextElement();
            String[] parameters = request.getParameterValues(paramName);

            if (parameters.length > 1) {
                parameterMap.put(paramName, parameters);
            } else {
                parameterMap.put(paramName, parameters[0]);
            }
        }
        return parameterMap;
    }*/
//    public HashMap<String, Object> getParameterMap(HttpServletRequest request) {
//
//        HashMap<String, Object> parameterMap = new HashMap<String, Object>();
//
//        Enumeration<String> enums = request.getParameterNames();
//
//        while (enums.hasMoreElements()) {
//            String paramName = (String)enums.nextElement();
//            log.error("ㅁㄴ라ㅣㅈ가미ㅓㅇ미ㅏ어ㅣㅏㅁ어ㅣㅏ모리ㅏㅁ롸졷ㅂ : " + paramName);
//            String[] parameters = request.getParameterValues(paramName);
//            log.error("?????????????????????????????????????? : " + parameters);
//            if (parameters.length > 1) {
//                parameterMap.put(paramName, parameters);
//            } else {
//                parameterMap.put(paramName, parameters[0]);
//            }
//        }
//
//        return parameterMap;
//    }

    @PostMapping("/publisher/list/insert")
    public ResponseEntity<?> insertPublisher(HttpServletRequest request) {

        HashMap<String, Object> params = Getrequest.getParameterMap(request);
//        params.put("pubId", 0);
        log.debug("{}", params);
        // param.stream().map(e->)
        long selectKey = service.insertPublisher(params);
        log.debug("selectKey : " + params.get("pubId"));
        if (selectKey != 0) {
            return ResponseEntity
                    .ok()
                    .body(Map.of("message", "추가 완료", "status", "success", "selectKey", params.get("pubId")));
        } else {

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "추가 실패", "status", "error"));
        }
    }

    @PostMapping("publisher/list/delete")
    public ResponseEntity<?> deleteInventoryAndAttachments(@RequestParam("pub_id") Long pubId) {

        log.debug("딜리트: " + pubId);
        boolean deletionSuccess = service.isdelUpdatePublisher(pubId);


        if (deletionSuccess) {

            return ResponseEntity
                    .ok()
                    .body(Map.of("message", "삭제 성공", "status", "success"));
        } else {

            return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("message", "삭제 실패", "status", "error"));
        }
    }

    @PostMapping("/publisher/list/tableupdate")
    public ResponseEntity<?> updateTable(SQLException ex,
                                         @RequestParam("id") long id,
                                         @RequestParam("columnName") String columnName,
                                         @RequestParam("tableName") String tableName,
                                         @RequestParam("value") String value,
                                         @RequestParam("parentTableName") String parentTableName,
                                         @RequestParam("parentColumnName") String parentColumnName) throws DataAccessException {
        log.debug("parentTableName : " + parentTableName);

        String parentColumnId = tableIdColumnMap.get(parentTableName.toUpperCase());
        String columnId = tableIdColumnMap.get(tableName);

        if (parentColumnName.equals("IV_VAT_TYPE")) {
            value = value.toUpperCase();
        }

        log.debug("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ컨트롤러ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + String.valueOf(
                id) + ", " + columnName + ", " + tableName + ", " + value + ", " + parentTableName + ", " + parentColumnId + ", " + parentColumnName + ", " + columnId);

        log.debug("업데이트 실행합니다");
        int result = 0;

        try {

            result = service.updateColumn(id, columnName, tableName.toUpperCase(), value, parentTableName.toUpperCase(),
                                          parentColumnId, parentColumnName, columnId);
            log.debug("result : " + result);

            if (result > 0) {

                return ResponseEntity
                        .ok()
                        .body("업데이트 성공");
            } else {

                return ResponseEntity
                        .badRequest()
                        .body("업데이트 실패");
            }
        } catch (DataAccessException e) {
            return ResponseEntity
                    .badRequest()
                    .body("업데이트 실패");
        }

    }


    @RequestMapping("/publisher/list")
    public String selectAllBranch(Model model) {

        List<Map<String, Object>> publisherList = service.selectAllPublisher();

        model.addAttribute("publisherList", publisherList);

        return "logistics/publisherPage";
    }

    private Map<String, String> tableIdColumnMap = new HashMap<String, String>() {

        {
            put("EMPLOYEE", "EMP_NO");
            put("INVENTORY", "IV_ID");
            put("BRANCH", "BRANCH_ID");
            put("STOCK", "STK_ID");
            put("PUBLISHER", "PUB_ID");
            put("PRODUCT", "PRD_ID");
            put("PRD_ATTACH", "PRD_FILE_ID");
            put("PRDINVENTORY", "PRD_IV_ID");
            put("INVENTORY_ATTACH", "IV_FILE_ID");
            put("TAG", "DOC_TAG");
            put("DOCUMENT", "DOC_NO");
            put("APPROVAL", "APRV_NO");
            put("APPROVAL_FILE", "APRVFILE_NO");
        }
    };

    public void printFieldNames(Object obj) {
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();

        log.debug("Field names of class " + objClass.getName() + ":");
        for (Field field : fields) {
            log.debug(field.getName());
        }
    }

    public String clobToString(Clob data) {
        StringBuilder sb = new StringBuilder();

        try {
            Reader reader = data.getCharacterStream();
            BufferedReader br = new BufferedReader(reader);

            String line;

            while (null != (line = br.readLine())) {
                sb.append(line);
            }
            br.close();
        } catch (SQLException | IOException e) {

        }
        return sb.toString();
    }
}
