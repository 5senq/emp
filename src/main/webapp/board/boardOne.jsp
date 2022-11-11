<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	// 1
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	// 댓글 페이징에 사용할 현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 2-1 게시글 하나
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	String boardSql = "SELECT board_title boardTitle, board_content boardContent, board_writer boardWriter, createdate FROM board WHERE board_no = ?";
	PreparedStatement boardStmt = conn.prepareStatement(boardSql);
	boardStmt.setInt(1, boardNo);
	ResultSet boardRs = boardStmt.executeQuery();
	Board board = null;
	if(boardRs.next()) {
		board = new Board();
		board.boardNo = boardNo;
		board.boardTitle = boardRs.getString("boardTitle");
		board.boardContent = boardRs.getString("boardContent");
		board.boardWriter = boardRs.getString("boardWriter");
		board.createdate = boardRs.getString("createdate");
	}
	// 2-2 댓글 목록
	/*
		SELECT comment_no commentNo, comment_content commentContent
		FROM comment
		WHERE board_no = ?
		ORDER BY comment_no DESC
		
		이슈) 댓글도 페이징이 필요하다
		LIMIT ?, ?
	*/
	
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	String commentSql = "SELECT comment_no commentNo, comment_content commentContent FROM comment WHERE board_no = ? ORDER BY comment_no DESC LIMIT ?, ?";
	PreparedStatement commentStmt = conn.prepareStatement(commentSql);
	commentStmt.setInt(1, boardNo);
	commentStmt.setInt(2, beginRow);
	commentStmt.setInt(3, rowPerPage);
	ResultSet commentRs = commentStmt.executeQuery();
	ArrayList<Comment> commentList = new ArrayList<Comment>();
	while(commentRs.next()) {
		Comment c = new Comment();
		c.commentNo = commentRs.getInt("commentNo");
		c.commentContent = commentRs.getString("commentContent");
		commentList.add(c);
	}
	// 2-3 댓글 전체행의 수 -> lastPage
	int lastPage = 0;
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
			.center {
				margin: auto;
			}
		</style>
		<title>boardOne</title>
	</head>
	<body>
		<h1 style="text-align:center">게시글 보기</h1>
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
		<div class="container">
			<!-- 댓글 입력 폼 -->
			<form action="<%=request.getContextPath()%>/board/insertCommentAction.jsp" method="post">
				<input type="hidden" name="boardNo" value="<%=boardNo%>">
				<table>
					<tr>
						<td><textarea rows="2" style="width:100%;" placeholder="댓글 쓰기" name="commentContent" ></textarea></td>
					</tr>
					<tr>
						<td>
							<input type="password" placeholder="비밀번호" name="commentPw">
							<button type="submit" class="btn btn-sm btn-dark">입력</button>
						</td>
				</table>
				
			</form>
		</div>
		<div class="container">
			<!-- 댓글 목록 -->
			<button data-bs-toggle="collapse" data-bs-target="#cmtList" class="btn btn-dark">댓글 보기</button>
			<div id="cmtList" class="collapse">
				<%
					for(Comment c : commentList) {
				%>
							<div>
								<%=c.commentNo%>&nbsp;<%=c.commentContent%>
								<a class="btn btn-sm btn-outline-danger" style="text-align:right" href="<%=request.getContextPath()%>/board/deleteCommentAction?commentNo=<%=c.commentNo%>&boardNo=<%=boardNo%>">삭제</a>
							</div>
				<%		
					}
				%>
			</div>
		</div>
	
	</body>
</html>