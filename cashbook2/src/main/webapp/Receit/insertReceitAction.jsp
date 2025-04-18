<%@page import="java.nio.file.Files"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.nio.*" %>
<%
	if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
    	response.sendRedirect("/cashbook/login/logout.jsp");
    	return;
}
%> 

<%
int cashNum = Integer.valueOf(request.getParameter("cashNo"));
String cashDate = request.getParameter("cashDate");

Part part = request.getPart("imagefile");

String originalName = part.getSubmittedFileName();
int lastDotPos  = originalName.lastIndexOf(".");
String ext  = originalName.substring(lastDotPos);

UUID uuid = UUID.randomUUID();
String filename = uuid.toString();
filename = filename.replace("-", " "); 

filename = filename + ext;   // 파일 이름 저장 필요! 


String path = request.getServletContext().getRealPath("upload");

File emptyFile = new File(path,filename);

InputStream is = part.getInputStream();

OutputStream os =  Files.newOutputStream(emptyFile.toPath());  

is.transferTo(os);

Receit receit = new Receit();
receit.setCashNum(cashNum);
receit.setFileName(filename); 
ReceitDao receitDao = new ReceitDao(); 
receitDao.insertReceit(receit);

response.sendRedirect("/cashbook/dateList.jsp?cashDate="+cashDate +"&cashNo=" +cashNum);
%>


