package com.rocket.seoj.logistics.model.dto;

import java.util.List;

import com.rocket.jsy.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-23
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Branch {
    private long id;
    private String branchName;
    private String branchType;
    private String branchIsdel;
    private String branchAddr;
    private List<Employee> employeeList;
    private List<Inventory> inventoryList;
    private List<Stock> stockList;
}
