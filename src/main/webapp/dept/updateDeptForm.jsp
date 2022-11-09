<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");

	String deptNo = request.getParameter("deptNo");
	
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	String sql = "SELECT dept_no, dept_name FROM departments WHERE dept_no=?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	
	stmt.setString(1, deptNo);
	
	ResultSet rs = stmt.executeQuery();
	
	String deptName = null;
	if(rs.next()) {
		deptName = rs.getString("dept_name");
	}
	System.out.println("수정할 데이터 : " + deptNo + " " + deptName);
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<title>updateDeptForm</title>
	</head>
	<body>
		<div class="container">
			<form action="<%=request.getContextPath()%>/dept/updateDeptAction.jsp" method="post">
				<h1 class="bg-dark text-white" style="text-align:center">DEPT EDIT</h1>
				<table class="table table-bordered">
					<tr>
						<th>부서 번호</th>
						<td>
							<input type="text" name="deptNo" value="<%=deptNo%>" readonly="readonly" class="form-control">
						</td>
					</tr>
					<tr>
						<th>부서 이름</th>
						<td>
							<input type="text" name="deptName" value="<%=deptName%>" class="form-control">
						</td>
					</tr>
				</table>
				<div style="text-align:center">
					<button type="submit" class="btn btn-dark">수정</button>
				</div>
			</form>
		</div>
	</body>
</html>