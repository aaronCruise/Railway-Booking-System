<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedules</title>
<style>
	table {
		width: 100%;
	}
</style>
</head>
<%
Connection conn = null;
String originInput = request.getParameter("originInput");
String destInput = request.getParameter("destInput");
String dateInput = request.getParameter("dateInput");
String trainIDInput = request.getParameter("trainIDInput");
String sortBy = request.getParameter("sortBy");

try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	Statement stmt = conn.createStatement();
	String query = "SELECT s.lineName line, " 
					+ "s.tid tid, "
					+ "s.departureTime, departureTime, " 
					+ "s.arrivalTime, arrivalTime, "
					+ "startS.cityName startStationName, " 
					+ "endS.cityName endStationName, "
					+ "t.fare / NULLIF(t.numStops, 0) fare "
					+ "FROM schedules s " 
					+ "JOIN stations startS ON s.startStation = startS.sid "
					+ "JOIN stations endS ON s.endStation = endS.sid "
					+ "JOIN transitlines t ON s.lineName = t.lineName ";

	if (originInput != null && !originInput.equals("")) {
		query += " AND startStation = '" + originInput + "'";
	}
	if (destInput != null && !destInput.equals("")) {
		query += " AND endStation = '" + destInput + "'";
	}
	if (dateInput != null && !dateInput.equals("")) {
		query += " AND DATE(departureTime) = '" + dateInput + "'";
	}
	if (trainIDInput != null && !trainIDInput.equals("")) {
		query += " AND tid = '" + trainIDInput + "'";
	}

	// Append SORTBY clause
	if (sortBy == null) {
		sortBy = "departureTime"; // default
	}
	query += "ORDER BY " + sortBy;

	// Execute
	ResultSet result = stmt.executeQuery(query);

	//Make an HTML table to show the results in:
	out.print("<table border='1'>");

	// Table header
	out.print("<tr>");
	out.print("<td>Transit Line</td>");
	out.print("<td>Train #</td>");
	out.print("<td>Start Station</td>");
	out.print("<td>End Station</td>");
	out.print("<td>Departure Time</td>");
	out.print("<td>Arrival Time</td>");
	out.print("<td>Fare Per Stop</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("line"));
		out.print("</td>");

		out.print("<td>");
		out.print(result.getString("tid"));
		out.print("</td>");

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

		out.print("<td>");
		out.print(String.format("%.2f", result.getDouble("fare")));
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