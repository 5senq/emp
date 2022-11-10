<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	// 1
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	
	// 2
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	String sql = "SELECT board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate FROM board WHERE board_no = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	ResultSet rs = stmt.executeQuery();
	Board board = null;
	if(rs.next()) {
		board = new Board();
		board.boardNo = boardNo;
		board.boardTitle = rs.getString("boardTitle");
		board.boardContent = rs.getString("boardContent");
		board.boardWriter = rs.getString("boardWriter");
		board.createdate = rs.getString("createdate");
	}
	// 3 
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
			th {
				width: 100px;
				text-align: center;
			}
		</style>
		<title>boardOne</title>
	</head>
	<body>
		<h1 style="text-align:center">게시글 상세보기</h1>
		<!-- 메뉴 partial jsp 구성 -->
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<div class="container">
			<table class="table table-bordered">
				<tr>
					<th class="table-dark">글 번호</th>
					<td><%=board.boardNo%></td>
				</tr>
				<tr>
					<th class="table-dark">제목</th>
					<td><%=board.boardTitle%></td>
				</tr>
				<tr>
					<th class="table-dark">내용</th>
					<td><%=board.boardContent%></td>
				</tr>
				<tr>
					<th class="table-dark">작성자</th>
					<td><%=board.boardWriter%></td>
				</tr>
				<tr>
					<th class="table-dark">작성날짜</th>
					<td><%=board.createdate%></td>
				</tr>
			</table>
		</div>
		<div style="text-align:center">
			<a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=boardNo%>">수정</a>
			<a class="btn btn-dark" href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=boardNo%>">삭제</a>
		</div>
	</body>
</html>