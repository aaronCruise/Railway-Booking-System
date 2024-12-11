<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>List of Filtered Revenue</title>
<style>
	table {
		width: 50%;
	}	
</style>
</head>

<%
Connection conn = null;
String filterBy = request.getParameter("filterBy");
String lineInput = request.getParameter("lineInput");
String custNameInput = request.getParameter("custNameInput");

try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	PreparedStatement stmt = null;
	String query = "";

	if (filterBy != null) {
		if (filterBy.equals("line")) {
	query = "SELECT transitLine, SUM(totalFare) as Revenue "
			+ "FROM reservationHas " + "WHERE transitLine = ? "
			+ "GROUP BY transitLine ";
		} else if (filterBy.equals("name")) {
	query = "SELECT passenger, SUM(totalFare) as Revenue "
			+ "FROM reservationHas " + "WHERE passenger = ? "
			+ "GROUP BY passenger ";
		}
	}
	
	if (filterBy != null) {
		if (filterBy.equals("line")) {
			if (lineInput == null || lineInput == "") {
				out.println("<h4> No Transit Line Selected. Showing All Revenue </h4>");
				query = "SELECT transitLine, SUM(totalFare) as Revenue "
						+ "FROM reservationHas "
					 	+ "GROUP BY transitLine ";
				stmt = conn.prepareStatement(query);
			}
			else {
				query = "SELECT transitLine, SUM(totalFare) as Revenue "
						+ "FROM reservationHas " + "WHERE transitLine = ? "
						+ "GROUP BY transitLine ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, lineInput);
			}
		}
		else if (filterBy.equals("name")) {
			if (custNameInput == null || custNameInput == "") {
				out.println("<h4> No Passenger Selected. Showing All Revenue </h4>");
				query = "SELECT passenger, SUM(totalFare) as Revenue "
						+ "FROM reservationHas "
					 	+ "GROUP BY passenger ";
				stmt = conn.prepareStatement(query);
			}
			else {
				query = "SELECT passenger, SUM(totalFare) as Revenue "
						+ "FROM reservationHas " + "WHERE passenger = ? "
						+ "GROUP BY passenger ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, custNameInput);		
			}
		}
			
	}
	ResultSet result = stmt.executeQuery();

	//Make an HTML table to show the results in:
	out.print("<table border='1'>");
	
	// Table Header
	out.print("<tr>");
	if (filterBy != null && filterBy.equals("line")) {
		out.print("<td><b> TRANSIT LINE </b> </td>");
	}
	else {
		out.print("<td><b> PASSENGER </b> </td>");
		
	}
	out.print("<td><b> REVENUE ($) </b> </td>");
	out.print("</tr>");

	if (filterBy != null) {
		if (filterBy.equals("line")) {
		

	while (result.next()) {
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("transitLine"));
		out.print("</td>");

		out.print("<td>");
		out.print(result.getString("Revenue"));
		out.print("</td>");
	}

		} 
		else {
			
			while (result.next()) {
				out.print("<tr>");
		
				out.print("<td>");
				out.print(result.getString("passenger"));
				out.print("</td>");
		
				out.print("<td>");
				out.print(result.getString("Revenue"));
				out.print("</td>");
			}
			
			out.print("</table>");	
		}

	}	
}
	catch (Exception e) {
	out.print(e);

	// Make sure to close connection to DB
} finally {
	if (conn != null) {
		conn.close();
	}
}
%>
<body>
	<form method="post" action="AdminPage.jsp">
		<input type="submit" value="Go Back" />
	</form>

</body>
</html>