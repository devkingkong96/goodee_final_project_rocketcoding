package com.rocket.seoj.logistics.model.dto;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Getter;
@Getter
@AllArgsConstructor
public class BranchDto {

    private long branchId;
    private String branchName;
    private String branchType;
    private String branchIsdel;
    private String branchAddr;

    public BranchDto of(Branch br) {
        return new BranchDto(br.getBranchId(), br.getBranchName(), br.getBranchType(), br.getBranchIsdel(),
                             br.getBranchAddr()

        );
    }
}
