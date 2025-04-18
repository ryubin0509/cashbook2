<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>


<%
	if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
    response.sendRedirect("/cashbook/login/logout.jsp");
    return;
}

	String currentPw = request.getParameter("currentPw");
	String newPw = request.getParameter("newPw");
	String confirmPw = request.getParameter("confirmPw");
	
	if(!newPw.equals(confirmPw) ){  // newPw 와 confirmPw 가 다를경우  비밀번호 변경창 이동
		response.sendRedirect("/cashbook/updateAdminPwForm.jsp");
		return;
	}
	
		
	HashMap<String, String>  map = new HashMap<String, String>(); 
	map.put("currentPw", currentPw); // 현재 비번
	map.put("newPw", newPw);  // 새로운 비번
	map.put("id", (String) session.getAttribute("id"));  // id  
	
	AdminDao admindao = new AdminDao();
	admindao.updateAdmin(map); // 비밀번호 변경 
	
	response.sendRedirect("/cashbook/login/loginForm.jsp"); 

	
%>

