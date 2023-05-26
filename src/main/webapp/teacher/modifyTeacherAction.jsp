<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>
<%@ page import = "vo.Teacher" %>
<%@ page import = "java.util.*" %>    
<%
	request.setCharacterEncoding("UTF-8");
	TeacherDao td = new TeacherDao();
	
	//가져온 teacher 정보값 디버깅하기
	System.out.println(request.getParameter("teacherNo")+"<--modifyTeacherAction teacherNo");
	System.out.println(request.getParameter("teacherName")+"<--modifyTeacherAction teacherName");
	System.out.println(request.getParameter("teacherId")+"<--modifyTeacherAction teacherId");
	System.out.println(request.getParameter("teacherHistory")+"<--modifyTeacherAction teacherHistory");
	
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	String teacherName = request.getParameter("teacherName");
	String teacherId = request.getParameter("teacherId");
	String teacherHistory = request.getParameter("teacherHistory");
	
	//변환값들로 Teacher 타입인 teacher 객체에 정보 저장
	Teacher teacher = new Teacher();
	teacher.setTeacherHistory(teacherHistory);
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherNo(teacherNo);
	
	//updateTeacher 매소드를 통해 row값 반환받기
	int row =  td.updateTeacher(teacher);
	//row값에 따라 분기하여 redirect
	if(row == 1){
		System.out.println("수정성공");
	}else{
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/teacher/modifyTeacher.jsp?teacherNo="+teacherNo+"&teacherName="+teacherName);
		
		return;
	}
	response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
%>