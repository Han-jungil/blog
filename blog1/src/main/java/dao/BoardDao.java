package dao;
import java.sql.*;
import java.util.*;
import vo.*;
public class BoardDao {
	// 생성자 메서드
	public BoardDao() {}
	
		// 상세보기 - boardOne and update
			public Board updateBoardOne(int boardNo) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Board board = null; 
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비접속
			String dburl = "3.39.254.208/blog"; //주소
			String dbuser = "root";	//유저이름
			String dbpw = "java1234";	//비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, board_pw boardPw, create_date createDate, update_date updateDate FROM board WHERE board_no = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectboardOne" + stmt);//디버깅
			stmt.setInt(1, boardNo);
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			if(rs.next()) {
				board = new Board();
				board.setBoardNo(rs.getInt("boardNo"));
				board.setCategoryName(rs.getString("categoryName"));
				board.setBoardTitle(rs.getString("boardTitle"));
				board.setBoardContent(rs.getString("boardContent"));
				board.setBoardPw(rs.getString("boardPw"));
				board.setCreateDate(rs.getString("createDate"));
				board.setUpdateDate(rs.getString("updateDate"));
				}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return board;	// 값 리턴
			}
			
		// 입력 - insertBoardAction
			public void insertBoard(Board board) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅		
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 디비접속
			String dburl = "3.39.254.208/blog";	//주소
			String dbuser = "root";	//유저이름
			String dbpw = "java1234";	//비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql =" INSERT INTO board(category_name , board_title , board_content,board_pw,create_date,update_date) VALUES ( ?, ?, ?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql insertBoard : " + stmt);	//디버깅
			stmt.setString(1, board.getCategoryName());								
			stmt.setString(2, board.getBoardTitle());
			stmt.setString(3, board.getBoardContent());											
			stmt.setString(4, board.getBoardPw());
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
			
		// 수정 - updateBoard
			public int updateBoard(Board board) throws Exception {
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 디비접속
			String dburl = "3.39.254.208/blog"; //주소
			String dbuser = "root";	//유저이름
			String dbpw = "java1234";	//비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "UPDATE board SET category_name =?, board_title = ?, board_content = ?, update_date = NOW()  WHERE board_no = ? AND board_pw = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql updateBoard : " + stmt);	//디버깅
			stmt.setString(1, board.getCategoryName());								
			stmt.setString(2, board.getBoardTitle());
			stmt.setString(3, board.getBoardContent());	
			stmt.setInt(4, board.getBoardNo());
			stmt.setString(5, board.getBoardPw());
			row = stmt.executeUpdate();
			if(row == 1) { // 디버깅
				System.out.println("수정성공");
			} else {
				System.out.println("수정실패");
			}
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();

			return row;	// 값 리턴
			}
			
		// 삭제 - deleteBoardAction
			public int deleteBoard(int boardNo, String boardPw) throws Exception {
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
				
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; //주소
			String dbuser = "root"; //유저이름
			String dbpw = "java1234"; //비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql ="DELETE From board where board_no=? AND board_pw = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql deleteBoard : " + stmt);	//디버깅
			stmt.setInt(1, boardNo);
			stmt.setString(2, boardPw);
			row = stmt.executeUpdate();
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			return row;	//값 리턴
			}
		
		// 전체 행의 수를 반환 메서드(총합) - boardTotalRow
			public int boardTotalRow() throws Exception {
			// 데이터베이스 자원 준비
			int row = 0;
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 디비접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주속
			String dbuser = "root";	// 유저이름
			String dbpw = "java1234";// 비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL 실행
			String sql = "SELECT COUNT(*) cnt FROM board";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql boardTotalRow : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			if(rs.next()) {
				row = rs.getInt("cnt");
				}
			return row;	//값 리턴
			}
			
			
		// 카테고리별 행의 수를 반환 메서드 - ategoryBoardTotalRow
			public ArrayList<HashMap<String, Object>> categoryBoardTotalRow(String categoryName) throws Exception {
			// 데이터베이스 자원 준비
			Class.forName("org.mariadb.jdbc.Driver");
			System.out.println("드라이버 로딩 성공"); //디버깅
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
			
			// 디비 접속
			String dburl = "jdbc:mariadb://localhost:3306/blog"; // 주소
			String dbuser = "root";	// 유저이름
			String dbpw = "java1234"; // 비밀번호
			conn = DriverManager.getConnection(dburl, dbuser, dbpw);
			System.out.println("conn : " + conn); // 디버깅
			
			// SQL실행
			String sql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql categoryBoardTotalRow : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			
			// 데이터 변환(가공)
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("categoryName", rs.getString("categoryName"));
				map.put("cnt", rs.getInt("cnt"));
				categoryList.add(map);
				}
			return categoryList; // 값 리턴
			}
			
		// 카테고리가 null이면 모두 카테고리가 있다면 카테고리만 나오게하기 반환 메서드
		public ArrayList<Board> selectBoardListByPage(String categoryName, int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Board> list = new ArrayList<Board>();
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
			if(categoryName.equals("")) {	//	카테고리이름이 공백이면
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else {	// 카테고리 이름이 공백이 아니면
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name =? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, categoryName);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
			}
			System.out.println("sql selectBoardListByPage : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				Board b = new Board();
				b.setBoardNo(rs.getInt("boardNo"));		
				b.setCategoryName(rs.getString("categoryName"));		
				b.setBoardTitle(rs.getString("boardTitle"));							
				b.setCreateDate(rs.getString("createDate"));	
				list.add(b);
			}
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return list;	// 값 리턴
		}
		
		// searchBoardList 검색
			public ArrayList<Board> searchBoardListByPage(String selectSearch, String search, String categoryName, int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Board> list = new ArrayList<Board>();
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
			if(selectSearch.equals("")) {	//	검색이 공백이면
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else if(selectSearch.equals("boardTitle")) {	// 검색이 공백이 아니고 제목검색인 경우
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE board_title LIKE ? AND category_name LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+categoryName+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			} else if(selectSearch.equals("boardContent")) {	// 검색이 공백이 아니고 내용검색인 경우
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE board_content LIKE ? AND category_name LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+categoryName+"%");
				stmt.setInt(3, beginRow);
				stmt.setInt(4, rowPerPage);
			} else {	// 검색이 공백이 아니고 제목+내용검색인 경우
				sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE board_title LIKE ? AND board_content LIKE ? AND category_name LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
				stmt = conn.prepareStatement(sql);	//?값 구하기
				stmt.setString(1, "%"+search+"%");
				stmt.setString(2, "%"+search+"%");
				stmt.setString(3, "%"+categoryName+"%");
				stmt.setInt(4, beginRow);
				stmt.setInt(5, rowPerPage);
			}
			System.out.println("sql searchBoardListByPage : " + stmt);	//디버깅
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
			
			// 데이터 변환(가공)
			while(rs.next()) {
				Board b = new Board();
				b.setBoardNo(rs.getInt("boardNo"));		
				b.setCategoryName(rs.getString("categoryName"));		
				b.setBoardTitle(rs.getString("boardTitle"));							
				b.setCreateDate(rs.getString("createDate"));	
				list.add(b);
			}
			
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return list;	// 값 리턴
		}
			
}
