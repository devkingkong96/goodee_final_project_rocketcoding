package com.rocket.pdw.aprv.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.rocket.pdw.aprv.model.dto.Tag;

@Repository
public class ApprovalDao {
	
	@Transactional
	public int inserttag(SqlSession session, Tag dt) {
		return session.insert("tag.inserttag", dt);
	}
}
