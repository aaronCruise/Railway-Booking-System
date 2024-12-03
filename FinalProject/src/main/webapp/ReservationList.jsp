<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page
	import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Filtered Reservations</title>
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
			query = "SELECT * FROM reservationHas WHERE transitLine = ?";
		}
		else if (filterBy.equals("name")) {
			query = "SELECT * FROM reservationHas WHERE passenger = ? ";
		}
	}
	
	stmt = conn.prepareStatement(query);
	stmt.setString(1, input);
	ResultSet result = stmt.executeQuery();
	

	//Make an HTML table to show the results in:
	out.print("<table>");
	
	// Table header
	out.print("<tr>");
	out.print("<td>Reservation Number</td>");
	out.print("<td>Date</td>");
	out.print("<td>Total Fare</td>");
	out.print("<td>Transit Line</td>");
	out.print("<td>Passenger Name</td>");
	out.print("<td>Email</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getInt("rnumber"));
		out.print("</td>");

		 out.print("<td>");
         out.print(result.getTimestamp("date"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getFloat("totalFare"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getString("transitLine"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getString("passenger"));
         out.print("</td>");
         
         out.print("<td>");
         out.print(result.getString("email"));
         out.print("</td>");

	}
	out.print("</table>");

} catch (Exception e) {
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