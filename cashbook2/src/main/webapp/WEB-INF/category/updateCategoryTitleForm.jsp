<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>

<%
if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
	response.sendRedirect("/cashbook/login/logout.jsp");
	return;
}

int num = Integer.parseInt(request.getParameter("num"));

%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 수정</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #e3f2fd;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .edit-container {
            min-height: 100vh;
        }

        .edit-card {
            max-width: 460px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.05);
            background-color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container d-flex align-items-center justify-content-center edit-container">
        <div class="card edit-card p-4">
            <h3 class="text-center mb-4 fw-bold">카테고리 수정</h3>
            <form action="/cashbook/category/updateCategoryTitleAction.jsp" method="post">
                <!-- category_no는 숨겨진 값으로 전송 -->
                <input type="hidden" name="num" value="<%= num %>">

                <div class="mb-3">
                    <label class="form-label">카테고리 번호</label>
                    <input type="text" class="form-control" value="<%= num %>" disabled>
                </div>

                <div class="mb-3">
                    <label for="category" class="form-label">수입 지출 선택</label>
                    <select class="form-select" id="category" name="category" required>
                        <option value="">조건을 선택하세요</option>
                        <option value="수입">수입</option>
                        <option value="지출">지출</option>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="title" class="form-label">사용 출처</label>
                    <input type="text" class="form-control" id="title" name="title"  required>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">수정 완료</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>