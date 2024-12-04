<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>List of Filtered Revenue</title>
</head>

<%
Connection conn = null;
String filterBy = request.getParameter("filterBy");
String input = request.getParameter("input");

try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	PreparedStatement stmt;
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

	stmt = conn.prepareStatement(query);
	stmt.setString(1, input);
	ResultSet result = stmt.executeQuery();

	//Make an HTML table to show the results in:
	out.print("<table>");

	if (filterBy != null) {
		if (filterBy.equals("line")) {
	out.print("<tr>");
	out.print("<td>Transit Line</td>");

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
			out.print("<tr>");
			out.print("<td>Passenger</td>");
			
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