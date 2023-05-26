<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>  
<%@ page import = "vo.Subject" %>    
<%
	TeacherDao td = new TeacherDao();
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	int row = td.deleteTeacher(teacherNo);
	if(row == 1){
		System.out.println("삭제성공");
	}else{
		System.out.println("삭제실패");
	}
	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
%>