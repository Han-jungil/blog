package vo;

public class PhotoCategoryName {
	public PhotoCategoryName() {}	// 생성자 메서드
	
	//정보은닉
	private String photoCategoryName;// 포토 카테고리 이름
	private String createDate;		// 최초생성날짜
	private String updateDate;		// 마지막수정날짜
	
	// 은닉 후 겟/셋터
	public String getPhotoCategoryName() {
		return photoCategoryName;
	}
	public void setPhotoCategoryName(String photoCategoryName) {
		this.photoCategoryName = photoCategoryName;
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

}
