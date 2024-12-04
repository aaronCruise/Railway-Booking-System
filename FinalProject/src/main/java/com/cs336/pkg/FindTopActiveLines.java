package com.cs336.pkg;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 * A helper class to retrieve the top 5 most active transit lines.
 * Used in AdminPage.jsp
 */
public class FindTopActiveLines {
	private static final int NUM_TOP = 5;

	public String getTopActiveLines() {
		
		String topLines = "";
		Connection conn = null;

		try {
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();

			Statement stmt = conn.createStatement();

			String query = "SELECT DISTINCT transitLine, "
							+ "COUNT(*) AS numReservations " 
							+ "FROM reservationHas "
							+ "GROUP BY transitLine "
							+ "ORDER BY numReservations DESC " 
							+ "LIMIT " + NUM_TOP;

			ResultSet rs = stmt.executeQuery(query);
			
			int index = 0;
			while (rs.next() && index < NUM_TOP) {
				topLines += rs.getString("transitLine") + ", ";
				index++;
			}
			
			// Remove the trailing ", "
			if (topLines.length() > 2) {
				topLines = topLines.substring(0, topLines.length() - 2);
			}
			
		} 
		catch (Exception e) {
			topLines = "Error: " + e.getMessage();
		} 
		finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		if (topLines == "") {
			return "No transit line data.";
		}
		return topLines;
	}
}
