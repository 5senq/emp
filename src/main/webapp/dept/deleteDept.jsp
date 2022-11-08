<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");

	// 요청 분석
	String deptNo = request.getParameter("dept_no");
	System.out.println("dept_no : " + deptNo);

	// 요청 처리
	// 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	String sql = "DELETE FROM departments WHERE dept_no =?;";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, deptNo);
	
	int row = stmt.executeUpdate();
	
	if(row == 1) {
		System.out.println("삭제성공");
	} else {
		System.out.println("삭제실패");
	}
	
	response.sendRedirect(request.getContextPath()+"deptList.jsp");
%>