package org.zerock.persistence;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.zerock.domain.LIkesVO;
import org.zerock.domain.StoreVO;

public interface AjaxDAO {
	
	public String getTotalCount(String sido, String sigu);
	public ArrayList<Object> getList(String sido, String sigu, String totalCnt, String nowPage);
	public StoreVO getStore(String code);
	public ArrayList<Object> getSearch(String searchWord, String nowPage);
	public List<Object> getRank(String si);
	public int likeSelect(LIkesVO lvo);
	public void InsertLike(LIkesVO lvo);
	public List<LIkesVO> likeSelectChk(LIkesVO lvo);
	public void updateLike(LIkesVO lvo);
	public ArrayList<StoreVO> getStoreList(String sido, String sigugun, String totalCount);
	public String getCheckStorecode(String storecode);
	
}
