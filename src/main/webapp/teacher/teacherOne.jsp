<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>
<%@ page import = "java.util.*" %>
<% 
	TeacherDao td = new TeacherDao();

	System.out.println(request.getParameter("teacherNo")+"teacherOne teacherNo");
	
	//링크 파라미터 값 가져와서 변환해주기
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	System.out.println(teacherNo+"teacherNo");
	
	String teacherName = request.getParameter("teacherName");
	
	HashMap<String,Object> teacher = td.selectTeacherOne(teacherNo);

%>   
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <h1>teacher(<%=teacherName%>)상세보기</h1> 
					<div style="text-align:left;">
						<a  type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/teacher/modifyTeacher.jsp?teacherNo=<%=teacher.get("teacherNo")%>&teacherName=<%=teacher.get("teacherName") %>" role="button">수정하기</a>&nbsp;&nbsp;
						<a  type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/teacher/removeTeacherAction.jsp?teacherNo=<%=teacher.get("teacherNo")%>" role="button">삭제하기</a>&nbsp;&nbsp;
					</div>
					<table class="table table-hover">
					
						<tr>
							<th class="table-info">teacherNo</th>
							<td><%=teacher.get("teacherNo")%></td>											
						</tr>
						<tr>
							<th class="table-info">teacherId</th>
							<td><%=(String)teacher.get("teacherId")%></td>											
						</tr>
						<tr>
							<th class="table-info">teacherName</th>
							<td><%=(String)teacher.get("teacherName")%></td>											
						</tr>
						<tr>
							<th class="table-info">teacherHistory</th>
							<td><%=(String)teacher.get("teacherHistory")%></td>											
						</tr>
						<tr>
						<tr>
							<th class="table-info">createdate</th>
							<td><%=(String)teacher.get("createdate")%></td>											
						</tr>	
						<tr>
						<tr>
							<th class="table-info">updatedate</th>
							<td><%=(String)teacher.get("updatedate")%></td>											
						</tr>									
					</table>	
</body>
</html>