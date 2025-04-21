package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Paging;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CategoryDao;


@WebServlet("/categoryList")
public class categoryListController extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	HttpSession session = request.getSession(false);
		
		   // 세션이 없거나, 세션에 id가 없으면 로그인 컨트롤러로 이동
     if (session == null || session.getAttribute("id") == null) {
         // GET 방식으로 loginController로 리다이렉트
         response.sendRedirect(request.getContextPath() +"/loginAction");
         return;
     }
     
     int currentPage = 1;
     int rowPerPage = 10;
     if(request.getParameter("currentPage") != null ) {
    	 currentPage = Integer.parseInt(request.getParameter("currentPage"));
     }
     int total = 0;
     
     CategoryDao categoryDao = new CategoryDao();
     try {
		 total = categoryDao.totalCategory();
	} catch (ClassNotFoundException | SQLException e) {
		System.out.println("카운트 갯수 오류발생!");
		e.printStackTrace();
	}
    
     Paging p = new Paging();
     p.setCurrentPage(currentPage);
     p.setRowPerPage(rowPerPage);
     

     int lastPage = p.getlastPage(total);
     int beginRow = p.getBeginRow();
     
     ArrayList<HashMap<String, Object>> list = null;
     
     try {
	
    	 list = categoryDao.selectCategory(beginRow, rowPerPage);
	} catch (ClassNotFoundException | SQLException e) {
		
		System.out.println("오류발생");
		e.printStackTrace();
	}
     
     request.setAttribute("list", list);
     request.setAttribute("Paging", p);
     request.setAttribute("lastPage", lastPage);
     
     request.getRequestDispatcher("/WEB-INF/category/categoryList.jsp").forward(request ,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
