package com.rocket.seoj.logistics.model.dto;


import java.util.Date;
import java.util.List;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.dto.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inventory {
	
	private long id;
	private String ivType;
	private Date ivDate;
	private String ivIsdel;
	private Date ivEditDate;
	private String ivVatType;
	private String ivMemo;
	private Branch sendBrcId;
	private Branch recieveBrcId;
	private Document docNo;
	private Employee sendEmpId;
	private Employee recieveEmpId;
	private List<PrdInventory> prdInventoryList;
	private List<InventoryAttach> inventoryAttachList;
}
