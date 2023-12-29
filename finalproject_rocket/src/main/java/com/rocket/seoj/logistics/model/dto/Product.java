package com.rocket.seoj.logistics.model.dto;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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
public class Product {
	
	private long prdId;
	private String prdTitle;
	private String prdAuthor;
	private String prdGenre;
	private Date publishDate;
	private String prdIsdel;
	private BigDecimal prdPrice;
	private BigDecimal priceInStk;
	private BigDecimal priceOutStk;
	
	private long pubId;
	
}
