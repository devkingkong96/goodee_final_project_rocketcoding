package com.rocket.seoj.logistics.model.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
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
	
	private long branchId;
	private String branchName;
	private String branchType;
	private String branchIsdel;
	private String branchAddr;
	
	
	
	
	public static Branch from(BranchDto branchDto) {
		
		if (branchDto == null) {
			return null;
		}
		
		Branch branch = new Branch();
		branch.setBranchId(branchDto.getBranchId());
		branch.setBranchName(branchDto.getBranchName());
		branch.setBranchType(branchDto.getBranchType());
		branch.setBranchIsdel(branchDto.getBranchIsdel());
		branch.setBranchAddr(branchDto.getBranchAddr());
		
		// 'employeeList', 'inventoryList', 'stockList'는 여기서 처리하지 않습니다.
		// 이러한 필드는 별도의 로직을 통해 처리해야 할 수도 있습니다.
		
		return branch;
	}
}
