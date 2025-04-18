<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import = "model.*" %>



<%
	 int cashNum =  Integer.valueOf(request.getParameter("cashNo"));
	 String cashDate = request.getParameter("cashDate");
	 int  categoryNo  = Integer.valueOf(request.getParameter("categoryNo"));
	 int amount = Integer.valueOf(request.getParameter("amount"));
	 String memo = request.getParameter("memo");
	 String color = request.getParameter("color");
	 
	 Cash cash = new Cash(); 
	 cash.setCashDate(cashDate);
	 cash.setCategoryNum(categoryNo);
	 cash.setAmount(amount);
	 cash.setMemo(memo);
	 cash.setColor(color);
	 cash.setCashNum(cashNum);
	 
	 CashDao cashDao = new CashDao();
	 cashDao.updateOne(cash);
	 
	 response.sendRedirect("/cashbook/dateList.jsp?cashDate="+cashDate);
%>
