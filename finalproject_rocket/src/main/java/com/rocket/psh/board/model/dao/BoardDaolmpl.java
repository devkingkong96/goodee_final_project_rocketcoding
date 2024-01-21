package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.psh.board.model.dto.Fboard;
import com.rocket.psh.board.model.dto.FboardFile;

import jakarta.transaction.Transactional;

@Repository

public class BoardDaolmpl implements BoardDao {
	
	@Override
	public int insertFboard(SqlSession session, Fboard fboard) {
		// TODO Auto-generated method stub
		return session.insert("fboard.insertFboard", fboard);
	}
	
	@Override
	public int insertFboardFile(SqlSession session, FboardFile ff) {
		// TODO Auto-generated method stub
		return session.insert("fboard.insertFboardFile", ff);
	}

	@Override
	public Fboard selectFboardDetail(SqlSession session, int fboardNo) {
		// TODO Auto-generated method stub
		return session.selectOne("fboard.selectFboardDetail", fboardNo);
	}
	
	
	@Override
	public List<Map<String, Object>> selectFboardList(SqlSession session, Map<String, Object> param) {
		// TODO Auto-generated method stub
		int cPage=(int)param.get("page");
		
		RowBounds rb=new RowBounds((cPage-1)*10, 10);
		
		return session.selectList("fboard.selectFboardMainPage",param,rb);
	}

	@Override
	public int increaseViewCount(SqlSession session, int fboardNo) {
		// TODO Auto-generated method stub
		return session.insert("fboard.insertFboard",fboardNo);
	}

	@Override
	public List<Map<String, Object>> selectFboardComments(SqlSession session, int fboardNo) {
		// TODO Auto-generated method stub
		return session.selectList("fboard.selectFboardComments",fboardNo);
	}

	@Override
    public int updateFboard(SqlSession session, Map<String, Object> map) {
        return session.update("fboard.updateFboard", map);
    }

    @Override
    public int deleteFboard(SqlSession session, int fboardNo) {
        return session.delete("fboard.deleteFboard", fboardNo);
    }

}
