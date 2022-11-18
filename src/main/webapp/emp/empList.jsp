<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%
	// 1
	// 페이지 알고리즘
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
   
	// 검색
	request.setCharacterEncoding("utf-8");
	String search = request.getParameter("search");
	// 1. search == null, 2) search == "" or "단어"
   
	// 2
	int rowPerPage = 10;
   
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees", "root", "java1234");
   
	// lastPage 처리
	String countSql = null;
	PreparedStatement countStmt = null;
	if(search == null) { // 전체 출력
		countSql = "SELECT COUNT(*) FROM employees";
		countStmt = conn.prepareStatement(countSql);
   
	} else {
		countSql = "SELECT COUNT(*) FROM employees WHERE first_name LIKE ? OR last_name LIKE ?";
		countStmt = conn.prepareStatement(countSql);
		countStmt.setString(1, "%" + search + "%");
		countStmt.setString(2, "%" + search + "%");
	}
   
   
	ResultSet countRs = countStmt.executeQuery();
	int count = 0;
	if(countRs.next()) {
		count = countRs.getInt("COUNT(*)");
	}
   
	int lastPage = count / rowPerPage;
	if(count / rowPerPage != 0) {
		lastPage++; // 나머지가 있다면 몫 + 1
	}
   
	// 한페이지당 출력할 emp목록
	String empSql = null;
	PreparedStatement empStmt = null;
	if(search == null) {
		empSql = "SELECT emp_no empNo, first_name firstName, last_name lastName, hire_date hireDate FROM employees ORDER BY emp_no ASC LIMIT ?, ?";
		empStmt = conn.prepareStatement(empSql);
		empStmt.setInt(1, rowPerPage * (currentPage -1));
		empStmt.setInt(2, rowPerPage);
	} else {
		empSql = "SELECT emp_no empNo, first_name firstName, last_name lastName, hire_date hireDate FROM employees WHERE first_name LIKE ? OR last_name LIKE ? ORDER BY emp_no ASC LIMIT ?, ?";
		empStmt = conn.prepareStatement(empSql);
		empStmt.setString(1, "%" + search + "%");
		empStmt.setString(2, "%" + search + "%");
		empStmt.setInt(3, rowPerPage * (currentPage -1));
		empStmt.setInt(4, rowPerPage);
	}
	
	ResultSet empRs = empStmt.executeQuery();
   
	ArrayList<Employee> empList = new ArrayList<Employee>();
	while(empRs.next()) {
		Employee e = new Employee();
		e.empNo = empRs.getInt("empNo");
		e.firstName = empRs.getString("firstName");
		e.lastName = empRs.getString("lastName");
		e.hireDate = empRs.getString("hireDate");
		empList.add(e);
	}
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
		</style>
		<title>empList</title>
	</head>
	<body>
		<h1 style="text-align:center">사원 명단</h1>
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<!-- 검색창 -->
		<!-- 즐겨찾기 등에 쓸 주소를 저장하려고 get 방식을 사용할 때가 있음 / <a>는 무조건 get 방식 -->
		<form action="<%=request.getContextPath()%>/emp/empList.jsp" method="post">
			<label for="search">
				<input type="text" name="search" id="search" placeholder="이름 검색">
			</label>
			<button type="submit" class="btn btn-sm btn-outline-dark">검색</button>
		</form>
		
		<div class="container">
			<table class="table table-bordered">
				<tr>
					<th class="table-dark" style="width:200px;">사원번호</th>
					<th class="table-dark" style="width:880px;">이름</th>
					<th class="table-dark">입사일</th>
				</tr>
				<%
					for(Employee e : empList) {
				%>
		            <tr>
						<td style="width:200px;"><%=e.empNo%></td>
						<td style="width:880px;"><%=e.firstName%> <%=e.lastName%></td>
						<td><%=e.hireDate%></td>
		            </tr>
				<%      
					}
				%>
			</table>
		</div>
	   
	   <!-- 페이징 코드 -->
		<div style="text-align:center">
			<a class="btn btn-sm btn-dark" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=1">처음</a>
			<%
				if(currentPage > 1) {            
			%>
				<a class="btn btn-sm btn-outline-dark" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
	      
				if(currentPage < lastPage) {
			%>
				<span><%=currentPage%></span>      
				<a class="btn btn-sm btn-outline-dark" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=currentPage+1%>">다음</a>   
			<%   
				}
			%>
	      
			<a class="btn btn-sm btn-dark" href="<%=request.getContextPath()%>/emp/empList.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>