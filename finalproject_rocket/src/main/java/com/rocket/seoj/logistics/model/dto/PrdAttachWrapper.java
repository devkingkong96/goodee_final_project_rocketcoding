package com.rocket.seoj.logistics.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * Brief description of functions
 *
 * @author J
 * @version 2024-01-10
 */
@Data
//@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PrdAttachWrapper {
    private List<PrdAttach> prdAttach;

    public PrdAttachWrapper() {
        this.prdAttach = new ArrayList<>();
    }
}
