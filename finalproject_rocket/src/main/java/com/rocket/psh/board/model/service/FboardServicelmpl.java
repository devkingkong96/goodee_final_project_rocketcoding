package com.rocket.psh.board.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.rocket.psh.board.model.dao.BoardDao;
import com.rocket.psh.board.model.dto.Fboard;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FboardServicelmpl implements FboardService {
	
	public final BoardDao dao;
	public final SqlSession session;
	@Override
	public List<Map<String, Object>> selectFboardList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.selectFboardList(session, map);
	}
	
	@Transactional
	@Override
	public int insertFboard(Fboard fboard) {
		int result=dao.insertFboard(session, fboard);
		if(result>0&&fboard.getFiles().size()>0) {
			fboard.getFiles().stream().forEach(e->{
				int fileResult=dao.insertFboardFile(session, e);
				if(fileResult==0) throw new IllegalArgumentException("첨부파일 업로드 실패!");
			});
		}
		return result; 
	}
	@Override
	public int increaseViewCount(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.increaseViewCount(session,fboardNo);
	}
	@Override
	public Fboard selectFboardDetail(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.selectFboardDetail(session, fboardNo);
	}
	@Override
	public List<Map<String, Object>> selectFboardComments(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.selectFboardComments(session,fboardNo);
	}
	@Override
	public int updateFboard(Fboard fboard) {
		// TODO Auto-generated method stub
		int result=dao.updateFboard(session, fboard);
		if(result>0&&fboard.getFiles()!=null) {
			dao.deleteFile(session,fboard.getFboardNo());
			fboard.getFiles().stream().forEach(e->{
				e.setFboardNo(fboard.getFboardNo());
				int result2=dao.updateFile(session, e);
				
			});
	
		}
		return dao.updateFboard(session, fboard);
	}
	@Override
	public int deleteFboard(int fboardNo) {
		// TODO Auto-generated method stub
		return dao.deleteFboard(session, fboardNo);
	}
	
	
	
			
}
