package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class. Create an object of this class for connecting to a database.
 */
public class ApplicationDB {

	// Change the following to your local DB name, username, and password
	private static final String CONNECTION_URL = "jdbc:mysql://localhost:3306/Transit_System";
	private static final String DB_USERNAME = "root";
	private static final String DB_PASSWORD = "mirandagoat";

	public String getConnectionUrl() {
		return CONNECTION_URL;
	}

	public String getDbUsername() {
		return DB_USERNAME;
	}

	public String getDbPassword() {
		return DB_PASSWORD;
	}

	public Connection getConnection() {
		try {
			// Load JDBC driver - the interface standardizing the connection procedure. Look
			// at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			// Return the connection to your local DB server
			return DriverManager.getConnection(CONNECTION_URL, DB_USERNAME, DB_PASSWORD);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
