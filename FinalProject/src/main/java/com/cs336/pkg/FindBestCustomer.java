package com.cs336.pkg;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 * A helper class to retrieve the customer which generated the most revenue.
 * Used in AdminPage.jsp
 */
public class FindBestCustomer {

	public String getBestCustomer() {
		
		String bestCustomer = "No customer data.";
		Connection conn = null;

		try {
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();

			Statement stmt = conn.createStatement();

			String query = "SELECT passenger, SUM(totalFare) " 
							+ "FROM reservationHas "
							+ "GROUP BY passenger " 
							+ "ORDER BY SUM(totalFare) DESC " 
							+ "LIMIT 1";

			ResultSet rs = stmt.executeQuery(query);
			
			
			if (rs.next()) {
				bestCustomer = rs.getString("passenger");
			}
			
		} 
		catch (Exception e) {
			bestCustomer = "Error: " + e.getMessage();
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
		return bestCustomer;
	}
}
