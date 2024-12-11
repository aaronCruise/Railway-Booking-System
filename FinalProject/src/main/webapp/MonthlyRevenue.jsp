<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page
	import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="javax.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of All Customer Representatives</title>
<style>
	table {
		width: 100%;
	}	
</style>
</head>
<%
Connection conn = null;

try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	Statement stmt = conn.createStatement();

	// Create a select query
	String str = "SELECT DATE_FORMAT(date, '%Y-%m') AS month, "
				+ "SUM(totalFare) AS revenue "
				+ "FROM reservationHas "
				+ "GROUP BY month "
				+ "ORDER BY month ";

	// Run the query against the database
	ResultSet result = stmt.executeQuery(str);

	//Make an HTML table to show the results in:
	out.print("<table border='1'>");

	//make a row
	out.print("<tr>");
	//make a column
	out.print("<td>");
	//print out column header
	out.print("<b> MONTH </b>");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("<b> REVENUE </b>");
	out.print("</td>");

	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("month"));
		out.print("</td>");

		out.print("<td>");
		out.print(result.getString("revenue"));
		out.print("</td>");

		out.print("</tr>");

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