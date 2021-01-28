package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.AskVO;
import org.zerock.domain.PagingVO;

@Repository
public class ServiceDAOImpl implements ServiceDAO{

	private static final String namespace = "org.zerock.mapper.ServiceMapper";

	@Inject
	private SqlSession session;
	



	@Override
	public void insertAsk(AskVO vo) {
		session.insert(namespace+".insertAsk", vo);
	}

	
	
	@Override
	public List<AskVO> getMyaskList(PagingVO pvo) {
		return session.selectList(namespace+".getMyaskList", pvo);
	}



	@Override
	public AskVO getData(int uid) {
		return session.selectOne(namespace+".getData", uid);
	}



	@Override
	public void insertAnswer(AskVO vo) {
		session.insert(namespace+".insertAnswer", vo);
	}



	@Override
	public List<AskVO> getAnswer(String postUid) {
		return session.selectList(namespace+".getAnswer", postUid);
	}



	@Override
	public String countAnswer(String postUid) {
		return session.selectOne(namespace+".countAnswer", postUid);
	}



	@Override
	public int countList(String id) {
		return session.selectOne(namespace+".countList", id);
	}
}
