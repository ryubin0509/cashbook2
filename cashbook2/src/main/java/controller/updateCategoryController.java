package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/updateCategory")
public class updateCategoryController extends HttpServlet {
	
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			Integer num =  Integer.valueOf(request.getParameter("num"));
			
			request.setAttribute("num", num);
			
			request.getRequestDispatcher("/WEB-INF/category/updateCategoryTitleForm.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
