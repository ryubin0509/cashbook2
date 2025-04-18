package model;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import dto.Admin;


public class AdminDao {

	public Admin  selectAdmin(Admin admin) throws ClassNotFoundException , SQLException { // 조건에 맞는 id 비밀번호 수집 
			Admin a = new Admin();
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			PreparedStatement stmt = null;	
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
			ResultSet rs = null;
			String sql = " select admin_id id , admin_pw pw from admin where admin_id =  ?  AND  admin_pw = ? " ; 
		
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, admin.getId());
			stmt.setString(2, admin.getPw());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Admin ab= new Admin();
				ab.setId(rs.getString("id"));
				ab.setPw(rs.getString("pw"));
				
				a = ab;
			}
			conn.close();
			return a ;
			
	}
	
	public void  updateAdmin(HashMap<String,String> map)  throws ClassNotFoundException , SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;	
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = " UPDATE admin SET admin_pw  = ? WHERE admin_pw = ? AND admin_id = ? " ;
		stmt = conn.prepareStatement(sql);
		stmt.setString(1 ,map.get("newPw"));
		stmt.setString(2 ,map.get("currentPw"));
		stmt.setString(3 ,map.get("id"));
		
		int row = stmt.executeUpdate();
		if (row == 0) {
		    System.out.println("⚠️ 비밀번호 변경 실패: 현재 비밀번호 불일치 혹은 없는 사용자");
		} else {
		    System.out.println("✅ 비밀번호 변경 성공");
		}
		conn.close();
		
	}
}
