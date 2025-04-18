package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Receit;

public class ReceitDao {

	public void insertReceit(Receit receit) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " INSERT INTO receit (filename , cash_no) VALUES (?,? ) " ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1,receit.getFileName());
		stmt.setInt(2,receit.getCashNum());
		
		stmt.executeUpdate();
		conn.close();
	}
	
	public Receit selectReceitOne(int cashNum) throws ClassNotFoundException , SQLException { 
		Receit receit = new Receit();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		ResultSet rs = null;
		String sql = " SELECT r.filename fileName FROM receit r INNER JOIN cash c " 
				      + " ON r.cash_no = c.cash_no WHERE r.cash_no = ? " ; 
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, cashNum);
		
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			receit.setFileName(rs.getString("fileName"));
		}
		
		conn.close();
		return receit;
	
	}
	
	public void deleteReceitOne(int cashNum) throws ClassNotFoundException, SQLException  {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " delete from receit where cash_no = ?  " ;
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNum);
		
		stmt.executeUpdate();
		conn.close();
	}
}
