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
<style>
	table {
		width: 100%;
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
			if (lineInput == null || lineInput == "") {
				out.println("<h4> No Transit Line Selected. Showing All Reservations </h4>");
				query = "SELECT * FROM reservationHas";
				stmt = conn.prepareStatement(query);
			}
			else {
				query = "SELECT * FROM reservationHas WHERE transitLine = ?";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, lineInput);
			}
		}
		else if (filterBy.equals("name")) {
			if (custNameInput == null || custNameInput == "") {
				out.println("<h4> No Passenger Selected. Showing All Reservations </h4>");
				query = "SELECT * FROM reservationHas";
				stmt = conn.prepareStatement(query);
			}
			else {
				query = "SELECT * FROM reservationHas WHERE passenger = ? ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, custNameInput);		
			}
		}
			
	}
	ResultSet result = stmt.executeQuery();
	

	//Make an HTML table to show the results in:
	out.print("<table border='1'>");
	
	// Table header
	out.print("<tr>");
	out.print("<td><b> RESERVATION NUMBER </b> </td>");
	out.print("<td><b> DATE </b> </td>");
	out.print("<td><b> TOTAL FARE </b> </td>");
	out.print("<td><b> TRANSIT LINE </b> </td>");
	out.print("<td><b> PASSENGER NAME </b> </td>");
	out.print("<td><b> EMAIL </b> </td>");
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