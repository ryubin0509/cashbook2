<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return;
    }

    int currentPage = 1;
    int rowPerPage = 10;
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }

    CategoryDao categoryDao = new CategoryDao();
    int total = categoryDao.totalCategory();
	
    
    Paging p = new Paging();
    p.setCurrentPage(currentPage);
    p.setRowPerPage(rowPerPage);

    int lastPage = p.getlastPage(total);
    int beginRow = p.getBeginRow();

    System.out.println("total: "+ total);
    System.out.println("lastPage: "+ lastPage);
    
    ArrayList<HashMap<String, Object>> list = categoryDao.selectCategory(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 리스트</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }
        .nav-link {
            font-weight: 500;
        }
        .main-card {
            max-width: 800px;
            margin: 100px auto;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            padding: 2rem;
        }
        .pagination a {
            margin: 0 5px;
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
          <a class="nav-link <%=request.getRequestURI().contains("categoryList") ? "active" : ""%>" href="/cashbook/category/categoryList.jsp">카테고리 목록</a>
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
        <h3 class="text-center fw-bold mb-4 d-flex justify-content-between align-items-center">
    	<span class="ms-2">카테고리 리스트</span>
    	<a href="/cashbook/insertCategoryForm.jsp" class="btn btn-primary btn-sm">+ 카테고리 추가</a>
		</h3>
        <table class="table table-hover text-center align-middle">
            <thead class="table-light">
                <tr>
                    <th>번호</th>
                    <th>수입/지출</th>
                    <th>분류</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody>
                <% for(HashMap<String,Object> map : list) { %>
                    <tr>
                        <td><%= map.get("num") %></td>
                        <td><%= map.get("kind") %></td>
                        <td><%= map.get("title") %></td>
                        <td><a href="/cashbook/category/updateCategoryTitleForm.jsp?num=<%=map.get("num")%>">수정</a></td>
                        <td><a href="/cashbook/category/deleteCategoryAction.jsp?num=<%=map.get("num")%>">삭제</a></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- ✅ 페이징 -->
        <div class="d-flex justify-content-center mt-3">
            <div class="pagination">
                <% if(currentPage > 1) { %>
                    <a href="/cashbook/category/categoryList.jsp?currentPage=<%= currentPage - 1 %>" class="btn btn-outline-secondary btn-sm">이전</a>
                <% } %>

                <span class="mx-2 fw-bold"><%= currentPage %> / <%=lastPage%></span>

                <% if(currentPage < lastPage) { %>
                    <a href="/cashbook/category/categoryList.jsp?currentPage=<%= currentPage + 1 %>" class="btn btn-outline-secondary btn-sm">다음</a>
                <% } %>
            </div>
        </div>
    </div>
</div>

</body>
</html>
