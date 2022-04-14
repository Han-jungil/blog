package dao;
import java.sql.*;
import java.util.*;
import vo.*;

public class PdfDao {
	//한글호환
	//생성자 메서드
	public PdfDao() {}
	
		// Pdf 입력 -  insertPdfAction
			public void insertPdf(Pdf pdf) throws Exception{
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
			String sql =" INSERT INTO pdf(pdf_name, writer ,pdf_pw, pdf_original_name, pdf_type, create_date, update_date) VALUES ( ?, ?, ?, ?, ?, NOW(), NOW())";
			stmt = conn.prepareStatement(sql);	
			System.out.println("sql insertPdf" + stmt);//디버깅
			stmt.setString(1, pdf.getPdfName());
			stmt.setString(2, pdf.getWriter());											
			stmt.setString(3, pdf.getPdfPw());
			stmt.setString(4, pdf.getPdfOriginalName());
			stmt.setString(5, pdf.getPdfType());
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
			
		// 삭제 - deletePdfAction
			public int deletePdf(int pdfNo, String pdfPw) throws Exception {
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
			String sql ="DELETE From pdf where pdf_no=? AND pdf_pw = ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql deletePdf" + stmt);//디버깅
			stmt.setInt(1, pdfNo);
			stmt.setString(2, pdfPw);
			System.out.println("sql deletePdf : " + stmt);	//디버깅
			row = stmt.executeUpdate();
			// 데이터베이스 로직 끝
			
			// 데이터베이스 자원들 반환
			stmt.close();
			conn.close();
			return row; // 값 리턴
			}
		
		// 전체 행의 수를 반환 메서드 - selectPdfTotalRow
			public int selectPdfTotalRow() throws Exception {
			// 데이터베이스 자원 준비
			int row = 0;
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
			String sql = "SELECT COUNT(*) cnt FROM pdf";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectPdfTotalRow : " + stmt);	//디버깅
			
			// 데이터 변환(가공)
			rs = stmt.executeQuery();
				if(rs.next()) {
				row = rs.getInt("cnt");
				}
			// 데이터베이스 로직 끝
				
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
			return row;	// 값 리턴
			}
		
		// n행씩 반환 메서드 - selectPdfListByPage
			public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
			// 데이터베이스 자원 준비
			ArrayList<Pdf> list = new ArrayList<Pdf>();
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
			String sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			System.out.println("sql selectPdfListByPage : " + stmt);	//디버깅
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			// 데이터베이스 로직 끝
					
			// 데이터 변환(가공)
			while(rs.next()) {
				Pdf p = new Pdf();
				p.setPdfNo(rs.getInt("pdfNo"));
				p.setPdfOriginalName(rs.getString("pdfOriginalName"));
				p.setWriter(rs.getString("writer")); 
				p.setCreateDate(rs.getString("createDate"));
				list.add(p);
			}
					
			// 데이터베이스 자원들 반환
			rs.close();
			stmt.close();
			conn.close();
				
			return list; // 값 리턴
			}
			
			// searchPdfList 검색
				public ArrayList<Pdf> searchPdfListByPage(String selectSearch, String search, int beginRow, int rowPerPage) throws Exception {
				// 데이터베이스 자원 준비
				ArrayList<Pdf> list = new ArrayList<Pdf>();
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
				if(selectSearch.equals("writer")) {	//	작성자검색이면
					sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf WHERE writer LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, "%"+search+"%");
					stmt.setInt(2, beginRow);
					stmt.setInt(3, rowPerPage);
				} else {	// pdf이름이면
					sql = "SELECT pdf_no pdfNo, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf WHERE pdf_original_name  LIKE ? ORDER BY create_date DESC LIMIT ?, ?";
					stmt = conn.prepareStatement(sql);	//?값 구하기
					stmt.setString(1, "%"+search+"%");
					stmt.setInt(2, beginRow);
					stmt.setInt(3, rowPerPage);
				}
				System.out.println("sql searchBoardListByPage : " + stmt);	//디버깅
				rs = stmt.executeQuery();
				// 데이터베이스 로직 끝
				
				// 데이터 변환(가공)
				while(rs.next()) {
					Pdf p = new Pdf();
					p.setPdfNo(rs.getInt("PdfNo"));		
					p.setWriter(rs.getString("writer"));		
					p.setPdfOriginalName(rs.getString("pdfOriginalName"));							
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
