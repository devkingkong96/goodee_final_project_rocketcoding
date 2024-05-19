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
import java.math.BigDecimal;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.*;

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

        for (Map.Entry<String, Object> entry : params.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
        }
        Map<String, String[]> paramMap = request.getParameterMap();

        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0");
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0");
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.stockLedger(params);

        Map<String, Map<String, List<Map<String, Object>>>> groupedBySendBrcIdAndPrdId = new HashMap<>();

        for (Map<String, Object> record : daybyStockList) {
            String sendBrcId = String.valueOf(record.get("SEND_BRC_ID"));
            String prdId = String.valueOf(record.get("PRD_ID"));

            Map<String, List<Map<String, Object>>> prdIdMap = groupedBySendBrcIdAndPrdId.computeIfAbsent(sendBrcId,
                                                                                                         k -> new HashMap<>());

            List<Map<String, Object>> prdIdListForTable = prdIdMap.computeIfAbsent(prdId, k -> new ArrayList<>());
            prdIdListForTable.add(record);
        }

        groupedBySendBrcIdAndPrdId.forEach((sendBrcId, prdIdMap) -> {
            prdIdMap.forEach((prdId, records) -> {
                records.sort((record1, record2) -> {
                    Date date1 = (Date)record1.get("STK_DATE");
                    Date date2 = (Date)record2.get("STK_DATE");
                    if (date1 == null && date2 == null) {
                        return 0;
                    }
                    if (date1 == null) {
                        return -1;
                    }
                    if (date2 == null) {
                        return 1;
                    }

                    return date1.compareTo(date2);
                });
            });
        });

        groupedBySendBrcIdAndPrdId.forEach((sendBrcId, prdIdMap) -> {
            prdIdMap.forEach((prdId, records) -> {
                for (Map<String, Object> record : records) {

                }
            });
        });

        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
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
                branchNameUniqueList.add(map);
            }
        }

        Object startDateHiddenValue = params.get("start-date-hidden");
        Object endDateHiddenValue = params.get("end-date-hidden");

        model.addAttribute("startDateHiddenValue", startDateHiddenValue);
        model.addAttribute("endDateHiddenValue", endDateHiddenValue);
        model.addAttribute("groupedBySendBrcIdAndPrdId", groupedBySendBrcIdAndPrdId);
        model.addAttribute("daybyStockList", daybyStockList);
        model.addAttribute("branchNameUniqueList", branchNameUniqueList);
        model.addAttribute("branchIdListSize", branchIdList.size());
        model.addAttribute("prdIdListSize", prdIdList.size());

        return "logistics/StockLedgerPage";
    }


    @RequestMapping("stock/searchledger")
    public String searchLedger(Model model) {
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        model.addAttribute("branchList", branchList);
        model.addAttribute("productList", selectAllProduct);
        return "logistics/searchStockLedger";
    }


    @RequestMapping("stock/branchbyheigt")
    public String selectStockByProduct(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);

        Map<String, String[]> paramMap = request.getParameterMap();

        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0");
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0");
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.selectStockByProduct(params);

        if (prdIdList.contains("0")) {
            prdIdList = Arrays.asList("1", "2", "3", "4", "5");
        }
        if (branchIdList.contains("0")) {
            branchIdList = Arrays.asList("1", "2", "3", "4", "5");
        }
        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            /*            log.debug("{}", popPrdId);*/
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

        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();

        if (branchIdList == null || branchIdList.isEmpty() || branchIdList
                .get(0)
                .equals("")) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0");
        }
        if (prdIdList == null || prdIdList.isEmpty() || prdIdList
                .get(0)
                .equals("")) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0");
        }

        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.selectStockByBranch(params);

        Map<String, Object> stockSumList = new HashMap<>();
        String[] keys = { "BRANCH1_STOCK_SUM", "BRANCH2_STOCK_SUM", "BRANCH3_STOCK_SUM", "BRANCH4_STOCK_SUM", "BRANCH5_STOCK_SUM" };

        for (Map<String, Object> dayStock : daybyStockList) {
            boolean allFilled = true;

            for (String key : keys) {
                if (!stockSumList.containsKey(key) || (stockSumList.get(key) != null && ((Number)stockSumList.get(
                        key)).intValue() == 0)) {
                    Object value = dayStock.get(key);

                    if (value instanceof BigDecimal && ((BigDecimal)value).intValue() != 0) {
                        stockSumList.put(key, ((BigDecimal)value).intValue());
                    } else if (value instanceof Integer && (Integer)value != 0) {
                        stockSumList.put(key, value);
                    } else {
                        allFilled = false;
                    }
                }
            }

            if (allFilled) {
                break;
            }
        }

        for (Map<String, Object> item : daybyStockList) {
            for (Map.Entry<String, Object> entry : item.entrySet()) {
                String key = entry.getKey();
                Object value = entry.getValue();

            }
        }

        if (prdIdList.contains("0")) {
            prdIdList = Arrays.asList("1", "2", "3", "4", "5");
        }
        if (branchIdList.contains("0")) {
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
                branchNameUniqueList.add(map);
            }
        }

        model.addAttribute("stockSumList", stockSumList);
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
    }

    @RequestMapping("stock/dayby")
    public String daybyStock(HttpServletRequest request, Model model) {
        HashMap<String, Object> params = Getrequest.getParameterMap(request);

        for (Map.Entry<String, Object> entry : params.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();

        }
        Map<String, String[]> paramMap = request.getParameterMap();

        String[] branchIdArray = paramMap.get("branchId");
        String[] prdIdArray = paramMap.get("prdId");

        List<String> branchIdList = branchIdArray != null ? Arrays.asList(branchIdArray) : new ArrayList<>();
        List<String> prdIdList = prdIdArray != null ? Arrays.asList(prdIdArray) : new ArrayList<>();
        int branchCount = 0;
        if (branchIdList == null || branchIdList.isEmpty()) {
            branchIdList = new ArrayList<>();
            branchIdList.add("0");
            branchCount = 0;
        }else{
            branchCount = branchIdList.size();
        }
        if (prdIdList == null || prdIdList.isEmpty()) {
            prdIdList = new ArrayList<>();
            prdIdList.add("0");
        }
        log.debug("branchCount : {}", branchCount);
        params.put("branchCount", branchCount);
        params.put("branchIdList", branchIdList);
        params.put("prdIdList", prdIdList);

        List<Map<String, Object>> daybyStockList = service.selectDaybyStock(params);

        List<Map<String, Object>> uniqueList = new ArrayList<>();

        Set<Object> prdIdSet = new HashSet<>();
        for (Map<String, Object> map : daybyStockList) {
            Object popPrdId = map.get("PRD_ID");
            if (!prdIdSet.contains(popPrdId)) {
                prdIdSet.add(popPrdId);
                uniqueList.add(map);
            }
        }

        model.addAttribute("daybyStockList", uniqueList);
        model.addAttribute("daybyStockList2", daybyStockList);
        return "logistics/daybyStockPage";
    }

    @RequestMapping("stock/searchbyday")
    public String searchDaybyStock(Model model) {
        List<Map<String, Object>> branchList = service.selectAllBranch();

        List<Map<String, Object>> selectAllProduct = service.selectAllProduct();

        model.addAttribute("branchList", branchList);
        model.addAttribute("productList", selectAllProduct);
        return "logistics/searchStockbyDay";
    }

    public void printFieldNames(Object obj) {
        Class<?> objClass = obj.getClass();
        Field[] fields = objClass.getDeclaredFields();

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
