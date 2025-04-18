<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="model.*" %>
<%
	if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
    	response.sendRedirect("/cashbook/login/logout.jsp");
    	return;
}
%> 

<%

	 String kind = request.getParameter("category");
	 String title  = request.getParameter("title");
	 
	 Category c = new Category();
	 c.setKind(kind);
	 c.setTitle(title);
	 
	 CategoryDao categoryDao = new CategoryDao();
	 
	categoryDao.insertCategory(c); //  카테고리 추가 완료
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
	
	
	
%>