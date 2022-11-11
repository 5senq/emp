<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// 요청 분석
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	String boardWriter = request.getParameter("boardWriter");
	String boardPw = request.getParameter("boardPw");
	
	if(request.getParameter("boardTitle") == null || request.getParameter("boardContent") == null || request.getParameter("boardWriter") == null || request.getParameter("boardPw") == null || boardTitle.equals("") || boardContent.equals("") || boardWriter.equals("") || boardPw.equals("")) {
		return;
	}
	
	// 요청 처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	
	String sql = "INSERT INTO board(board_title boardTitle, board_content boardContent, board_writer boardWriter, board_pw boardPw, createdate) VALUES(?,?,?,?,CURDATE())";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	stmt.setString(3, boardWriter);
	stmt.setString(4, boardPw);
	
	int row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
	
%>