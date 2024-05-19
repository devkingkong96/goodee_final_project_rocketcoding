package com.rocket.seoj.logistics.model.dto;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.jsy.employee.model.dto.EmployeeDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class InventoryDto {
	
	private long ivId;
	private String ivType;
	private Date ivDate;
	private String ivIsdel;
	private Date ivEditDate;
	private String ivVatType;
	private String ivMemo;
	
	private BranchDto sendBrcId;
	private BranchDto recieveBrcId;
	private EmployeeDto sendEmpId;
	private EmployeeDto recieveEmpId;
	
//	public InventoryDto of(Inventory iv) {
//		Branch sendBranchInstance = new Branch();
//		Branch receiveBranchInstance = new Branch();
//		Employee sendEmployeeInstance = new Employee();
//		Employee receiveEmployeeInstance = new Employee();
//		
//		Branch sendBranch = iv.getSendBrcId();
//		Branch receiveBranch = iv.getRecieveBrcId();
//		Employee sendEmployee = iv.getSendEmpId();
//		Employee receiveEmployee = iv.getRecieveEmpId();
		/*		log.debug(iv.getSendBrcId());*/
		/*		log.debug("" + sendBranch);*/
//		BranchDto sendBranchDto = (iv.getSendBrcId() != null) ?
//		   sendBrcId.of(iv.getSendBrcId()) :
//		   null;
//		BranchDto receiveBranchDto = (iv.getRecieveBrcId() != null) ?
//		   recieveBrcId.of(iv.getRecieveBrcId()) :
//		   null;
//		EmployeeDto sendEmployeeDto = (iv.getSendEmpId() != null) ?
//		   sendEmpId.of(iv.getSendEmpId()) :
//		   null;
//		EmployeeDto receiveEmployeeDto = (iv.getRecieveEmpId() != null) ?
//		   recieveEmpId.of(iv.getRecieveEmpId()) :
//		   null;
//		
//		return new InventoryDto(iv.getIvId(), iv.getIvType(), iv.getIvDate(),
//		                        iv.getIvIsdel(), iv.getIvEditDate(),
//		                        iv.getIvVatType(), iv.getIvMemo(), sendBranchDto,
//		                        receiveBranchDto, sendEmployeeDto,
//		                        receiveEmployeeDto);
//		BranchDto sendBranchDto = iv.getSendBrcId() != null ?
//		   BranchDto.of(iv.getSendBrcId()) :
//		   null;
//		BranchDto receiveBranchDto = iv.getRecieveBrcId() != null ?
//		   BranchDto.of(iv.getRecieveBrcId()) :
//		   null;
//		EmployeeDto sendEmployeeDto = iv.getSendEmpId() != null ?
//		   EmployeeDto.of(iv.getSendEmpId()) :
//		   null;
//		EmployeeDto receiveEmployeeDto = iv.getRecieveEmpId() != null ?
//		   EmployeeDto.of(iv.getRecieveEmpId()) :
//		   null;
		
		/*		return new InventoryDto(iv.getIvId(), iv.getIvType(), iv.getIvDate(),
				                        iv.getIvIsdel(), iv.getIvEditDate(),
				                        iv.getIvVatType(), iv.getIvMemo(),
				                        BranchDto.of(iv.getSendBrcId()),
				                        BranchDto.of(iv.getRecieveBrcId()),
				                        EmployeeDto.of(iv.getSendEmpId()),
				                        EmployeeDto.of(iv.getRecieveEmpId())
		
				);*/
//	}
}
