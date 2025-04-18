<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import = "model.*" %>
<%
	int num = 	Integer.parseInt(request.getParameter("num"));
    String kind = request.getParameter("category");
    String title = request.getParameter("title");
    
    Category  category = new Category();
	category.setNum(num);
	category.setKind(kind);
	category.setTitle(title);
	
	CategoryDao categoryDao = new CategoryDao();
	
	categoryDao.updateOne(category);
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>
<!DOCTYPE html>
