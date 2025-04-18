package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Statistics;

public class StatisticsDao {

	public ArrayList<Statistics> selectTotal( ) throws ClassNotFoundException, SQLException{
		ArrayList<Statistics> list = new ArrayList<Statistics>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql =  " SELECT kind, COUNT(*) totalCount , SUM(amount) mount  " 
					  + " FROM category ct INNER JOIN cash cs "
				      + " ON ct.category_no = cs.category_no " 
				      + " GROUP BY ct.kind " ;
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		while(rs.next()) {
			Statistics statistics = new Statistics(); 
			statistics.setKind(rs.getString("kind"));
			statistics.setCount(rs.getInt("totalCount"));
			statistics.setAmount(rs.getInt("mount"));
			
			list.add(statistics);
			
		}
		
		conn.close();
		return list ;
	}
	
	public ArrayList<Statistics> selectYearTotal( ) throws ClassNotFoundException, SQLException{
		ArrayList<Statistics> list = new ArrayList<Statistics>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " SELECT year(cash_date) cashDate, kind, COUNT(*) total , SUM(amount) amount " 
					  + " FROM category ct INNER JOIN cash cs "
					  + " ON ct.category_no = cs.category_no " 
					  + " GROUP BY year(cash_date), ct.kind "
					  + " ORDER BY year(cash_date) " ;
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Statistics s = new Statistics(); 
			s.setCashDate(rs.getInt("cashDate"));
			s.setKind(rs.getString("kind"));
			s.setCount(rs.getInt("total"));
			s.setAmount(rs.getInt("amount"));
			
			list.add(s);
		}
		return list;
	}
	
	public int selectMonthTotalList() throws ClassNotFoundException , SQLException {
		int result = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT COUNT(*) AS totalCount "
					  + "FROM ( "
	                  + "   SELECT COUNT(*) "
	                  + "   FROM category ct INNER JOIN cash cs "
	                  + "   ON ct.category_no = cs.category_no "
	                  + "   GROUP BY YEAR(cs.cash_date), MONTH(cs.cash_date), ct.kind "
	                  + ") AS grouped_data";
		stmt = conn.prepareStatement(sql);
		
		rs = stmt.executeQuery();
		if (rs.next()) {
			result = rs.getInt("totalCount");
		}
		return result;
	}
	
	public ArrayList<Statistics> selectMonth( int beginRow , int rowPerPage) throws ClassNotFoundException, SQLException{
		ArrayList<Statistics> list = new ArrayList<Statistics>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " SELECT year(cash_date) year , MONTH(cash_date) month , kind, COUNT(*) total , SUM(amount) amount "
				      + " FROM category ct INNER JOIN cash cs "
				      + " ON ct.category_no = cs.category_no " 
				      + " GROUP BY year(cash_date) , MONTH(cash_date), ct.kind "
				      + " ORDER BY YEAR(cash_date),MONTH(cash_date)	"  
				      + " LIMIT ?, ? " ; 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Statistics s = new Statistics(); 
			s.setCashDate(rs.getInt("year"));
			s.setCashMonth(rs.getInt("month"));
			s.setKind(rs.getString("kind"));
			s.setCount(rs.getInt("total"));
			s.setAmount(rs.getInt("amount"));
			
			list.add(s);
		}
		return list;
	}
}
