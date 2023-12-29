package com.rocket.seoj.logistics.model.dto;

import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
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
@JsonIdentityInfo (
   generator = ObjectIdGenerators.IntSequenceGenerator.class)
public class Inventory {
	
	private long ivId;
	private String ivType;
	private Date ivDate;
	private String ivIsdel;
	private Date ivEditDate;
	private String ivVatType;
	private String ivMemo;
	
	private Branch sendBrcId;
	
	private Branch recieveBrcId;
	
	private Employee sendEmpId;
	
	private Employee recieveEmpId;
	
	private Document docNo;
	
	private List<PrdInventory> prdInventoryList;
	
	private List<InventoryAttach> inventoryAttachList;
	
	public Inventory of(Inventory inv) {
		
		return Inventory.builder()
		   
		   .sendBrcId(inv.sendBrcId).recieveBrcId(inv.recieveBrcId)
		   .sendEmpId(inv.sendEmpId).recieveEmpId(inv.recieveEmpId).build();
		
	}
	
}
