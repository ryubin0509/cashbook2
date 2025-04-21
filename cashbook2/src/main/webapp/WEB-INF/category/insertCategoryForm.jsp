<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>카테고리 검색</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom 스타일 -->
    <style>
        body {
            background-color: #e3f2fd;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .search-container {
            min-height: 100vh;
        }

        .search-card {
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
    <div class="container d-flex align-items-center justify-content-center search-container">
        <div class="card search-card p-4">
            <h3 class="text-center mb-4 fw-bold"> 가계부 카테고리 작성</h3>
            <form action="<%=request.getContextPath() %>/insertCategory" method="post">
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
                    <input type="text" class="form-control" id="title" name="title" placeholder="간략한 내용정리" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">검색</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
