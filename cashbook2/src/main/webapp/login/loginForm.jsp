<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>로그인</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #e3f2fd; /* 세련된 연한 블루 */
            font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;
        }

        .login-container {
            min-height: 100vh;
        }

        .login-card {
            max-width: 420px;
            width: 100%;
            border: none;
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        .login-btn {
            background: #1976d2;
            border: none;
            transition: all 0.3s ease;
        }

        .login-btn:hover {
            background: #1565c0;
        }
    </style>
</head>

<body>
    <div class="container d-flex align-items-center justify-content-center login-container">
        <div class="card login-card p-4">
            <h3 class="text-center mb-4 fw-bold">로그인</h3>
            <form action="/cashbook/login/loginAction.jsp" method="post">
                <div class="mb-3">
                    <label for="id" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요">
                </div>
                <div class="mb-4">
                    <label for="pw" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호를 입력하세요">
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn login-btn text-white">로그인하기</button>
                </div>
            </form>
        </div>
    </div>
</body>

</html>
