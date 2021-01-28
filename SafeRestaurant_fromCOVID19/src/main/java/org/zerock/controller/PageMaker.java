package org.zerock.controller;

import org.zerock.domain.PagingVO;

public class PageMaker{
	
	public PagingVO paging(PagingVO vo) {
		int nowPage = vo.getNowPage();
		int totalPost = vo.getTotalPost();
		int pagePerPost = vo.getPagePerPost();
		vo.setPagePerPost(pagePerPost); 
		int pagePerBlock = 3;
		vo.setPagePerBlock(pagePerBlock);
		int totalPage = 0;
		if(totalPost%pagePerPost == 0) {
			totalPage = (int)totalPost / pagePerPost;
		}else {
			totalPage = ((int)totalPost / pagePerPost) + 1;
		}
		vo.setTotalPage(totalPage);
		
		int totalBlock = 0;
		if(totalPage%pagePerBlock == 0) {
			totalBlock = (int)totalPage / pagePerBlock;
		}else {
			totalBlock = ((int)totalPage / pagePerBlock) + 1;
		}
		vo.setTotalBlock(totalBlock);
		
		int nowBlock = 0;
		if(nowPage%pagePerBlock == 0) {
			nowBlock = (int)nowPage / pagePerBlock;
		}else {
			nowBlock = ((int)nowPage / pagePerBlock) + 1;
		}
		vo.setNowBlock(nowBlock);
		
		int startPage = 1 + ((nowBlock-1)*pagePerBlock);
		vo.setStartPage(startPage);
		
		int endPage = nowBlock * pagePerBlock;
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		vo.setEndPage(endPage);
		
		int limitStart = (nowPage-1) * pagePerPost;
		vo.setLimitStart(limitStart);
		
		return vo;
	}
}
