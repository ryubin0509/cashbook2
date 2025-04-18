package dto;

public class Paging {
	
	private int currentPage;
	private int rowPerPage;
	
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	public int getlastPage(int total) {
		int  lastPage = 0;
		lastPage =  (int) Math.ceil((double) total/rowPerPage);
		
		return  lastPage;
	}
	
	public int getBeginRow() {
		int beginRow = 0;
		beginRow = (currentPage-1)*rowPerPage; 
		
		return beginRow ;
	}
	
	
	
}
