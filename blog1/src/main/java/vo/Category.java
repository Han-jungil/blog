package vo;
// category 테이블 VO(도메인객체) : VO, DTO(분산처리), Domain
public class Category {
	public Category() {}		// 생성자 메서드
	// 정보은닉
	private String categoryName;	// 카테고리이름
	private String createDate;	// 최초생성날짜
	private String updateDate;	// 마지막수정날짜
	
	// 은닉 후 겟/셋터
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
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
