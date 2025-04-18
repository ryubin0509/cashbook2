<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.util.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%
	if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
	    response.sendRedirect("/cashbook/login/logout.jsp");
	    return; 
	}

	Calendar  c = Calendar.getInstance();
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH);

	if(request.getParameter("year")!=null){
		year = Integer.valueOf(request.getParameter("year"));
	}

	if(request.getParameter("month")!=null){
		month = Integer.valueOf(request.getParameter("month"));
	}

	if (month > 11) {
		month = 0;
		year = year +1;
	}
	if (month < 0) {
		month = 11;
		year = year -1;
	}

	c.set(Calendar.YEAR, year);
	c.set(Calendar.MONTH, month);
	c.set(Calendar.DATE, 1);
	int lastDate = c.getActualMaximum(Calendar.DATE);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);

	int startBlank =  dayOfWeek-1;
	int lastBlank = 0;
	int totalCell = startBlank + lastDate + lastBlank;
	if (totalCell %7 != 0){
		lastBlank = 7- (totalCell%7);
		totalCell = startBlank + lastDate + lastBlank;
	}
	c.set(Calendar.MONTH, month);

	CashDao cashDao = new CashDao();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>달력 출력 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f0f4f8;
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }
        .calendar-table {
            table-layout: fixed;
        }
        .calendar-table td {
            min-height: 100px;
            height: 100px;
            vertical-align: top;
            padding: 5px;
        }
        .calendar-table td span.date {
            font-weight: bold;
            display: block;
            margin-bottom: 4px;
        }
        .calendar-table td.empty {
            background-color: #fafafa;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#">CashBook</a>
    <div class="collapse navbar-collapse justify-content-end">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link active" href="/cashbook/index.jsp">홈</a></li>
          <li class="nav-item"><a class="nav-link" href="/cashbook/statistic/statisticsList.jsp">수입지출 통계자료</a></li>
        <li class="nav-item"><a class="nav-link" href="/cashbook/category/categoryList.jsp">카테고리 목록</a></li>
        <li class="nav-item"><a class="nav-link" href="/cashbook/login/updateAdminPwForm.jsp">비밀번호 수정</a></li>
        <li class="nav-item"><a class="nav-link text-danger" href="/cashbook/login/logout.jsp">로그아웃</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container mt-5">
    <div class="card shadow rounded-4 p-4">
        <h2 class="fw-bold text-center mb-4"><%=year%>년 <%=month+1%>월</h2>
        <table class="table table-bordered calendar-table text-center">
            <thead class="table-light">
                <tr>
                    <th class="text-danger">일</th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                    <th class="text-primary">토</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                <%
                for(int i = 1;  i<= totalCell;  i++ ) {
                    int date = i - startBlank;
                    if( date > 0  && date <= lastDate ){ 
                        String cashDateStr = String.format("%04d-%02d-%02d",  year, month+1, date);
                        ArrayList<HashMap<String,Object>> list  =  cashDao.selectCashList(cashDateStr);
                %>
                    <td>
                    	<a href="/cashbook/dateList.jsp?cashDate=<%=cashDateStr%>">
                        <span class="date"><%=date%></span>
                        
                        <% for(HashMap<String,Object> map: list ){ %>
                            <div style="color: <%=map.get("color") %>"><%=map.get("kind")%> - <%=map.get("title") %> </div>
                        <% } %>
                        </a>
                    </td>
                <% } else { %>
                    <td class="empty">
                        <span class="date">&nbsp;</span>
                    </td>
                <% } %>
                <% if(i % 7 == 0) { %>
                </tr><tr>
                <% } %>
                <% } %>
                </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-between mt-3">
            <a href="/cashbook/monthList.jsp?year=<%=year%>&month=<%=c.get(Calendar.MONTH) -1%>" class="btn btn-outline-primary">이전 달</a>
            <a href="/cashbook/monthList.jsp?year=<%=year%>&month=<%=c.get(Calendar.MONTH)+1%>" class="btn btn-outline-primary">다음 달</a>
        </div>
    </div>
</div>
</body>
</html>
