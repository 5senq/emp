<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="vo.Department"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");
	// insertDeptAction.jsp이 실행되었을 경우 강제로 updateDeptForm.jsp으로 이동

	// 요청 분석
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	System.out.println("수정한 데이터 : " + deptNo + " " + deptName);
	
	// 요청 처리
	// 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	String sql = "UPDATE departments SET dept_name = ? WHERE dept_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	// sql insert문에 들어갈 값 세팅
	stmt.setString(1, deptName);
	stmt.setString(2, deptNo);
	
	stmt.executeUpdate();
	
	// 결과 출력
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>