<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("id") == null && session.getAttribute("pw") == null ) {
        response.sendRedirect("/cashbook/login/logout.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 수정</title>
    
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
            max-width: 420px;
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
            <h3 class="text-center mb-4 fw-bold">비밀번호 수정</h3>
            <form action="/cashbook/login/updateAdminAction.jsp" method="post">
                <div class="mb-3">
                    <label for="currentPw" class="form-label">현재 비밀번호</label>
                    <input type="password" class="form-control" id="currentPw" name="currentPw" placeholder="현재 비밀번호 입력" required>
                </div>
                <div class="mb-3">
                    <label for="newPw" class="form-label">새 비밀번호</label>
                    <input type="password" class="form-control" id="newPw" name="newPw" placeholder="새 비밀번호 입력" required>
                </div>
                <div class="mb-4">
                    <label for="confirmPw" class="form-label">새 비밀번호 확인</label>
                    <input type="password" class="form-control" id="confirmPw" name="confirmPw" placeholder="다시 입력" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
