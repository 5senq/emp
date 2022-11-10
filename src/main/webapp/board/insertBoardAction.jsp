<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// 요청 분석
	String boardTitle = request.getParameter("boardTitle");
	String boardContent = request.getParameter("boardContent");
	if(boardTitle == null || boardContent == null || boardTitle.equals("") || boardContent.equals("")) {
		String msg = URLEncoder.encode("","utf-8");
		response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+msg);
		return;
	}
	
	// 요청 처리
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	
	String sql = "INSERT INTO board(board_title, board_content) value(?,?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, boardTitle);
	stmt.setString(2, boardContent);
	int row = stmt.executeUpdate();
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	
	
%>