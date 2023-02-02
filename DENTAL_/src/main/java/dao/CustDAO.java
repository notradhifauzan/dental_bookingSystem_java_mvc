package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import model.Customer;

public class CustDAO {
	static private Connection con;
	static private ResultSet rs;
	static private PreparedStatement ps;
	
	public int register(Customer bean) {
		int key = 0;
		String sql = "insert into customer(first_name,last_name,username,phone,email,password)\r\n"
				+ "values(?,?,?,?,?,?)";
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			ps.setString(1, bean.getFirstname());
			ps.setString(2, bean.getLastname());
			ps.setString(3, bean.getUsername());
			ps.setString(4, bean.getPhone());
			ps.setString(5, bean.getEmail());
			ps.setString(6, bean.getPassword());

			int row = ps.executeUpdate();

			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				key = rs.getInt(1);
			}
			
			if (row > 0) {
				System.out.println("user details successfully registered");
				System.out.println();
			} else {
				System.out.println("fail to register user");
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		}
		return key;
	}
	
	public void get_customer(Customer bean, String username) {
		try {
			con = ConnectionManager.getConnection();
			ps = con.prepareStatement("select * from customer where username=?");
			ps.setString(1, username);

			rs = ps.executeQuery();

			if (rs.next()) {
				bean.setId(rs.getInt("id"));
				bean.setFirstname(rs.getString("first_name"));
				bean.setLastname(rs.getString("last_name"));
				bean.setUsername(rs.getString("username"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setPassword(rs.getString("password"));
			} else {
				System.out.println("no row fetched!");
			}

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public boolean passwordVerify(String username,String password) {
		
		final String sql = "select * from customer where username=?";
		
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
	
	public boolean usernameExist(String username) {
		boolean is_taken = false;
		final String sql = "select * from customer where username = ?";
		
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
}
