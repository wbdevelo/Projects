package org.zerock.persistence;

import org.zerock.domain.MemberVO;
import org.zerock.domain.StoreMemberVO;
import org.zerock.domain.StoreVO;

public interface MemberDAO {

	public String idCheck(String userId);
	public String storeidCheck(String userId);
	public void join(MemberVO vo);
	public int login(MemberVO vo);
	public MemberVO searchId(MemberVO vo);
	public StoreMemberVO storesearchId(StoreMemberVO vo);
	public int searchPw(MemberVO vo);
	public int StoresearchPw(StoreMemberVO vo);
	public void changePw(MemberVO vo);
	public void changePw2(StoreMemberVO vo);
	public MemberVO oneMember (String id);
	public void modifyMem(MemberVO vo);
	public String getID(String userId);
	public void InsertStoreMember(StoreMemberVO vo);
	public StoreVO getStoreInfo(String storecode);
	public StoreMemberVO getStoreDbInfo(StoreMemberVO vo);
	public void modifyMemStore(StoreMemberVO vo);
	
}
