<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %> 
<%@ page import = "java.util.*" %> 
        
<%
	request.setCharacterEncoding("UTF-8");
	
	TeacherDao td = new TeacherDao();
	
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	
	HashMap<String,Object> teacher = new HashMap<String,Object>();
	teacher.put("teacherId", teacherId);
	teacher.put("teacherName",teacherName);
	teacher.put("teacherHistory",teacherHistory);
	
	int row = td.insertTeacher(teacher);
	if(row == 1){
		System.out.println("추가성공");
	}else{
		System.out.println("추가실패");
		response.sendRedirect(request.getContextPath()+"/teacher/addTeacher.jsp");
		
		return;
	}
	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
	

%>