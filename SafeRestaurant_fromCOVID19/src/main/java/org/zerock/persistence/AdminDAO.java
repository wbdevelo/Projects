package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.AdminExcelVO;
import org.zerock.domain.AskVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.SlideImgVO;

public interface AdminDAO {

	
	public void insertExcel(AdminExcelVO vo);
	public List<AdminExcelVO> getExcelList();
	public void changeAll_to_noUse();
	public void deleteExcel(AdminExcelVO vo);
	public void changeUse(String uid);
	public String getPath();
	public List<MemberVO> getAllMember();
	public void force(String id);
	public void updateImg1(SlideImgVO vo);
	public void updateImg2(SlideImgVO vo);
	public List<SlideImgVO> getSlide1();
	public List<SlideImgVO> getSlide2();
	public int checkImg(String num);
	public void insertImg(SlideImgVO vo);
	public void slideDelete(String uid);
	public SlideImgVO getSlideInfo(String uid);
	public List<AskVO> getAllask();
	public String countAnswer(int uid);
	
}
