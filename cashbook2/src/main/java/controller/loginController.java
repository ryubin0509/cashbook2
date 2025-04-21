package controller;

import java.io.IOException;
import java.sql.SQLException;

import dto.Admin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AdminDao;


@WebServlet("/loginAction")
public class loginController extends HttpServlet {

       


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();   // 불러온 세션을 초기화 한다.
		session.invalidate(); 					
		request.getRequestDispatcher("/WEB-INF/login/loginForm.jsp").forward(request, response);   // 로그인 홈페이지로 이동 
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Admin admin = new Admin();
		admin.setId(id);
		admin.setPw(pw);
		
		AdminDao admindao = new AdminDao();
		HttpSession session = request.getSession();
		
		
		Admin checkAdmin;
		try {
			
			checkAdmin = admindao.selectAdmin(admin);
			session.setAttribute("id", checkAdmin.getId());
		 	session.setAttribute("pw", checkAdmin.getPw());
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
			System.out.println("오류발생!");
		}
		
		
	 request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
		
		
	}

}
