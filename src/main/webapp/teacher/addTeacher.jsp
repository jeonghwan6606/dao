<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>      
  
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <h1>teacher추가하기</h1>
	 <form action ="<%=request.getContextPath()%>/teacher/addTeacherAction.jsp" method="post">
	 	<table class="table table-hover">
			<tr class="table-info">
				<th>teacherId</th>
				<th>teacherName</th>		
				<th>메모</th>					
			</tr>
				
			<tr>
				<td><input type="text" name = teacherId required="required"></td>
				<td><input type="text" name = teacherName required="required"></td>
				<td><input type="text" name = teacherHistory required="required"></td>
			<tr>				
		</table>	
		<button type="submit">추가하기</button>
	</form> 
</body>
</html>