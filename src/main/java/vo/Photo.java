package vo;

public class Photo {
	public Photo() {}					// 생성자 메서드
	
	// 정보은닉
	private int photoNo;					// 번호
	private String photoName;			// 이름
	private String photoOriginalName;	// 원래이름
	private String photoType;			// 타입
	private String photoPw;				// 비밀번호
	private String writer;				// 글쓴이
	private String createDate;			// 최초생성날짜
	private String updateDate;			// 마지막수정날짜
	private String photoCategoryName;	// 포토카테고리이름
	
	// 은닉 후 겟/셋터
	public int getPhotoNo() {
		return photoNo;
	}
	public void setPhotoNo(int photoNo) {
		this.photoNo = photoNo;
	}
	public String getPhotoName() {
		return photoName;
	}
	public void setPhotoName(String photoName) {
		this.photoName = photoName;
	}
	public String getPhotoOriginalName() {
		return photoOriginalName;
	}
	public void setPhotoOriginalName(String photoOriginalName) {
		this.photoOriginalName = photoOriginalName;
	}
	public String getPhotoType() {
		return photoType;
	}
	public void setPhotoType(String photoType) {
		this.photoType = photoType;
	}
	public String getPhotoPw() {
		return photoPw;
	}
	public void setPhotoPw(String photoPw) {
		this.photoPw = photoPw;
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
	public String getPhotoCategoryName() {
		return photoCategoryName;
	}
	public void setPhotoCategoryName(String photoCategoryName) {
		this.photoCategoryName = photoCategoryName;
	}
	
}
