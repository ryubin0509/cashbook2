<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>

<% 
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/cash/logout.jsp");
        return; 
    }
%>

<%
	int cashNo = Integer.valueOf(request.getParameter("cashNo")); 
    CashDao cashDao = new CashDao();
    ArrayList<HashMap<String,Object>> list =   cashDao.selectCashOne(cashNo) ; 
    String kind = request.getParameter("kind");
    ArrayList<Category> list2 = new ArrayList<Category>();
	if(kind != null) {
		CategoryDao categoryDao = new CategoryDao();
		 list2 = categoryDao.selectCategoryListByKind(kind);
	}
    
	System.out.println("list2:"+ list2);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>수입/지출 입력</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #e3f2fd;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .form-container {
            min-height: 100vh;
        }
        .form-card {
            max-width: 500px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<%   for ( HashMap<String,Object> map : list ){  %>
<div class="container d-flex align-items-center justify-content-center form-container">
    <div class="card form-card p-4">
        <h3 class="text-center mb-4 fw-bold">수입/지출 수정</h3>

        <!-- 수입/지출 종류 선택 -->
        <form method="post" action="/cashbook/cash/updateCashForm.jsp?cashNo=<%=cashNo%>" class="mb-4">
            <input type="hidden" name="cashDate" value="<%=map.get("cashDate")%>">
            <div class="mb-3">
                <label for="kind" class="form-label">종류 선택</label>
                <select class="form-select" name="kind" id="kind">
                    <option value="">선택</option>
                    <option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
                    <option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
                </select>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-outline-primary">카테고리 불러오기</button>
            </div>
        </form>

        <!-- cash 입력 폼 -->
        <form action="/cashbook/cash/updateCashAction.jsp?cashNo=<%=cashNo%> " method="post" >
            <div class="mb-3">
                <label class="form-label">날짜</label>
                <input type="text" class="form-control" name="cashDate" value="<%=map.get("cashDate")%>" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">카테고리</label>
                <select class="form-select" name="categoryNo" >
                <% 
                		if(list2 !=  null  ){   
                		for(Category c : list2){
                		 	
                %>
                
                	
                     
                	<option value="<%=c.getNum()%>"  selected><%=c.getTitle()%></option>
	<%
                }
            }
             %>
             	<% if(list2== null  ||  list2.isEmpty()){ %>
				<option value="<%=map.get("categoryNo")%>"  selected><%=map.get("title")%></option>
				<% } %>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">금액</label>
                <input type="number" class="form-control" name="amount"  value="<%=map.get("amount")%>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">메모</label>
                <textarea class="form-control" name="memo" rows="3" ><%=map.get("memo")%></textarea>
            </div>
            <div class="mb-4">
                <label class="form-label">색상 선택</label>
                <input type="color" class="form-control form-control-color" name="color" value ="<%=map.get("color")%>">
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">수입/지출 등록</button>
            </div>
          <%
          }
			%>
        </form>
    </div>
</div>
</body>
</html>
