<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>        
<% 
	
	request.setCharacterEncoding("UTF-8");
	
	SubjectDao sd = new SubjectDao();
	
	System.out.println(request.getParameter("subjectNo")+"<--subjectList subjectNo");
	System.out.println(request.getParameter("subjectName")+"<--subjectList subjectName");
	System.out.println(request.getParameter("subjectTime")+"<--subjectList subjectTime");
	
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);
		
	int row = sd.updateSubject(subject);
	if(row == 1){
		System.out.println("수정성공");
		
	}else{
		System.out.println("수정실패");
		response.sendRedirect(request.getContextPath()+"/subject/modifySubject.jsp?subjectNo="+subjectNo+"");
		return;
	}
	response.sendRedirect(request.getContextPath()+"/subject/subjectOne.jsp?subjectNo="+subjectNo);
%>	