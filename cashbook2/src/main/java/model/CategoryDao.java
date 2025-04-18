package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Category;
public class CategoryDao {

	public void  insertCategory(Category c) throws ClassNotFoundException, SQLException{ 
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt1 = null;	
		PreparedStatement stmt2 = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		conn.setAutoCommit(false);
		
		String sql1 = " SELECT COUNT(*) FROM category WHERE kind = ?  AND title = ? " ; 
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1,c.getKind());
		stmt1.setString(2, c.getTitle());
		
		ResultSet rs  = null;
		rs = stmt1.executeQuery();
		
		if(rs.next()) {
			int count = rs.getInt(1);
			if (count >0) {
				System.out.println("중복된 카테고리입니다.");
				conn.rollback();
				return;
			}
		}
		
		
		String sql2 = " INSERT INTO category (kind, title) VALUES( ?, ? )" ;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, c.getKind());
		stmt2.setString(2, c.getTitle());
		
		int row = stmt2.executeUpdate();
		
		

		conn.commit();
		conn.close();
	}
	
	public ArrayList<HashMap<String,Object>> selectCategory(int beginRow , int rowPerPage ) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		ResultSet rs = null; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " SELECT category_no num , kind , title , createdate  FROM category LIMIT ? , ? " ;
		stmt = conn.prepareStatement(sql); 
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		
		rs = stmt.executeQuery();
		ArrayList<HashMap<String, Object>>list = new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<String , Object>();
			map.put("num", rs.getInt("num"));
			map.put("kind", rs.getString("kind"));
			map.put("title", rs.getString("title"));
			map.put("createdate", rs.getString("createdate"));
			
			list.add(map);
		}
	  conn.close();			
	  return list;	
	}
	
	public int  totalCategory( ) throws ClassNotFoundException, SQLException{ 
		int result = 0 ;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		ResultSet rs = null; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " SELECT COUNT(*) totalCount FROM category ";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			result = rs.getInt("totalCount");   // 값을 받아온다
		}
		
		conn.close();
		return result;
		
	}
	
	public void updateOne(Category c) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		conn.setAutoCommit(false);
		String sql = " UPDATE category SET kind = ? , title =  ? WHERE category_no = ? " ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getKind());
		stmt.setString(2, c.getTitle());
		stmt.setInt(3, c.getNum());
		
		stmt.executeUpdate();
		
		String sql2 = " SELECT COUNT(*) FROM category WHERE kind = ?  AND title = ? " ;
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, c.getKind());
		stmt2.setString(2, c.getTitle());
		
		rs = stmt2.executeQuery();
	
		
	
		if (rs.next()) {
			int  row = rs.getInt(1);
		 if (row > 0) {
			conn.rollback();
			return;
		}
	}
		conn.commit();
		conn.close();
	}
	
	public void deleteOne(int num) throws ClassNotFoundException , SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql  = "DELETE FROM category "
					  + "WHERE category_no = ? "
				      + "	AND  NOT EXISTS ("
				      + "    SELECT 1 "
				      + "    FROM cash cs "
				      + "    WHERE  cs.category_no = category.category_no "
				      + " ) " ;  
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, num);
		
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public ArrayList<Category> selectCategoryListByKind(String kind) throws ClassNotFoundException , SQLException{
		ArrayList<Category> list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		ResultSet rs = null; 
		String sql = "select category_no categoryNo, title from category where kind = ? " ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, kind);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setNum(rs.getInt("categoryNo"));
			c.setTitle(rs.getString("title"));
			
			list.add(c);
		}
		return list;  
	}
}
