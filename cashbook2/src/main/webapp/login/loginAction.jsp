<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="model.*" %>
<%
	String id = request.getParameter("id");
 	String pw = request.getParameter("pw");
 	
 	Admin admin = new Admin();
 	
 	admin.setId(id);   // id 설정 
 	admin.setPw(pw); // 비밀번호 설정
 	
 	AdminDao admindao = new AdminDao();
 	
 	Admin checkAdmin = admindao.selectAdmin(admin);
 	
 	session.setAttribute("id", checkAdmin.getId());
 	session.setAttribute("pw", checkAdmin.getPw());
 	
 	response.sendRedirect("/cashbook/index.jsp");
 	
%>