<%@page import="jakarta.security.auth.message.callback.PrivateKeyCallback.IssuerSerialNumRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="dto.*" %>
<%@ page import ="model.*" %>
<%@ page import = "java.util.*" %>
<%
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return; 
    }

    String cashDate = request.getParameter("cashDate");
    CashDao cashDao = new CashDao();
    ArrayList<HashMap<String,Object>> list = cashDao.selectDateList(cashDate);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>지출 상세 페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }
        .main-card {
            max-width: 800px;
            margin: 100px auto;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            padding: 2rem;
        }
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }
        .image-section {
            margin-top: 30px;
            text-align: center;
        }
    </style>
</head>
<body>
<!-- ✅ 공통 네비게이션 -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">CashBook</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link <%=request.getRequestURI().contains("index.jsp") ? "active" : ""%>" href="/cashbook/index.jsp">홈</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%=request.getRequestURI().contains("categoryList") ? "active" : ""%>" href="/cashbook/monthList.jsp">달력 목록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%=request.getRequestURI().contains("updateAdminPwForm") ? "active" : ""%>" href="/cashbook/login/updateAdminPwForm.jsp">비밀번호 수정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-danger" href="/cashbook/login/logout.jsp">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<!-- ✅ 메인 콘텐츠 -->
<div class="container">
    <div class="main-card">
        <div class="action-bar">
            <h3 class="fw-bold mb-0">지출 상세페이지</h3>
            <a href="/cashbook/insertCashForm.jsp?cashDate=<%=cashDate%>" class="btn btn-primary btn-sm">+ 항목 추가</a>
        </div>
        <p class="text-center text-muted mb-4">날짜: <strong><%= cashDate %></strong></p>
        <table class="table table-hover text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>종류</th>
                    <th>제목</th>
                    <th>금액</th>
                    <th>메모</th>
                    <th>수정</th>
                    <th>삭제 </th>
                    <th>상세보기 </th>
                    <th>영수증 등록 여부</th>
                </tr>
            </thead>
            <tbody>
                <% for(HashMap<String,Object> map : list ){ 
                    // cashNo를 각 항목마다 가져오기
                    int cashNum = (int) map.get("cashNo");
                    System.out.println("cashNum: " + cashNum);
                    ReceitDao receitDao = new ReceitDao();
                    Receit receit = receitDao.selectReceitOne(cashNum);
                    String fileName = receit != null ? receit.getFileName() : "";
                %>
                <tr>
                    <td><%=map.get("kind") %></td>
                    <td><%=map.get("title") %></td>
                    <td><%=map.get("amount") %></td>
                    <td><%=map.get("memo") %></td>
                    <td><a href="/cashbook/cash/updateCashForm.jsp?cashNo=<%=map.get("cashNo")%>&cashDate=<%=cashDate%>">수정</a></td>
                    <td><a href="/cashbook/cash/deleteCashAction.jsp?cashNo=<%=map.get("cashNo")%>&cashDate=<%=cashDate%>">삭제</a></td>
                    <td><a href="/cashbook/Receit/insertReceitForm.jsp?cashNo=<%=map.get("cashNo")%>&cashDate=<%=cashDate%>">영수증 등록하기</a></td>
                    <td> <% if(fileName != null) {    %> ✅
                    <% } else { %>
                        ❌
                    <% }  %>
                     			</td>
                </tr>
             
                    <tr> 
                    	<% if(fileName != null ){%>
                        <td colspan="6">
                            <div class="image-section">
                              
                                <img src="/cashbook/upload/<%= fileName %>" class="img-fluid" alt="영수증 이미지">
                             
                                 <td><a href="/cashbook/Receit/deleteReceitAction.jsp?cashNo=<%=map.get("cashNo")%>&cashDate=<%=cashDate%>">영수증 삭제</a></td>
                               
                            </div>
                        </td>
                          <% }  %>
                    </tr>
                <% 
                  
                } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
