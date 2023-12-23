package com.rocket.ksj.member.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.ksj.member.model.dto.Member;

@Repository
public class MemberDao {

	public List<Member>selectMemberAll(SqlSession session){
		return session.selectList("member.selectMemberAll");
	}
	
	public Member selectMemberById(SqlSession session,String userId) {
		return session.selectOne("member.selectMemberById",userId);
	}
}
