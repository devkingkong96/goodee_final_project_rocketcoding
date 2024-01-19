package com.rocket.seoj.logistics.controller;

import com.rocket.common.Getrequest;
import com.rocket.seoj.logistics.model.service.StockService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.lang.reflect.Field;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.*;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2024-01-12
 */
@Controller
@RequestMapping("/logistics")
@RequiredArgsConstructor
@Slf4j
public class StockController {

    private final StockService service;
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

    @RequestMapping("stock/ledger")
    public String stockLedger(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);

 /*       for (Map.Entry<String, Object> entry : params.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();

            // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
            if (value instanceof String[]) {
                log.error(key + ": " + Arrays.toString((String[])value));
            } else {
                log.error(key + ": " + value);
            }
        }
*/
        Map<String, String[]> paramMap = request.getParameterMap();

// branchId와 prdId 파라미터를 배열로 추출
        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

// 배열을 List로 변환
        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0"); // '0'을 기본값으로 사용
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0"); // '0'을 기본값으로 사용
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.stockLedger(params);

        // daybyStockList의 각 항목에 대해 반복
/*        for (Map<String, Object> item : daybyStockList) {
            log.error("================================================");
            // 각 Map의 키-값 쌍에 대해 반복
            for (Map.Entry<String, Object> entry : item.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
                if (value instanceof String[]) {
                    log.error("Key: " + key + ", Value: " + Arrays.toString((String[])value));
                } else {
                    log.error("Key: " + key + ", Value: " + value);
                }
            }
        }*/

        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            /*            log.error("{}", popPrdId);*/
            if (!prdIdSet.contains(popPrdId)) {
                prdIdSet.add(popPrdId);
                uniqueList.add(map);
            }
        }


        List<Map<String, Object>> branchNameUniqueList = new ArrayList<>();

        Set<Object> brcNameSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popBrcName = map.get("BRANCH_NAME");
            if (!brcNameSet.contains(popBrcName)) {

                brcNameSet.add(popBrcName);
//                log.error("popBrcName : {}", popBrcName);
                branchNameUniqueList.add(map);
            }
        }
        model.addAttribute("daybyStockList", daybyStockList);
        model.addAttribute("branchNameUniqueList", branchNameUniqueList);

        return "logistics/StockLedgerPage";
    }

    @RequestMapping("stock/searchledger")
    public String searchLedger(Model model) {
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        model.addAttribute("branchList", branchList);
        model.addAttribute("productList", selectAllProduct);
        return "logistics/searchStockLedger";
//        return "redirect:/logistics/searchDaybyStock";
        /*        return "logistics/searchDaybyStock";*/
    }


    @RequestMapping("stock/branchbyheigt")
    public String selectStockByProduct(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);

        for (Map.Entry<String, Object> entry : params.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();

            // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
            if (value instanceof String[]) {
                log.error(key + ": " + Arrays.toString((String[])value));
            } else {
                log.error(key + ": " + value);
            }
        }

        Map<String, String[]> paramMap = request.getParameterMap();

// branchId와 prdId 파라미터를 배열로 추출
        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

// 배열을 List로 변환
        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0"); // '0'을 기본값으로 사용
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0"); // '0'을 기본값으로 사용
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.selectStockByProduct(params);

        // daybyStockList의 각 항목에 대해 반복
        for (Map<String, Object> item : daybyStockList) {
            log.error("================================================");
            // 각 Map의 키-값 쌍에 대해 반복
            for (Map.Entry<String, Object> entry : item.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
                if (value instanceof String[]) {
                    log.error("Key: " + key + ", Value: " + Arrays.toString((String[])value));
                } else {
                    log.error("Key: " + key + ", Value: " + value);
                }
            }
        }

        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            /*            log.error("{}", popPrdId);*/
            if (!prdIdSet.contains(popPrdId)) {
                prdIdSet.add(popPrdId);
                uniqueList.add(map);
            }
        }


        List<Map<String, Object>> branchNameUniqueList = new ArrayList<>();

        Set<Object> brcNameSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popBrcName = map.get("BRANCH_NAME");
            if (!brcNameSet.contains(popBrcName)) {

                brcNameSet.add(popBrcName);
//                log.error("popBrcName : {}", popBrcName);
                branchNameUniqueList.add(map);
            }
        }
        model.addAttribute("daybyStockList", daybyStockList);
        model.addAttribute("branchNameUniqueList", branchNameUniqueList);

        return "logistics/heihtBranchByStockPage";
    }

    @RequestMapping("stock/branchby")
    public String selectStockByBranch(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);


        Map<String, String[]> paramMap = request.getParameterMap();

// branchId와 prdId 파라미터를 배열로 추출
        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");
