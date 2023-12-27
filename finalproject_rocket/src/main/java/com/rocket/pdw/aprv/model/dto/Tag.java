package com.rocket.pdw.aprv.model.dto;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Tag {
    private long docTag;
    private String tagName;
    private String tagCont;
    private Document docNo;
}