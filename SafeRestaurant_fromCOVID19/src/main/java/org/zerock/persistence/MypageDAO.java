package org.zerock.persistence;

import java.util.ArrayList;
import java.util.List;

import org.zerock.domain.AjaxVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.MenuVO;
import org.zerock.domain.PagingVO;
import org.zerock.domain.ReservationVO;
import org.zerock.domain.StoreMemberVO;

public interface MypageDAO {
	
	public MemberVO getMemberInfo(String session_id);
	public StoreMemberVO getstoreMemberInfo(String session_id);
	public void changePass(MemberVO mvo);
	public void changePassStore(StoreMemberVO svo);
	public void secession(String id);
	public void session2(String id);
	public int totalJjim(PagingVO vo);
	public ArrayList<AjaxVO> jjimList(PagingVO vo);
	public void cancel_like(AjaxVO vo);
	public List<ReservationVO> reservList(PagingVO vo);
	public List<ReservationVO> reservList2(String code);
	public void cancel_reserv(int uid);
	public int countAsk(String id);
	public int totalReserv(PagingVO vo);
	
}
