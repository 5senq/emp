<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>
<%
	// 한글 처리
	request.setCharacterEncoding("utf-8");
	// insertDeptAction.jsp이 실행되었을 경우 강제로 updateDeptForm.jsp으로 이동

	// 요청 분석
	String deptNo = request.getParameter("deptNo");
	String deptName = request.getParameter("deptName");
	if(deptNo == null || deptName == null || deptNo.equals("") || deptName.equals("")) {
		String msg = URLEncoder.encode("부서 번호와 부서 이름을 입력하세요.","utf-8"); // get 방식 주소창에 문자열 인코딩
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg="+msg);
		return;
	}
	
	// 요청 처리
	// 연결
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	// 접속
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	String sql1 = "SELECT * FROM departments WHERE dept_no = ? OR dept_name = ?";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	
	// sql insert문에 들어갈 값 세팅
	stmt1.setString(1, deptNo);
	stmt1.setString(2, deptName);
	ResultSet rs = stmt1.executeQuery();
	if(rs.next()) {
		String msg = URLEncoder.encode("부서 번호 또는 부서 이름이 중복되었습니다.","utf-8");
		response.sendRedirect(request.getContextPath()+"/dept/insertDeptForm.jsp?msg="+msg);
		return;
	}
	
	String sql2 = "INSERT INTO departments(dept_no, dept_name) value(?,?)";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1,deptNo);
	stmt2.setString(2,deptName);
	int row = stmt2.executeUpdate();
	response.sendRedirect(request.getContextPath()+"/dept/deptList.jsp");
%>