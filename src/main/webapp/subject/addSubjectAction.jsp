<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>        
<%
	request.setCharacterEncoding("UTF-8");
	
	SubjectDao sd = new SubjectDao();
	
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	Subject subject = new Subject();
	
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
	int row = sd.insertSubject(subject);
	if(row == 1){
		System.out.println("추가성공");
	}else{
		System.out.println("추가실패");
		response.sendRedirect(request.getContextPath()+"/subject/addSubject.jsp");
		
		return;
	}
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
%>