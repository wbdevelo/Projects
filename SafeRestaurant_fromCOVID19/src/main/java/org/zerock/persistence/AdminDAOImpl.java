package org.zerock.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.zerock.domain.AdminExcelVO;
import org.zerock.domain.AskVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.SlideImgVO;

@Repository
public class AdminDAOImpl implements AdminDAO{


	private static final String namespace = "org.zerock.mapper.AdminMapper";
	
	@Inject
	private SqlSession session;
	
	@Override
	public void insertExcel(AdminExcelVO vo) {
		session.insert(namespace+".insertExcel", vo);
	}

	@Override
	public List<AdminExcelVO> getExcelList() {
		return session.selectList(namespace+".getExcelList");
	}

	@Override
	public void changeAll_to_noUse() {
		session.update(namespace+".changeAll_to_noUse");
	}

	@Override
	public void deleteExcel(AdminExcelVO vo) {
		session.delete(namespace+".delExcel", vo);
	}

	@Override
	public void changeUse(String uid) {
		session.update(namespace+".changeUse", uid);
	}
	
	@Override
	public String getPath() {
		return session.selectOne(namespace+".getPath");
	}

	@Override
	public List<MemberVO> getAllMember() {
		return session.selectList(namespace+".allMember");
	}

	@Override
	public void force(String id) {
		session.update(namespace+".force", id);
	}

	@Override
	public void updateImg1(SlideImgVO vo) {
		session.update(namespace+".updateImg1", vo);
	}
	@Override
	public void updateImg2(SlideImgVO vo) {
		session.update(namespace+".updateImg2", vo);
	}

	@Override
	public List<SlideImgVO> getSlide1() {
		return session.selectList(namespace+".getSlide1");
	}
	@Override
	public List<SlideImgVO> getSlide2() {
		return session.selectList(namespace+".getSlide2");
	}

	@Override
	public int checkImg(String num) {
		return session.selectOne(namespace+".checkImg", num);
	}

	@Override
	public void insertImg(SlideImgVO vo) {
		session.insert(namespace+".insertImg", vo);
	}

	@Override
	public void slideDelete(String uid) {
		session.delete(namespace+".deleteslide", uid);
	}

	@Override
	public SlideImgVO getSlideInfo(String uid) {
		return session.selectOne(namespace+".getSlideInfo", uid);
	}
	
	@Override
	public List<AskVO> getAllask() {
		return session.selectList(namespace+".getAllask");
	}

	@Override
	public String countAnswer(int uid) {
		return session.selectOne(namespace+".countAnswer", uid);
	}
	
	
}
