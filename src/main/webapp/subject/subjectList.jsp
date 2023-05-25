<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.SubjectDao" %>  
<%@ page import = "vo.Subject" %>   
<%
	SubjectDao sd = new SubjectDao();
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<-currentpage");
	int rowPerPage = 10;
	int beginRow =  (currentPage-1)*rowPerPage; 

	int totalRow = sd.selectSubjectCnt();
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
<title>Insert title here</title>
</head>
<body>
	<table>
	      <h1>subjectList</h1> 
					<div style="text-align:left;">
						<a  type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/subject/insertSubject.jsp" role="button">지역추가하기</a>&nbsp;&nbsp;
					</div>
					<table class="table table-hover">
						<tr class="table-info">
							<th>과목명</th>
							<th>진행시간</th>
							<th>생성일</th>
							<th>업데이트일</th>
							<th>수정</th>
							<th>삭제</th>
							
						</tr>
						<%
							for(Subject s : sd.selectSubjectListByPage(beginRow, rowPerPage)) {
						%>
								<tr>
									<td><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>" role="button"><%=s.getSubjectName()%></a></td>
									<td><%=s.getSubjectTime()%></td>
									<td><%=s.getCreatedate()%></td>
									<td><%=s.getUpdatedate()%></td>
									<th><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/subject/modifySubject.jsp?subjectNo=<%=s.getSubjectNo()%>" role="button">수정</a></th>
		      						<th><a class="btn btn-outline-dark" href="<%=request.getContextPath()%>/subject/removeSubjectAction.jsp?subjectNo=<%=s.getSubjectNo()%>" role="button">삭제</a></th>
								<tr>	
						<%
							}
						%>
						
					</table>	
					<div style="text-align:center;">
					<%
						if(currentPage>1){
					%>
							<a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=currentPage-1%>">이전</a>
					<%
						}
					%>
						<%=currentPage%>
					<% 	
						if(currentPage <lastPage) {
					%>
							<a class="btn btn-outline-dark"  href="<%=request.getContextPath()%>/subject/subjectList?currentPage=<%=currentPage+1%>">다음</a>
					<%
						}
					%>
					</div>
	
	</table>
</body>
</html>