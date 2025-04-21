package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.AdminDao;


@WebServlet("/updateAction")
public class updatLoginController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		   // 세션이 없거나, 세션에 id가 없으면 로그인 컨트롤러로 이동
        if (session == null || session.getAttribute("id") == null) {
            // GET 방식으로 loginController로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/loginController");
            return;
        }
        
		String pw = (String) session.getAttribute("pw");
		request.setAttribute("pw", pw);
		
		request.getRequestDispatcher("/WEB-INF/login/updateAdminPwForm.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	HttpSession session = request.getSession(false);
	
	String currentPw = request.getParameter("currentPw");   // 현재 비밀번호
	String newPw = request.getParameter("newPw");
	String confirmPw = request.getParameter("confirmPw");
		
	if(!newPw.equals(confirmPw)) {
		response.sendRedirect(request.getContextPath() + "/updateAction");
		return;
	}
	
	HashMap<String, String>  map = new HashMap<String, String>(); 
	map.put("currentPw", currentPw); // 현재 비번
	map.put("newPw", newPw);  // 새로운 비번
	map.put("id", (String) session.getAttribute("id"));  // id  
	
	AdminDao admindao = new AdminDao();
	try {
		admindao.updateAdmin(map);
		response.sendRedirect(request.getContextPath() +"/loginAction");
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
		System.out.println("비밀번호 변경 오류!");
	} // 비밀번호 변경 
}


}