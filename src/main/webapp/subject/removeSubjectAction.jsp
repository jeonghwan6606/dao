<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>    
<%
	SubjectDao sd = new SubjectDao();
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	int row = sd.deleteSubject(subjectNo);
	if(row == 1){
		System.out.println("삭제성공");
	}else{
		System.out.println("삭제실패");
	}
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
%>