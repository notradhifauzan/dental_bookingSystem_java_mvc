package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {

	static Connection con;
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost/dental";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "Security@12";

	// the return type of this method is 'Connection'
	// the method have to be static in order for you not instantiating this class
	public static Connection getConnection() {

		try {
			// 1. load the driver
			Class.forName(DB_DRIVER);

			try {
				// 2. create connection
				con = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
				System.out.println("Connected");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return con;

	}
}
