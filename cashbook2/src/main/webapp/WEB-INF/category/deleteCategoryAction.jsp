<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%
	 int num = Integer.parseInt(request.getParameter("num"));

	CategoryDao categoryDao = new CategoryDao( );
	categoryDao.deleteOne(num);
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
	
 %>
