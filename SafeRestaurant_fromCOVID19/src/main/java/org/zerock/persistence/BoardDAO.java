package org.zerock.persistence;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.zerock.domain.CommentVO;
import org.zerock.domain.MenuVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.ReviewVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;

public interface BoardDAO {
	
	public void reviewInsert(ReviewVO vo);
	public List<ReviewVO> getReview(String code);
	public void reviewDelete(int uid);
	public Map<String, String> getDetail(String rname);
	public String GetcountTotal();
	public String countTotal(String sido, String sigugun);
	public ArrayList<StoreVO> getStoreList(String totalcnt, String category, String sido, String sigugun);
	public ArrayList<StoreVO> getStoreListGet(String category, String totalcnt);
	public void insertReserv_inStore(ReservationVO vo);
	public List<ReservationVO> getReservList(ReservationVO vo);
	public ArrayList<StoreVO> getAllList(String totalcnt, String category, String sido, String sigugun);
	public StoreMemberVO getStoreMember(String code);
	public void InsertMenu(MenuVO vo);
	public List<MenuVO> getMenu(String code);
	public void DeleteMenu(String uid);
	public void UpdateMenu(MenuVO vo);
	public int getFid(String code);
	public ReviewVO getFidwhereUid(ReviewVO vo);
	public void replyInset(CommentVO vo);
	public List<CommentVO> getComment(String code);
	public int getcountFid(String code);
}
