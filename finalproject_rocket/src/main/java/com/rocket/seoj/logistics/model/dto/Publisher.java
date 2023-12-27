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
 * @version 2023-12-23
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Publisher {
    private long pubId;
    private String pubName;
    private String pubAddr;
    private int pubPhone;
    private String pubIsdel;
    private String pubRepresentative;
    private String pubBank;
    private List<Product> productList;
}
