package com.rocket.pdw.aprv.model.dto;

import java.sql.Date;
import java.util.List;

import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.seoj.logistics.model.dto.Inventory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Document {
    private long docNo;
    private DocumentTag docTag; // 외래 키 DOC_TAG에 해당하는 Tag 타입의 참조
    private String docTitle;
    private String docCont;
    private int docStatcd;
    private Date uDate;
    private Employee empNo; // 외래 키 EMP_NO에 해당하는 Employee 타입의 참조
    private Date startDate;
    private Date endDate;


    private ApprovalFile approvalFile;
    List<Approval> approvalList;
    private Inventory inventory;
}
