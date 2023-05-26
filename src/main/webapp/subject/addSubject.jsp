<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>    
<% 
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
	 <h1>과목추가하기</h1>
	 <form action ="<%=request.getContextPath()%>/subject/addSubjectAction.jsp" method="post">
	 	<table class="table table-hover">
			<tr class="table-info">
				<th>과목명</th>
				<th>진행시간</th>							
			</tr>
				
			<tr>
				<td><input type="text" name = subjectName required="required"></td>
				<td><input type="text" name = subjectTime required="required"></td>
		
			<tr>				
		</table>	
		<button type="submit">추가하기</button>
	</form> 
</body>
</html>