package vo;

public class Pagination {

	private int rows;				// 한 화면에 표시할 데이터 갯수
	private int pages;				// 한 화면에 출력한 페이지번호 갯수
	private int totalRows;			// 전체 데이터 갯수
	private int currentPage;		// 요청한 페이지 번호
	private int totalPages;			// 전체 페이지 갯수
	private int totalBlocks;		// 전체 페이지번호 블록 갯수
	private int currentBlock;		// 요청한 페이지 번호에 대한 현재 페이지의 블록번호
	private int beginPage;			// 시작 페이지번호
	private int endPage;			// 끝 페이지번호
	private int beginIndex;			// 데이터 조회 시작위치
	private int endIndex;			// 데이터 조회 끝위치
	
	public Pagination(int totalRows, int currentPage) {
		this(5, totalRows, currentPage);
	}
	
	public Pagination(int rows, int totalRows, int currentPage) {
		this.rows = rows;
		this.pages = 5;
		this.totalRows = totalRows;
		this.currentPage = currentPage;
		init();
	}
	
	public void init() {
		if (totalRows == 0) {
			return;
		}
		
		this.totalPages = (int) Math.ceil((double) totalRows/rows);
		this.totalBlocks = (int )Math.ceil((double) totalPages/pages);
		if (currentPage <= 0) {
			this.currentPage = 1;
		}
		if (currentPage > totalPages) {
			this.currentPage = totalPages;
		}
		this.currentBlock = (int) (int) Math.ceil((double) currentPage/pages);
		this.beginPage = (currentBlock - 1)*pages + 1;
		this.endPage = currentBlock*pages;
		if (currentBlock == totalBlocks) {
			this.endPage = totalPages;
		}
		this.beginIndex = (currentPage - 1)*rows + 1;
		this.endIndex = currentPage*rows;
	}

	public int getRows() {
		return rows;
	}

	public int getPages() {
		return pages;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public int getTotalBlocks() {
		return totalBlocks;
	}

	public int getCurrentBlock() {
		return currentBlock;
	}

	public int getBeginPage() {
		return beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public int getBeginIndex() {
		return beginIndex;
	}

	public int getEndIndex() {
		return endIndex;
	}

}
