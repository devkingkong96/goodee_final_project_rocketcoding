package com.rocket.seoj.logistics.model.dto;

import java.util.Date;
import java.sql.Timestamp;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.rocket.jsy.employee.model.dto.Employee;
import com.rocket.pdw.aprv.model.dto.Document;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inventory {

    private long ivId;
    private String ivType;
    private Date ivDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date ivDeadline;
    private String ivIsdel;
    private Date ivEditDate;
    private String ivVatType;
    private String ivMemo;

    private Long sendBrcId;

    private Long recieveBrcId;

    private Integer sendEmpId;

    private Integer recieveEmpId;

    private Long docNo;


    public Inventory of(Inventory inv) {

        return Inventory
                .builder()

                .sendBrcId(inv.sendBrcId)
                .recieveBrcId(inv.recieveBrcId)
                .sendEmpId(inv.sendEmpId)
                .recieveEmpId(inv.recieveEmpId)
                .build();

    }

}
