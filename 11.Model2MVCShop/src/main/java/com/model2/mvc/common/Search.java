package com.model2.mvc.common;


public class Search {
	
	private int page; // �ϴ� ������
	String searchCondition; // 0 �Ǵ� 1�� ȸ������ �ƴϸ� ���̵�����
	String searchKeyword; // �˻��� ��
	int pageSize; // ����Ʈ �����ִ� ���� ����
	
	private int endRowNum;
	private int startRowNum;
	
	public Search(){
	}
	
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public int getPage() { 
		return page;
	}
	public void setPage(int page) { 
		this.page = page;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	
	public int getEndRowNum() {
		return getPage()*getPageSize();
	}
	//==> Select Query �� ROWNUM ���� ��
	public int getStartRowNum() {
		return (getPage()-1)*getPageSize()+1;
	}

	@Override
	public String toString() {
		return "Search [currentPage=" + page + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword
				+ ", pageSize=" + pageSize + ", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum + "]";
	}
}