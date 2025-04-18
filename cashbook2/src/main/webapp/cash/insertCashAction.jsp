<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="model.*" %>
<%@ page import = "java.util.*" %>
<%
   Integer categoryNum = Integer.valueOf(request.getParameter("categoryNo"));
   String cashDate = request.getParameter("cashDate");
   Integer amount = Integer.valueOf(request.getParameter("amount"));
   String memo = request.getParameter("memo");
   String color = request.getParameter("color");
   
   Cash cash = new Cash( );
   cash.setCategoryNum(categoryNum);
   cash.setCashDate(cashDate);
   cash.setAmount(amount);
   cash.setMemo(memo);
   cash.setColor(color);
   
   CashDao cashDao = new CashDao();
   
   cashDao.insertCashOne(cash);
   
   response.sendRedirect("/cashbook/monthList.jsp" );
   
   
%>
 

