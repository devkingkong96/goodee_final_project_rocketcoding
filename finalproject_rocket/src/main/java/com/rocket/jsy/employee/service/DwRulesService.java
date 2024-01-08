package com.rocket.jsy.employee.service;

import java.util.List;
import java.util.Map;

import com.rocket.jsy.employee.model.dto.DwRules;

public interface DwRulesService {
	List<Map<String,Object>>selectDwRulesAll();
	
	void addDwRules(DwRules dwRules);

	void deleteDwRule(String comNo);
}
