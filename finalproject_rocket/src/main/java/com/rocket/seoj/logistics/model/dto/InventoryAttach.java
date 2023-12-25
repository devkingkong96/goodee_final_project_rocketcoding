package com.rocket.seoj.logistics.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

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
public class InventoryAttach {
    private long id;
    private String ivFileNameOri;
    private String ivFileNameRe;
    private Date ivUploadDate;
    private String ivAttachIsdel;
    private Inventory inventoryId;
}
