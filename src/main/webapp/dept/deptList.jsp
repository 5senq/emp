<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	// 1.요청분석(Controller)
	
	// 2.업무처리(Model) -> 모델데이터(단일값 or 자료구조형태(배열, 리스트, ...))
	Class.forName("org.mariadb.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	String sql = "SELECT dept_no deptNo, dept_name deptName FROM departments ORDER BY dept_no ASC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery(); // <- 모델데이터로서 ResultSet은 일반적인고 독립적인 타입이 아니라 특수한 곳에서만 쓸 수 있는 자료구조
	// ResultSet rs라는 모델자료구조를 좀 더 일반적이고 독립적인 자료구조로 변경을 하자
	
	ArrayList<Department> dept = new ArrayList<Department>();
	while(rs.next()) { // ResultSet의 API(사용방법)를 모른다면 사용할 수 없는 반복문
		Department d = new Department();
		d.deptNo = rs.getString("deptNo");
		d.deptName = rs.getString("deptName");
		dept.add(d);
	}
	// 3. 출력(View) -> 모델데이터를 고객이 원하는 형태로 출력 -> 뷰(리포트)

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<style>
			th, td {
				text-align: center;
			}
			h1 {
				color: #006F00;
			}
		</style>
		<title>Departments</title>
	</head>
	<body>
		<h1 style="text-align:center">부서목록</h1>
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<div class="container">
			<!-- 부서목록출력(부서번호 내림차순으로) -->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th class="bg-success text-white" style="width:200px;">부서번호</th>
						<th class="bg-success text-white" style="width:880px;">부서이름</th>
						<th class="bg-success text-white">수정</th>
						<th class="bg-success text-white">삭제</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Department d : dept) { // 자바 문법에서 제공하는 foreach문
					%>
					<tr>
						<td><%=d.deptNo%></td>
						<td><%=d.deptName%></td>
						<td><a href="<%=request.getContextPath()%>/dept/updateDeptForm.jsp?deptNo=<%=d.deptNo%>" class="text-decoration-none text-success" style="width:200px;">수정</a>
						<td><a href="<%=request.getContextPath()%>/dept/deleteDept.jsp?deptNo=<%=d.deptNo%>" class="text-decoration-none text-danger" style="width:880px;">삭제</a>
					</tr>
					<%		
						}
					%>
				</tbody>
			</table>
		</div>
		<div style="text-align:center">
			<a class="btn btn-success" href="<%=request.getContextPath()%>/dept/insertDeptForm.jsp">부서 추가</a>
		</div>
	</body>
</html>