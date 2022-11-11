<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String msg = request.getParameter("msg"); // 수정실패 리다이렉시에는 null값이 아니고 메세지 有
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<!-- Latest compiled and minified CSS -->
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
		<!-- Latest compiled JavaScript -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
		<title>deleteBoardForm</title>
	</head>
	<body>
		<h1 style="text-align:center">게시글 삭제</h1>
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<%
			if(msg != null) {
		%>
				<div><%=msg%></div>
		<%		
			}
		%>
		<form action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp" method="post" style="text-align:center">
			<input type="hidden" name="boardNo" value="<%=boardNo%>">
			비밀번호 :
			<input type="password" name="boardPw">
			<button type="submit" class="btn btn-sm btn-dark">삭제</button>
		</form>
	</body>
</html>