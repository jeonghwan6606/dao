<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>
<%@ page import = "vo.Teacher" %>
<%@ page import = "java.util.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	TeacherDao td = new TeacherDao();
	
	System.out.println(request.getParameter("teacherNo")+"<--teacherOne teacherNo");
	
	//링크 파라미터 값 가져와서 변환해주기
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	System.out.println(teacherNo+"<--teacherNo");
	
	String teacherName = request.getParameter("teacherName");
	
	//teacherOne 매소드를 통해 Hash타입의 teacher(객체)에 teacher 상세정보 담기
	HashMap<String,Object> teacher = td.selectTeacherOne(teacherNo);
	
	System.out.println(teacher.get("teacherNo")+"<--map modifyTeacher teacherNo");
	System.out.println(teacher.get("teacherId")+"<--map modifyTeacher teacherId");
	System.out.println(teacher.get("teacherName")+"<--map modifyTeacher teacherName");
	System.out.println(teacher.get("teacherHistory")+"<--map modifyTeacher teacherHistory");
	
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
	<h1>teacher(<%=teacherName%>)수정하기</h1> 
		 <form action ="<%=request.getContextPath()%>/teacher/modifyTeacherAction.jsp" method="post">
			<table class="table table-hover">
					
				<tr>
					<th class="table-info">teacherNo</th>
					<td><input type="text" name="teacherNo" value="<%=(Integer)teacher.get("teacherNo")%>" readonly="readonly"></td>											
				</tr>
				<tr>
					<th class="table-info">teacherId</th>
					<td><input type="text" name="teacherId" value="<%=(String)teacher.get("teacherId")%>"></td>											
				</tr>
				<tr>
					<th class="table-info">teacherName</th>
					<td><input type="text" name="teacherName" value="<%=(String)teacher.get("teacherName")%>"></td>											
				</tr>
				<tr>
					<th class="table-info">teacherHistory</th>
					<td><textarea name="teacherHistory"><%=(String)teacher.get("teacherHistory")%></textarea></td>											
				</tr>
					
				<tr>
					<th class="table-info">createdate</th>
					<td><%=(String)teacher.get("createdate")%></td>											
				</tr>	
				<tr>
					<th class="table-info">updatedate</th>
					<td><%=(String)teacher.get("updatedate")%></td>											
				</tr>									
			</table>
			<div style="text-align:left;">
				<button type="submit" class="btn btn-dark">수정하기</button>
			</div>
		</form>			
</body>
</html>