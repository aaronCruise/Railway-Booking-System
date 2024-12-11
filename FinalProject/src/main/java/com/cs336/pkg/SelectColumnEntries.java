package com.cs336.pkg;

import java.sql.*;

/**
 * A utility class to list an entire column in a table. Used to populate the
 * dropdown menus in AdminPage.
 */
public class SelectColumnEntries {

	/**
	 * Acts like a select SQL query.
	 * 
	 * @param tableName the table to select FROM
	 * @param fieldName the field to select
	 * @return a String of <option> elements for a dropdown menu
	 */
	public String selectColumnEntries(String tableName, String fieldName) {
		String list = "";
		Connection conn = null;
		try {
			// Get database connection
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();

			// Create query
			Statement stmt = conn.createStatement();
			String query = "SELECT DISTINCT " + fieldName
							+ " FROM " + tableName
							+ " ORDER BY " + fieldName;
			
			// Execute and get result
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				String value = rs.getString(fieldName);
				list += " <option value=\"" + value + "\">" + value + " </option>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
