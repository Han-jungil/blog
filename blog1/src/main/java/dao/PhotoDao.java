package dao;
import java.sql.*;
import java.util.*;
import vo.*;


public class PhotoDao {
	//생성자 메서드
	public PhotoDao() {}
	
		// 상세보기 - selectPhotoOne
			public Photo selectPhotoOne(int photoNo) throws Exception{
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			
			// 데이터베이스 자원 준비
			Photo photo = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
				
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; //주소
			String dbuser = "root";	//유저이름
			String dbpw = "java1234";	//비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT photo_no photoNo, photo_name photoName, writer,photo_type photoType, photo_categoryName photoCategoryName, photo_pw photoPw,photo_original_name photoOriginalName, create_date createDate, update_date updateDate FROM photo WHERE photo_no = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectPhotoOne : " + stmt);//디버깅
			stmt.setInt(1, photoNo);
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			if(rs.next()) {
				photo = new Photo();
				photo.setPhotoNo(rs.getInt("photoNo"));
				photo.setPhotoName(rs.getString("photoName"));
				photo.setPhotoOriginalName(rs.getString("photoOriginalName"));
				photo.setPhotoPw(rs.getString("photoPw"));
				photo.setPhotoType(rs.getString("photoType"));
				photo.setWriter(rs.getString("writer"));
				photo.setPhotoCategoryName(rs.getString("photoCategoryName"));
				photo.setCreateDate(rs.getString("createDate"));
				photo.setUpdateDate(rs.getString("updateDate"));
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return photo;  // 값 리턴
		}
			
		// 입력 - insertPhoto
			public void insertPhoto(Photo photo) throws Exception{
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";//주소
			String dbuser = "root";//유저이름
			String dbpw = "java1234";//비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql =" INSERT INTO photo(photo_categoryName,photo_name , writer ,photo_pw, photo_original_name, photo_type, create_date, update_date) VALUES ( ?, ?, ?, ?, ?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql insertPhoto : " + stmt);//디버깅
			stmt.setString(1, photo.getPhotoCategoryName());								
			stmt.setString(2, photo.getPhotoName());
			stmt.setString(3, photo.getWriter());											
			stmt.setString(4, photo.getPhotoPw());
			stmt.setString(5, photo.getPhotoOriginalName());
			stmt.setString(6, photo.getPhotoType());
			int row = stmt.executeUpdate();
			if(row == 1) { // 디버깅
				System.out.println("입력성공");
			} else {
				System.out.println("입력실패");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			}
			
		// 이미지 삭제	- deletePhoto
			public int deletePhoto(int photoNo, String photoPw) throws Exception { 
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			// 데이터베이스 자원 준비
			Connection conn = null;
			PreparedStatement stmt = null;
				
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; //주소
			String dbuser = "root"; //유저이름
			String dbpw = "java1234"; //비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql ="DELETE From photo where photo_no=? AND photo_pw = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql deletePhoto : " + stmt);	//디버깅
			stmt.setInt(1, photoNo);
			stmt.setString(2, photoPw);
			row = stmt.executeUpdate();
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			return row;  // 값 리턴
		}
		
		// 전체 행의 수를 반환 메서드(총합) - selectPhotoTotalRow
			public int selectPhotoTotalRow() throws Exception{
			// 데이터베이스 자원 준비
			int total = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT COUNT(*) cnt FROM photo";
			stmt = conn.prepareStatement(sql);
			System.out.println(" sql selectPhotoTotalRow : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			rs.close();
			return total;  // 값 리턴
		}
		
		// photo 카테고리별 행의 수를 반환 메서드 - categoryPhotoTotalRow
			public ArrayList<HashMap<String, Object>> categoryPhotoTotalRow(String photoCategoryName) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
					
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT photo_categoryName photoCategoryName, COUNT(*) cnt FROM photo GROUP BY photo_categoryName";
			stmt = conn.prepareStatement(sql);
			System.out.println(" sql categoryPhotoTotalRow : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			ArrayList<HashMap<String, Object>> photoCategoryNameList = new ArrayList<HashMap<String, Object>>();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("photoCategoryName", rs.getString("photoCategoryName"));
				map.put("cnt", rs.getInt("cnt"));
				photoCategoryNameList.add(map);
			}
			
			// 데이터베이스 자원들 반환
			conn.close();
			stmt.close();
			rs.close();
			return photoCategoryNameList; // 값 리턴
		}
		
		// 이미지 목록 null이면 모두 카테고리가 있다면 카테고리만 나오게하기 반환 메서드 - selectPhotoListByPage
			public ArrayList<Photo> selectPhotoListByPage(String photoCategoryName, int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Photo> list = new ArrayList<Photo>();
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = null;
			
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL문 실행
			if(photoCategoryName.equals("")) {	//	카테고리이름이 공백이면
				sql = "SELECT photo_no photoNo, photo_name photoName FROM photo ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else {	// 카테고리 이름이 공백이 아니면
				sql = "SELECT photo_no photoNo, photo_name photoName FROM photo WHERE photo_categoryName =? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, photoCategoryName);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
				}
			System.out.println(" sql selectPhotoListByPage : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				Photo p = new Photo();
				p.setPhotoNo(rs.getInt("photoNo"));					
				p.setPhotoName(rs.getString("photoName"));			
				list.add(p);
			}
						
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return list;  // 값 리턴
			}
			
			
		// searchPhotoList 검색
			public ArrayList<Photo> searchPhotoListByPage(String selectSearch, String search, String photoCategoryName, int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Photo> list = new ArrayList<Photo>();
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			String sql = null;
			
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL문 실행
			if(selectSearch.equals("writer")) {	//	검색이 작성자이면
				sql = "SELECT photo_no photoNo, photo_name photoName, writer, photo_categoryName photoCategoryName, create_date createDate FROM photo WHERE writer LIKE ? AND photo_categoryName LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+photoCategoryName+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			} else {	// 검색이 사진이름이면
				sql = "SELECT photo_no photoNo, photo_name photoName, writer, photo_categoryName photoCategoryName, create_date createDate FROM photo WHERE photo_name LIKE ? AND photo_categoryName LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+photoCategoryName+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			}
			System.out.println("sql searchPhotoListByPage : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				Photo p = new Photo();
				p.setPhotoNo(rs.getInt("photoNo"));		
				p.setPhotoCategoryName(rs.getString("photoCategoryName"));	
				p.setPhotoName(rs.getString("photoName"));
				p.setWriter(rs.getString("writer"));							
				p.setCreateDate(rs.getString("createDate"));	
				list.add(p);
			}
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return list;	// 값 리턴
		}
}

