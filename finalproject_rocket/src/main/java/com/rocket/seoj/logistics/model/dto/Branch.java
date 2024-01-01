package com.rocket.seoj.logistics.model.dto;

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
		
		return branch;
	}
}