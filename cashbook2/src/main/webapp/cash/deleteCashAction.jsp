<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	 int  cashNum = Integer.valueOf(request.getParameter("cashNo"));
	String cashDate = request.getParameter("cashDate");	

	CashDao cashDao = new CashDao();
	cashDao.deleteOne(cashNum);
	
	response.sendRedirect("/cashbook/dateList.jsp?cashDate= " + cashDate);
%>