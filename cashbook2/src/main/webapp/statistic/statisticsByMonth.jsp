<%@ page import="dto.*"%>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return; 
    }

    int currentPage = 1;
	int rowPerPage = 10;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.valueOf(request.getParameter("currentPage"));
	}
	int total = 0;
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);

	StatisticsDao statisticsDao = new StatisticsDao();
	total = statisticsDao.selectMonthTotalList();
	int lastPage = p.getlastPage(total);
	int beginRow =  p.getBeginRow(); 
	 
	ArrayList<Statistics> list = statisticsDao.selectMonth(beginRow, rowPerPage);

    // 수입/지출 월별 금액 집계
    Map<String, Integer> incomeMap = new LinkedHashMap<>();
    Map<String, Integer> expenseMap = new LinkedHashMap<>();

    for(Statistics s : list) {
        String yearMonth = s.getCashDate() + "-" + String.format("%02d", s.getCashMonth());
        if ("수입".equals(s.getKind())) {
            incomeMap.put(yearMonth, incomeMap.getOrDefault(yearMonth, 0) + s.getAmount());
        } else if ("지출".equals(s.getKind())) {
            expenseMap.put(yearMonth, expenseMap.getOrDefault(yearMonth, 0) + s.getAmount());
        }
    }

    // 차트용 문자열 생성
    StringBuilder labels = new StringBuilder();
    StringBuilder incomeData = new StringBuilder();
    StringBuilder expenseData = new StringBuilder();

    Set<String> allKeys = new TreeSet<>();
    allKeys.addAll(incomeMap.keySet());
    allKeys.addAll(expenseMap.keySet());

    for (String key : allKeys) {
        labels.append("'").append(key).append("',");
        incomeData.append(incomeMap.getOrDefault(key, 0)).append(",");
        expenseData.append(expenseMap.getOrDefault(key, 0)).append(",");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>전체 통계자료 리스트</title>
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
        .nav-item.dropdown:hover .dropdown-menu,
        .nav-item.dropdown.show .dropdown-menu {
            display: block;
            margin-top: 0.3rem;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">CashBook</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link" href="/cashbook/index.jsp">홈</a></li>
        <li class="nav-item dropdown" id="dropdownContainer">
          <a class="nav-link dropdown-toggle active" href="#" id="statisticsDropdown" role="button">전체 통계자료</a>
          <ul class="dropdown-menu" aria-labelledby="statisticsDropdown">
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsList.jsp">전체 통계자료</a></li>
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsByYear.jsp">년별 통계</a></li>
            <li><a class="dropdown-item" href="/cashbook/statistic/statisticsByMonth.jsp">월별 통계</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="/cashbook/login/logout.jsp">로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
    <div class="main-card">
        <h3 class="text-center fw-bold mb-4">년 월별 통계리스트</h3>

        <table class="table table-hover text-center">
            <thead class="table-light">
                <tr>
                	<th>년도</th>
                	<th>월</th>
                    <th>수입/지출</th>    
                    <th>총 횟수</th>
                    <th>금액</th>
                </tr>
            </thead>
            <tbody>
                <% for(Statistics s : list) { %>
                    <tr>
                    	<td><%=s.getCashDate() %></td>
                    	<td><%=s.getCashMonth() %></td>
                        <td><%= s.getKind() %></td>
                        <td><%= s.getCount() %></td>
                        <td><%= s.getAmount() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- 차트 추가 -->
        <div class="mt-5">
            <h5 class="text-center fw-bold">년월별 수입/지출 차트</h5>
            <canvas id="monthlyChart" width="600" height="400"></canvas>
        </div>
    </div>
</div>

<div class="d-flex justify-content-center mt-4 gap-3">
    <% if(currentPage > 1){ %> 
        <a class="btn btn-outline-secondary" href="/cashbook/statisticsByMonth.jsp?currentPage=<%=currentPage-1 %>">이전</a>
    <% } %>
    <% if(currentPage < lastPage) {%>
        <a class="btn btn-outline-secondary" href="/cashbook/statisticsByMonth.jsp?currentPage=<%=currentPage+1 %>">다음</a> 
    <% } %>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

<script>
    const ctx = document.getElementById('monthlyChart').getContext('2d');
    const monthlyChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%= labels.toString() %>],
            datasets: [
                {
                    label: '수입',
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    data: [<%= incomeData.toString() %>]
                },
                {
                    label: '지출',
                    backgroundColor: 'rgba(255, 99, 132, 0.7)',
                    data: [<%= expenseData.toString() %>]
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            let value = context.raw;
                            return `${context.dataset.label}: ${value.toLocaleString()}원`;
                        }
                    }
                },
                datalabels: {
                    anchor: 'end',
                    align: 'end',
                    formatter: function(value) {
                        return value.toLocaleString() + '원';
                    },
                    font: {
                        weight: 'bold'
                    },
                    color: '#333'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString() + '원';
                        }
                    }
                }
            }
        },
        plugins: [ChartDataLabels] // ✅ 플러그인 등록
    });

</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const dropdown = document.getElementById("dropdownContainer");
    const toggle = dropdown.querySelector(".dropdown-toggle");
    let clickTimer;

    toggle.addEventListener("click", function (e) {
      e.preventDefault();
      if (dropdown.classList.contains("show")) return;
      dropdown.classList.add("show");
      clearTimeout(clickTimer);
      clickTimer = setTimeout(() => {
        dropdown.classList.remove("show");
      }, 3000);
    });
  });
</script>

</body>
</html>
