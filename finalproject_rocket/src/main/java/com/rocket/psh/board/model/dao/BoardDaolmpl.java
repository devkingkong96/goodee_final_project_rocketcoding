package com.rocket.psh.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.rocket.psh.board.model.dto.Fboard;
@Repository
public class BoardDaolmpl implements BoardDao {

	@Override
	public List<Fboard> selectBorad(SqlSession session,Map<String,Integer>page) {
		int cPage=page.get("cPage");
		int numPage=page.get("numPage");
		RowBounds rb=new RowBounds((cPage-1)*numPage,numPage);
		
		return session.selectList("fboard.selectFboard",null,rb);
	}

	@Override
	public int selectFboardCount(SqlSession session) {
		return session.selectOne("fboard.selectBoardCount");
	}

	@Override
	public Fboard selectBoardByNo(SqlSession session, int boardNo) {
		return session.selectOne("fboard.selectBoardByNo",boardNo);
	}

	@Override
	public int insertFboard(SqlSession session, Fboard b) {
		return session.insert("board.insertFboard",b);
	}

}
