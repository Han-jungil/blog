package dao;
import java.util.ArrayList;
import vo.Guestbook;
import java.sql.*;
public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	
		// 입력 - insertGuestbook
			public void insertGuestbook(Guestbook guestbook) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; //주소
			String dbuser = "root";	// 유저이름
			String dbpw = "java1234"; //비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql insertGuestbook" + stmt);//디버깅
			stmt.setString(1, guestbook.getGuestbookContent());
			stmt.setString(2, guestbook.getWriter());
			stmt.setString(3, guestbook.getGuestbookPw());
			int row = stmt.executeUpdate();
			if(row == 1) {	// 디버깅
				System.out.println("입력성공");
			} else {
				System.out.println("입력실패");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
		}
		
		// 상세보기(수정) - selectGuestbookOne
			public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Guestbook guestbook = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog";// 주소
			String dbuser = "root"; // 유저이름
			String dbpw = "java1234"; //비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectGuestbookOne : " + stmt);	//디버깅
			stmt.setInt(1, guestbookNo);
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			if(rs.next()) {
				guestbook = new Guestbook(); // 생성자메서드
				guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
				guestbook.setGuestbookContent(rs.getString("guestbookContent"));
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return guestbook;	// 값 리턴
		}

		// 수정 - updateGuestbook
			public int updateGuestbook(Guestbook guestbook) throws Exception{
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소
			String dbuser = "root"; //유저이름
			String dbpw = "java1234"; //비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "UPDATE guestbook SET guestbook_content=?, update_date=NOW() where guestbook_no =? and guestbook_pw";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql updateDateGuestbook : " + stmt); //디버깅
			stmt.setString(1, guestbook.getGuestbookContent());
			stmt.setInt(2,  guestbook.getGuestbookNo());
			stmt.setString(3,  guestbook.getGuestbookPw());
			row = stmt.executeUpdate();
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			return row; // 값 리턴
		}
		
		// 삭제 - deleteGuestbook
			public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception{
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			
			String dburl = "jdbc:mariadb://localhost:3306/blog";
			String dbuser = "root";
			String dbpw = "java1234";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql deleteGuestbook : " + stmt);//디버깅
			stmt.setInt(1, guestbookNo);
			stmt.setString(2, guestbookPw);
			row = stmt.executeUpdate();
			if(row == 1) { // 디버깅
				System.out.println("삭제성공");
			} else {
				System.out.println("삭제실패");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			return row;	// 값 리턴
		}
		
		// 전체 행의 수를 반환 메서드(총합) - selectGuestbookTotalRow
			public int selectGuestbookTotalRow() throws Exception {
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소
			String dbuser = "root"; // 유저이름
			String dbpw = "java1234"; // 비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			
			// SQL 실행
			String sql = "SELECT COUNT(*) cnt FROM guestbook";
			System.out.println("conn : " + conn); // 디버깅
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectGuestbookTotalRow" + stmt);//디버깅
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			if(rs.next()) {
				row = rs.getInt("cnt");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			rs.close();
			return row;	//값 리턴
		}
		
		
		// guestbook n행씩 반환 메서드 - selectGuestbookListByPage
			public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Guestbook> list = new ArrayList<Guestbook>();
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주속
			String dbuser = "root"; // 유저이름
			String dbpw = "java1234"; // 비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectGuestbookListByPage : " + stmt);	//디버깅
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				Guestbook g = new Guestbook();
				g.setGuestbookNo(rs.getInt("guestbookNo"));
				g.setGuestbookContent(rs.getString("guestbookContent"));
				g.setWriter(rs.getString("writer"));
				g.setCreateDate(rs.getString("createDate"));
				list.add(g);
				}
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return list; //값 리턴
			}
}