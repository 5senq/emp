<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<title>insertDeptForm</title>
	</head>
	<body>
		<div class="container">
			<form action="<%=request.getContextPath()%>/dept/insertDeptAction.jsp" method="post">
				<h1 class="bg-dark text-white" style="text-align:center">DEPT ADD</h1>
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menuBack.jsp"></jsp:include>
		</div>		
				<table class="table table-bordered">
					<tr>
						<th>부서 번호</th>
						<td><input type="text" name="deptNo" value="" class="form-control"></td>
					</tr>
					<tr>
						<th>부서 이름</th>
						<td><input type="text" name="deptName" value="" class="form-control"></td>
					</tr>
				</table>
				<div style="text-align:center">
					<button type="submit" class="btn btn-dark">입력</button>
				</div>
			</form>
		</div>
	</body>
</html>