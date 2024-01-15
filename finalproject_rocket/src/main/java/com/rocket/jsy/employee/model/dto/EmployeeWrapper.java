package com.rocket.jsy.employee.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2024-01-11
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EmployeeWrapper {
    private List<EmployeeDto> employee;
}
