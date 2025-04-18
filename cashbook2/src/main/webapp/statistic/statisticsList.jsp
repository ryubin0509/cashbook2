<%@ page import="dto.*"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return; 
    }
%>



<%
    ArrayList<Statistics> list = new ArrayList<Statistics>(); 
    StatisticsDao statisticsDao = new StatisticsDao();
    list = statisticsDao.selectTotal();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 통계자료 리스트</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }
        .main-card {
            max-width: 900px;
            margin: 50px auto;
            background-color: white;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        .table th, .table td {
            text-align: center;
        }
        /* ✅ 드롭다운 hover/고정 스타일 */
        .nav-item.dropdown:hover .dropdown-menu,
        .nav-item.dropdown.show .dropdown-menu {
            display: block;
            margin-top: 0.3rem;
        }
    </style>
</head>
<body>

<!-- ✅ 네비게이션 -->
<nav class="navbar navbar-expand-lg bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">CashBook</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/cashbook/index.jsp">홈</a>
        </li>

        <!-- ✅ 드롭다운 메뉴 -->
        <li class="nav-item dropdown" id="dropdownContainer">
          <a class="nav-link dropdown-toggle active" href="#" id="statisticsDropdown" role="button">
            전체 통계자료
          </a>
          <ul class="dropdown-menu" aria-labelledby="statisticsDropdown">
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsList.jsp">전체 통계자료</a></li>
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsByYear.jsp">년별 통계</a></li>
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsByMonth.jsp">월별 통계</a></li>
          </ul>
        </li>

        <li class="nav-item">
          <a class="nav-link" href="/cashbook/login/logout.jsp">로그아웃</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<!-- ✅ 메인 콘텐츠 -->
<div class="container">
    <div class="main-card">
        <h3 class="text-center fw-bold mb-4">전체 통계자료 리스트</h3>

        <table class="table table-hover text-center">
            <thead class="table-light">
                <tr>
                    <th>수입/지출</th>    
                    <th>총 횟수</th>
                    <th>금액</th>
                </tr>
            </thead>
            <tbody>
                <% for(Statistics s : list) { %>
                    <tr>
                        <td><%= s.getKind() %></td>
                        <td><%= s.getCount() %></td>
                        <td><%= s.getAmount() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const dropdown = document.getElementById("dropdownContainer");
    const toggle = dropdown.querySelector(".dropdown-toggle");
    let clickTimer;

    toggle.addEventListener("click", function (e) {
      // 기본 이동 막기 (드롭다운 항목 클릭이 아니라 토글일 때만)
      e.preventDefault();

      // show 상태면 다시 클릭해도 무시
      if (dropdown.classList.contains("show")) return;

      // 드롭다운 열기
      dropdown.classList.add("show");

      // 3초 후 자동 닫기
      clearTimeout(clickTimer);
      clickTimer = setTimeout(() => {
        dropdown.classList.remove("show");
      }, 3000);
    });
  });
</script>

</body>
</html>
