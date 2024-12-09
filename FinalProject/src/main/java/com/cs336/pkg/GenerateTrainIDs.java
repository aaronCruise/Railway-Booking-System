package com.cs336.pkg;

import java.sql.*;

/**
 * A utility class to generate a list of train IDs from schedules table. 
 * Used to populate the dropdown menus in WelcomePage.jsp
 */
public class GenerateTrainIDs {

	public String generateTrainIDs() {
		String list = "";
		Connection conn = null;
		try {
			// Get database connection
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();

			Statement stmt = conn.createStatement();
			String query = "SELECT DISTINCT tid FROM schedules ORDER BY tid";
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				int tid = rs.getInt("tid");
				list += " <option value=" + tid + ">" + tid + " </option>";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
