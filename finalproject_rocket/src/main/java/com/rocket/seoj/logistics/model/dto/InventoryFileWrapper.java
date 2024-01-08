package com.rocket.seoj.logistics.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2024-01-06
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InventoryFileWrapper {
    private List<InventoryAttach> invAttach;
}
