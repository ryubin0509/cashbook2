<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="model. *" %>
<%@ page import = "dto.*" %>
<% 
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return; 
    }
%>

<%
	 int cashNum = Integer.valueOf(request.getParameter("cashNo"));
	 String cashDate = request.getParameter("cashDate");
	
	 ReceitDao receitdao = new ReceitDao();
	 receitdao.deleteReceitOne(cashNum);
	 
	 response.sendRedirect("/cashbook/dateList.jsp?cashDate=" + cashDate);
%>
