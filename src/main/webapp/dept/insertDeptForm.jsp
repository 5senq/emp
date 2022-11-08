<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<title>insertDeptAction</title>
	</head>
	<body>
		<div class="container">
			<form action="<%=request.getContextPath()%>/insertDeptAction.jsp" method="post">
				<h1 style="text-align:center">부서 추가</h1>
				<table class="table table-bordered">
					<tr>
						<th>부서 번호</th>
						<td><input type="text" name="deptNo" value=""></td>
					</tr>
					<tr>
						<th>부서 이름</th>
						<td><input type="text" name="deptName" value=""></td>
					</tr>
				</table>
				<div>
					<button type="submit">입력</button>
				</div>
			</form>
		</div>
	</body>
</html>