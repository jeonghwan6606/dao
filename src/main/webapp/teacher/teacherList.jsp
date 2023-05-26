<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.TeacherDao" %>  
<%@ page import = "java.util.*" %>
<%
	TeacherDao td = new TeacherDao();	
		
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<-currentpage");
		
	//리스트가져오기
	int rowPerPage = 10;
	int beginRow =  (currentPage-1)*rowPerPage; 

	ArrayList<HashMap<String, Object>> teacherList = td.selectTeacherListByPage(beginRow,rowPerPage);	
	
	//전체행수 구하기
	int totalRow = td.teacherSubjectCnt();
	int lastPage = totalRow / rowPerPage;  
	
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	int pagePerPage = 10; //페이지마다 10쪽의 papagerPage
	//페이징 알고리즘에 따라 minPage 및 maxPage 정의 		
	int minPage = (((currentPage-1)/pagePerPage)*pagePerPage) +1;
	int maxPage = minPage + (pagePerPage-1);
	if(maxPage > lastPage){//마지막 페이지보다 maxPage가 클경우 라스트페이지와 같게 설정 (다음 버튼 생성 조건에 필요)
			maxPage = lastPage;
	}
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
	
	      <h1>teacherList</h1> 
					<div style="text-align:left;">
						<a  type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/teacher/addTeacher.jsp" role="button">teacher추가하기</a>&nbsp;&nbsp;
					</div>
					<table class="table table-hover">
						<tr class="table-info">
							<th>teacherNo</th>
							<th>teacherId</th>
							<th>teacherName</th>
							<th>subjectNo</th>
							<th>subjectName</th>				
						</tr>
						<%
							for(HashMap<String, Object> t : teacherList) {
						%>
								 <tr class="table-active">
									<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=t.get("teacherNo")%>&teacherName=<%=t.get("teacherName")%>"><%=t.get("teacherNo")%></a></td>
									<td><%=(String)t.get("teacherId")%></td>
									<td><%=(String)t.get("teacherName")%></td>
									<td><%=t.get("subjectNo")%></td>
									<td><%=(String)t.get("subjectName")%></td>
								<tr>	
						<%
							}
						%>
						
					</table>	
					<div style="text-align:center;">
					<%
						if(currentPage>1){
					%>
							<a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=currentPage-1%>">이전</a>
					<%
						}
					%>
						<%=currentPage%>
					<% 	
						if(currentPage <lastPage) {
					%>
							<a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=currentPage+1%>">다음</a>
					<%
						}
					%>
					</div>
	
	
</body>
</html>