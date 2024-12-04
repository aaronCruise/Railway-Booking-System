package com.cs336.pkg;

import java.sql.*;

/**
 * A utility class to generate a list of stations. 
 * Used to populate the dropdown menus in WelcomePage.jsp
 */
public class GenerateStations {

	public String generateStations() {
		String list = "";
		Connection conn = null;
		try {
			// Get database connection
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();

			Statement stmt = conn.createStatement();
			String query = "SELECT DISTINCT sid, cityName FROM stations ORDER BY cityName";
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
				String cityName = rs.getString("cityName");
				int sid = rs.getInt("sid");
				list += " <option value=" + sid + ">" + cityName + " </option>";
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
