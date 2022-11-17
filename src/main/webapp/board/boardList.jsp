<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%
	// 1.요청 분석
	int currentPage = 1; // currentPage가 넘어와야하지만 혹시 넘어오지 않을 수도 있으니 1로 세팅
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 검색
	request.setCharacterEncoding("utf-8");
	String searchContent = request.getParameter("searchContent");
	// 1) searchContent == null / 2) searchContent == "" or "단어"
	
	// 2.요청 처리 후 모델데이터를 생성
	final int ROW_PER_PAGE = 10; // 상수는 대문자로
	int beginRow = (currentPage-1)*ROW_PER_PAGE; // 몇번째부터 몇개 ... Limit ?, ? -> (? 자리에) -> Limit beginRow, ROW_PER_PAGE
			
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/employees","root","java1234");
	
	// 2-1. 마지막 페이지 구하기 위한 쿼리
	String cntSql = null;
	PreparedStatement cntStmt = null;
	if(searchContent == null) { // null -> 전체 데이터 개수
		cntSql = "SELECT COUNT(*) cnt FROM board";
		cntStmt = conn.prepareStatement(cntSql);
	} else {
		cntSql = "SELECT COUNT(*) cnt FROM board WHERE board_content LIKE ?";
		cntStmt = conn.prepareStatement(cntSql);
		cntStmt.setString(1, "%"+searchContent+"%");
	}
	
	ResultSet cntRs = cntStmt.executeQuery();
	int cnt = 0; // 전체 행의 수
	if(cntRs.next()) {
		cnt = cntRs.getInt("cnt");
	}
	
	// 2-2. 불러오기
	String listSql = null;
	PreparedStatement listStmt = null;
	if(searchContent == null) { // null -> 전체 출력
		listSql = "SELECT board_no boardNo, board_title boardTitle FROM board ORDER BY board_no ASC LIMIT ?,?";
		listStmt = conn.prepareStatement(listSql);
		listStmt.setInt(1, beginRow);
		listStmt.setInt(2, ROW_PER_PAGE);
	} else { // 내용에 searchContent를 포함하는 게시글만 출력
		listSql = "SELECT board_no boardNo, board_title boardTitle FROM board WHERE board_content LIKE ? ORDER BY board_no ASC LIMIT ?,?";
		listStmt = conn.prepareStatement(listSql);
		listStmt.setString(1, "%"+searchContent+"%");
		listStmt.setInt(2, beginRow);
		listStmt.setInt(3, ROW_PER_PAGE);
	}
	
	ResultSet listRs = listStmt.executeQuery(); // model source data
	ArrayList<Board> boardList = new ArrayList<Board>();
	while(listRs.next()) {
		Board b = new Board();
		b.boardNo = listRs.getInt("boardNo");
		b.boardTitle = listRs.getString("boardTitle");
		boardList.add(b);
	}
	
	// 마지막 페이지
	// 나누어 떨어지지 않으면 올림 ex) 5.3 -> 6.0 
	int lastPage = (int)(Math.ceil((double)cnt / (double)ROW_PER_PAGE));
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
				text-align:center;
			}
		</style>
		<title>boardList</title>
	</head>
	<body>
		<h1 style="text-align:center">자유게시판</h1>
		<div class="container" style="text-align:right">
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		<!-- 3-1.모델데이터(ArrayList<Board>) 출력 -->
		<div class="container">
			<table class="table table-bordered">
				<tr>
					<th class="table-dark" style="width:200px;">글번호</th>
					<th class="table-dark" style="width:880px;">제목</th>
					<th class="table-dark">작성자</th>
					<th class="table-dark" style="width:120px;">작성날짜</th>
				</tr>
				<%
					for(Board b : boardList) {
				%>
						<tr>
							<td style="width:200px;"><%=b.boardNo%></td>
							<!-- 제목을 클릭하면 상세보기로 이동 -->
							<td style="width:880px;">
								<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.boardNo%>" class="text-decoration-none text-dark"><%=b.boardTitle%></a>
							</td>
							<td><%=b.boardWriter%></td>
							<td style="width:120px;"><%=b.createdate%></td>
						</tr>
				<%		
					}
				%>
			</table>
		</div>
		<div class="container" style="text-align:right">
			<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="text-decoration-none">&#9999;</a>
		</div>
		<!-- 3-2. 페이징 -->
		<div style="text-align:center">
			<a class="btn btn-sm btn-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=1">처음</a>
			<%
		    	if(currentPage > 1) {            
		    %>
		    		<a class="btn btn-sm btn-outline-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		    <%
		    	}
		      
		    	if(currentPage < lastPage) {
		    %>
		    		<span><%=currentPage%></span>      
		    		<a class="btn btn-sm btn-outline-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>">다음</a>   
		    <%   
		    	}
		    %>
		    <a class="btn btn-sm btn-dark" href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=lastPage%>">마지막</a>
			
		</div>
	</body>
</html>



