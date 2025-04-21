<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
	    response.sendRedirect(request.getContextPath() +"/loginAction");
	    return; 
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    
    <!-- Bootstrap -->
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
        .welcome-box {
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
            padding: 3rem;
            text-align: center;
            margin-top: 100px;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">CashBook</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" href="#">홈</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath()%>/categoryList">카테고리 목록</a>
        </li>
         <li class="nav-item">
          <a class="nav-link" href="/cashbook/monthList.jsp">달력 목록</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=request.getContextPath()%>/updateAction">비밀번호 수정 </a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-danger" href="<%=request.getContextPath()%>/loginAction">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- Welcome Section -->
<div class="container">
    <div class="welcome-box">
        <h2 class="fw-bold mb-3">안녕하세요, <%=session.getAttribute("id") %>님!</h2>
        <p class="lead">CashBook에 오신 것을 환영합니다 😊</p>
    </div>
</div>

</body>
</html>
