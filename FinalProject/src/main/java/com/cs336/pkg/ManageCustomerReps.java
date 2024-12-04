package com.cs336.pkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * A helper class to edit customer representative information.
 * Used in AdminPage.jsp
 */
public class ManageCustomerReps {
	
	private Connection conn;
	
	public ManageCustomerReps() {
		this.conn = new ApplicationDB().getConnection();
	}

	public void addEmployee(String essn, String fName, String lName) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement(
				"INSERT INTO employees (essn, fname, lname) VALUES (?, ?, ?)");
		stmt.setString(1, essn);
		stmt.setString(2, fName);
		stmt.setString(3, lName);
		stmt.executeUpdate();
	}
	
	public void deleteEmployee(String essn) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement(
				"DELETE FROM employees WHERE essn = ?");
		stmt.setString(1, essn);
		stmt.executeUpdate();
	}
	
	public void updateEmployee(String essn, String fName, String lName) throws SQLException {
		PreparedStatement stmt;
		if (fName != null) {
			stmt = conn.prepareStatement("UPDATE employees SET " + 
					"fname = ? WHERE essn = " + essn);
			stmt.setString(1, fName);
			stmt.executeUpdate();
		}
		if (lName != null) {
			stmt = conn.prepareStatement("UPDATE employees SET " + 
					"lname = ? WHERE essn = " + essn);
			stmt.setString(1, lName);
			stmt.executeUpdate();
		}
	}

	public void clearEmployees() throws SQLException {
		PreparedStatement stmt = conn.prepareStatement("DELETE FROM employees");
		stmt.executeUpdate();
	}
	
	public void handleEmployeeEdit(String action, String essn, String fName, String lName) 
			throws SQLException {
		switch (action) {
			case "add":	
				addEmployee(essn, fName, lName);
				break;
			case "delete":
				deleteEmployee(essn);
				break;
				
			case "edit":
				updateEmployee(essn, fName, lName);
				break;
			case "clear":
				clearEmployees();
				break;	
		}
		closeConnection();
	}
	
	public void closeConnection() throws SQLException {
		this.conn.close();
	}
}