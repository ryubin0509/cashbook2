package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.Cash;

public class CashDao {

	public ArrayList<HashMap<String,Object>> selectCashList(String cashDateStr ) throws ClassNotFoundException, SQLException{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		ResultSet rs = null; 
		String sql = " SELECT ct.kind kind , ct.title title , c.color color FROM cash c INNER JOIN category ct "  
					  + " ON c.category_no = ct.category_no  WHERE cash_date = ? " ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, cashDateStr);
		
		rs = stmt.executeQuery();
		while(rs.next()) { 
			HashMap<String, Object> map = new HashMap <String, Object>();
			map.put("kind", rs.getString("kind"));
			map.put("title", rs.getString("title")); 
			map.put("color",rs.getString("color"));
			
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	public ArrayList<HashMap<String,Object>> selectDateList(String cashDate) throws ClassNotFoundException, SQLException {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		ResultSet rs = null; 
		String sql = " SELECT cs.cash_no cashNo, c.kind kind, c.title title,cs.amount amount, cs.memo memo  FROM category c  INNER JOIN  cash cs " 
					  + " ON c.category_no = cs.category_no WHERE cs.cash_date = ? ";
		stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, cashDate);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> map = new HashMap < >();
			map.put("kind", rs.getString("kind"));
			map.put("amount", rs.getInt("amount"));
			map.put("memo", rs.getString("memo"));
			map.put("title", rs.getString("title"));
			map.put("cashNo", rs.getInt("cashNo"));
			list.add(map);
		}
		
		conn.close();
		return list;
	}
	
	public void insertCashOne(Cash cash) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " INSERT INTO cash (category_no , cash_date, amount, memo , color) VALUES (?,?,?,?,?) " ;
		stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, cash.getCategoryNum());
		stmt.setString(2, cash.getCashDate());
		stmt.setInt(3, cash.getAmount());
		stmt.setString(4, cash.getMemo());
		stmt.setString(5, cash.getColor());

		stmt.executeUpdate(); 
			
		conn.close();
	}
	
	public  ArrayList<HashMap<String,Object>>  selectCashOne(int cashNo) throws ClassNotFoundException, SQLException {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null; 
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql =	 " SELECT c.cash_no cashNo, c.category_no categoryNo , ct.title  title , c.cash_date cashDate, c.amount amount , c.memo memo  , c.color color  FROM cash c "
					  + " INNER JOIN category ct "
					  + " ON c.category_no = ct.category_no " 
					  + " WHERE cash_no = ? " ;
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> map = new 	HashMap<String,Object>( );
		    map.put("cashNo",  rs.getInt("cashNo"));
		    map.put("categoryNo",rs.getInt("categoryNo"));
			map.put("title",rs.getString("title"));
			map.put("cashDate", rs.getString("cashDate"));
			map.put("amount" ,  rs.getInt("amount"));
			map.put("memo", rs.getString("memo"));
			map.put("color", rs.getString("color"));
			
			list.add(map);
		}
		conn.close();
		return list;
	}
	
	public void updateOne(Cash cash)  throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " UPDATE cash SET "
			    	  + " category_no = ?, " 
			    	  + " cash_date = ?, "
			    	  + " amount = ?, "
			          + " memo = ?, "
			          + " color = ? "
			          + " WHERE cash_no = ? " ; 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash.getCategoryNum());
		stmt.setString(2, cash.getCashDate());
		stmt.setInt(3, cash.getAmount());
		stmt.setString(4, cash.getMemo());
		stmt.setString(5, cash.getColor());
		stmt.setInt(6, cash.getCashNum());
		
	   stmt.executeUpdate();
	   conn.close();
	}
	
	public void deleteOne(int cashNum) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "delete from cash where cash_no = ? " ; 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNum);
		
		stmt.executeUpdate();
		
		conn.close();
	}
}