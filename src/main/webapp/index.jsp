<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<title>index</title>
	</head>
	<body class="container text-center">
		<div>
		<h1 style="text-align:center">INDEX</h1>
		</div>
		<div>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/dept/deptList.jsp">부서 관리</a>
		</div>
	</body>
</html>