//        if (prdIdArray != null) {
//            for (String prdId : prdIdArray) {
//                log.error("prdId: " + (prdId != null ? prdId : "null") + " dddddddddddddddddddddddddd");
//            }
//        } else {
//            log.error("prdId: null");
//        }
// 배열을 List로 변환
        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty() || branchIdList
                .get(0)
                .equals("")) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0"); // '0'을 기본값으로 사용
        }
        if (prdIdList == null || prdIdList.isEmpty() || prdIdList
                .get(0)
                .equals("")) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0"); // '0'을 기본값으로 사용
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.selectStockByBranch(params);


        // daybyStockList의 각 항목에 대해 반복
        for (Map<String, Object> item : daybyStockList) {
            // 각 Map의 키-값 쌍에 대해 반복
            log.error("================================================");
            for (Map.Entry<String, Object> entry : item.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

                // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
                if (value instanceof String[]) {
                    log.error("Key: " + key + ", Value: " + Arrays.toString((String[])value));
                } else {
                    log.error("Key: " + key + ", Value: " + value);
                }
            }
        }

        if (prdIdList.contains("0")) {
            // prdIdList를 새로운 값들로 채우기
            prdIdList = Arrays.asList("1", "2", "3", "4", "5");
        }
        if (branchIdList.contains("0")) {
            // prdIdList를 새로운 값들로 채우기
            branchIdList = Arrays.asList("1", "2", "3", "4", "5");
        }


        for (Map<String, Object> stockItem : daybyStockList) {
            stockItem.put("branchIds", branchIdList);
            stockItem.put("productIds", prdIdList);
        }

        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            /*            log.error("{}", popPrdId);*/
            if (!prdIdSet.contains(popPrdId)) {
                prdIdSet.add(popPrdId);
                uniqueList.add(map);
            }
        }


        List<Map<String, Object>> branchNameUniqueList = new ArrayList<>();

        Set<Object> brcNameSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popBrcName = map.get("BRANCH_NAME");
            if (!brcNameSet.contains(popBrcName)) {

                brcNameSet.add(popBrcName);
                /*                log.error("popBrcName : {}", popBrcName);*/
                branchNameUniqueList.add(map);
            }
        }

        model.addAttribute("RealdaybyStockList", daybyStockList);
        model.addAttribute("branchNameUniqueList", branchNameUniqueList);
        model.addAttribute("daybyStockList", uniqueList);
        return "logistics/widthBranchByStockPage";
    }

    @RequestMapping("stock/searchbybranch")
    public String searchByBranch(Model model) {
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        model.addAttribute("branchList", branchList);
        model.addAttribute("productList", selectAllProduct);
        return "logistics/searchStockByBranch";
//        return "redirect:/logistics/searchDaybyStock";
        /*        return "logistics/searchDaybyStock";*/
    }

    @RequestMapping("stock/dayby")
    public String daybyStock(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);

        for (Map.Entry<String, Object> entry : params.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();

            // 값이 String 배열인 경우 Arrays.toString()을 사용하여 출력
            if (value instanceof String[]) {
                log.error(key + ": " + Arrays.toString((String[])value));
            } else {
                log.error(key + ": " + value);
            }
        }

/*

        HashMap<String, Object> params = Getrequest.getParameterMap(request);


*/
/*        // branchId가 null이면 0으로 대체
        String branchIdStr = (String)params.get("branchId");
        int branchId = (branchIdStr != null && !branchIdStr.isEmpty()) ? Integer.parseInt(branchIdStr) : 0;
        params.put("branchId", branchId);

        // prdId가 null이면 0으로 대체
        String prdIdStr = (String)params.get("prdId");
        int prdId = (prdIdStr != null && !prdIdStr.isEmpty()) ? Integer.parseInt(prdIdStr) : 0;
        params.put("prdId", prdId);*//*



        // 여기서 branchId와 prdId가 배열 형태로 오면 리스트로 변환됨
        List<String> branchIdList = (List<String>)params.get("branchId");
        List<String> prdIdList = (List<String>)params.get("prdId");

        // 여기서는 List를 그대로 사용하거나, 0이나 null 체크를 해서 빈 리스트를 생성할 수 있음
        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>(); // 빈 리스트를 생성
            branchIdList.add("0"); // 지점 선택이 없을 경우 기본값으로 '0' 추가
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0"); // 품목 선택이 없을 경우 기본값으로 '0' 추가
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);
*/
        Map<String, String[]> paramMap = request.getParameterMap();

// branchId와 prdId 파라미터를 배열로 추출
        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

// 배열을 List로 변환
        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0"); // '0'을 기본값으로 사용
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0"); // '0'을 기본값으로 사용
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);


        /*        log.debug("{}", params);*/

        List<Map<String, Object>> daybyStockList = service.selectDaybyStock(params);

/*        log.debug("{}", daybyStockList.size());

        for (Map<String, Object> map : daybyStockList) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();
                log.debug(key + ": " + value);
            }
            log.debug("------------------------");
        }*/
        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            /*            log.error("{}", popPrdId);*/
            if (!prdIdSet.contains(popPrdId)) {
                prdIdSet.add(popPrdId);
                uniqueList.add(map);
            }
        }

        model.addAttribute("daybyStockList", uniqueList);
        return "logistics/daybyStockPage";
    }

    @RequestMapping("stock/searchbyday")
    public String searchDaybyStock(Model model) {
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        model.addAttribute("branchList", branchList);
        model.addAttribute("productList", selectAllProduct);
        return "logistics/searchStockbyDay";
//        return "redirect:/logistics/searchDaybyStock";
        /*        return "logistics/searchDaybyStock";*/
    }

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
