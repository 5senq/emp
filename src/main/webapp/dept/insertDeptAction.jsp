<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");
	// insertDeptAction.jsp이 실행되었을 경우 강제로 insertDeptForm.jsp으로 이동
	if(request.getParameter("deptName") == null) {
		
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp");
		return;
	}
	
	// 요청 분석
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	System.out.println("추가할 부서 정보 : " + deptNo + " " + deptName);
	
	// 요청 처리
	// 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	PreparedStatement stmt = conn.prepareStatement("INSERT INTO departments(dept_no, dept_name) Values(?, ?)");
	
	// sql insert문에 들어갈 값 세팅
	stmt.setString(1, deptNo);
	stmt.setString(2, deptName);
	
	stmt.executeUpdate();
	
	/* 디버깅
	int row = stmt.executeUpdate();
	if (row == 1) {
		System.out.println("입력성공");
	} else {
		System.out.println("입력실패");
	}
	*/
	
	// 결과 출력
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>