package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Staff;

public class StaffDAO {

	static private Connection con;
	static private ResultSet rs;
	static private PreparedStatement ps;
	
	public void get_staff(Staff bean, String username) {
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement("select * from staff where username=?");
			ps.setString(1, username);

			rs = ps.executeQuery();

			if (rs.next()) {
				bean.setId(rs.getInt("id"));
				System.out.println(bean.getId());
				bean.setFirstname(rs.getString("firstname"));
				bean.setLastname(rs.getString("lastname"));
				bean.setUsername(rs.getString("username"));
				bean.setEmail(rs.getString("email"));
				bean.setPassword(rs.getString("password"));
				bean.setAddress(rs.getString("address"));
				bean.setCity(rs.getString("city"));
				bean.setPostcode(rs.getInt("postcode"));
				bean.setState(rs.getString("state"));
			} else {
				System.out.println("no row fetched!");
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean usernameExist(String username) {
		boolean is_taken = false;
		final String sql = "select * from staff where username = ?";
		
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();

			if (rs.next()) {
				is_taken = true;
			} else {
				is_taken = false;
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return is_taken;
	}

	public boolean passwordVerify(String username,String password) {

		final String sql = "select * from staff where username=?";

		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql);
			ps.setString(1, username);

			rs = ps.executeQuery();

			if(rs.next()) {
				String actualPass = rs.getString("password");
				if(actualPass.equals(password)) {
					return true;
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

}
