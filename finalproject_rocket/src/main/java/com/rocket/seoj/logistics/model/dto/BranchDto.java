package com.rocket.seoj.logistics.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2023-12-23
 */
@Getter
@AllArgsConstructor
@JsonIdentityInfo (
   generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class BranchDto {
	
	private long branchId;
	private String branchName;
	private String branchType;
	private String branchIsdel;
	private String branchAddr;
	
	/*	private List<Employee> employeeList;
		
		private List<Inventory> inventoryList;
		
		private List<Stock> stockList;*/
	
	public BranchDto of(Branch br) {
		return new BranchDto(br.getBranchId(), br.getBranchName(),
		                     br.getBranchType(), br.getBranchIsdel(),
		                     br.getBranchAddr()
		
		);
		
	}
}
