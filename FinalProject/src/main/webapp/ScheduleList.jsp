<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Filtered Train Schedules</title>
</head>
<%
Connection conn = null;
String originInput = request.getParameter("originInput");
String destInput = request.getParameter("destInput");
String dateInput = request.getParameter("dateInput");

try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	Statement stmt = conn.createStatement();
	String query = "SELECT s.departureTime, s.arrivalTime, "
					+ "startS.cityName startStationName, endS.cityName endStationName "
					+ "FROM schedules s "
					+ "JOIN stations startS ON s.startStation = startS.sid "
					+ "JOIN stations endS ON s.endStation = endS.sid";
	
	if (originInput != null && !originInput.equals("")) {
		query += " AND startStation = '" + originInput + "'";
	}
	if (destInput != null && !destInput.equals("")) {
		query += " AND endStation = '" + destInput + "'";
	}
	if (dateInput != null && !dateInput.equals("")) {
		query += " AND DATE(departureTime) = '" + dateInput + "'";
	}
	
	ResultSet result = stmt.executeQuery(query);
	

	//Make an HTML table to show the results in:
	out.print("<table>");
	
	// Table header
	out.print("<tr>");
	out.print("<td>Start Station</td>");
	out.print("<td>End Station</td>");
	out.print("<td>Departure Time</td>");
	out.print("<td>Arrival Time</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");

		 out.print("<td>");
         out.print(result.getString("startStationName"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getString("endStationName"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getTimestamp("departureTime"));
         out.print("</td>");

         out.print("<td>");
         out.print(result.getTimestamp("arrivalTime"));
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
	<form method="post" action="WelcomePage.jsp">
		<input type="submit" value="Go Back" />
	</form>
</body>
</html>