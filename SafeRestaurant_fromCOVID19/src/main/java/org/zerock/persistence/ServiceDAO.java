package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.AskVO;
import org.zerock.domain.PagingVO;

public interface ServiceDAO {

	public void insertAsk(AskVO vo);
	public List<AskVO> getMyaskList(PagingVO pvo);
	public AskVO getData(int uid);
	public void insertAnswer(AskVO vo);
	public List<AskVO> getAnswer(String postUid);
	public String countAnswer(String postUid);
	public int countList(String id);
	
}
