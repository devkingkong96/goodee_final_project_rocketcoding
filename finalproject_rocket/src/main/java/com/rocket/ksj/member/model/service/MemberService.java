package com.rocket.ksj.member.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.rocket.ksj.member.model.dao.MemberDao;
import com.rocket.ksj.member.model.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	
	private final MemberDao dao;
	private final SqlSession session;
	
	public List<Member> selectMemberAll(){
		return dao.selectMemberAll(session);
	}
	
	public Member selectMemberById(String userId) {
		return dao.selectMemberById(session,userId);
	}
}
