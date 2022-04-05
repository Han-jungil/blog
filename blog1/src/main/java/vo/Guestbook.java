package vo;

public class Guestbook {
	public Guestbook() {}			// 생성자 메서드
	
	// 정보은닉
	private int guestbookNo;			// 번호
	private String guestbookContent;	// 게스트북 내용
	private String writer;			// 글쓴이
	private String createDate;		// 최초생성날짜
	private String updateDate;		// 마지막수정날짜
	private String guestbookPw;		// 비밀번호
	
	// 은닉 후 겟/셋터
	public int getGuestbookNo() {
		return guestbookNo;
	}
	public void setGuestbookNo(int guestbookNo) {
		this.guestbookNo = guestbookNo;
	}
	public String getGuestbookContent() {
		return guestbookContent;
	}
	public void setGuestbookContent(String guestbookContent) {
		this.guestbookContent = guestbookContent;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getGuestbookPw() {
		return guestbookPw;
	}
	public void setGuestbookPw(String guestbookPw) {
		this.guestbookPw = guestbookPw;
	}
	
}