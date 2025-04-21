package controller;

import java.io.IOException;
import java.sql.SQLException;

import dto.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CategoryDao;


@WebServlet("/insertCategory")
public class insertCategoryController extends HttpServlet {

       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		   // 세션이 없거나, 세션에 id가 없으면 로그인 컨트롤러로 이동
		if (session == null || session.getAttribute("id") == null) {
			// GET 방식으로 loginController로 리다이렉트
		response.sendRedirect(request.getContextPath() +"/loginAction");
		return;
	   }
		
	  request.getRequestDispatcher("/WEB-INF/category/insertCategoryForm.jsp").forward(request, response);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		   // 세션이 없거나, 세션에 id가 없으면 로그인 컨트롤러로 이동
		if (session == null || session.getAttribute("id") == null) {
			// GET 방식으로 loginController로 리다이렉트
		response.sendRedirect(request.getContextPath() +"/loginAction");
		return;
	   }
		
		String kind = request.getParameter("category");
		String title = request.getParameter("title");
		
		Category c = new Category();
		c.setKind(kind);
		c.setTitle(title);
		
		CategoryDao categoryDao = new CategoryDao();
		
		
		try {
			categoryDao.insertCategory(c);
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println("카테고리 추가 오류 발생");
			e.printStackTrace();
		}  //  카테고리 추가완료
		
		response.sendRedirect(request.getContextPath()+"/categoryList");
	}

}
