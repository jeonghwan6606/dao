<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>    

<% 
	SubjectDao sd = new SubjectDao();

	System.out.println(request.getParameter("subjectNo"));
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	Subject subject = sd.selectSubjectOne(subjectNo);
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	 <h1>과목상세보기</h1>
	 <form action ="<%=request.getContextPath()%>/subject/modifySubjectAction.jsp" method="post">
	 <table class="table table-hover">
			<tr class="table-info">
				<th>과목번호</th>
				<th>과목명</th>
				<th>진행시간</th>
				<th>생성일</th>
				<th>업데이트일</th>
				<th>수정</th>
				<th>삭제</th>
							
			</tr>
				
			<tr>
				<td><input type="text" name = subjectNo value="<%=subject.getSubjectNo()%>" readonly="readonly"></td>
				<td><input type="text" name = subjectName value="<%=subject.getSubjectName()%>"></td>
				<td><input type="text" name = subjectTime value="<%=subject.getSubjectTime()%>"></td>
				<td><%=subject.getCreatedate()%></td>
				<td><%=subject.getUpdatedate()%></td>
				<th><button type="submit">수정</button></th>
		        <th><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=subject.getSubjectNo()%>" role="button">삭제</a></th>
			<tr>				
						
		</table>	
		</form> 
</body>
</html>