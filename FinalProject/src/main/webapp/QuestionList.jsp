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
String keywords = request.getParameter("keywords");



try {
	// Get database connection
	ApplicationDB db = new ApplicationDB();
	conn = db.getConnection();

	// Create SQL statement
	Statement stmt = conn.createStatement();
	String query = "SELECT posts.question, posts.answer,posts.postedAt  " +
					"FROM posts ";

	if (keywords != null && !keywords.equals("")) {
		query += "WHERE posts.question LIKE '%" + keywords + "%'";
	}
	



	// Execute
	ResultSet result = stmt.executeQuery(query);

	//Make an HTML table to show the results in:
	out.print("<table border='1'>");

	// Table header
	out.print("<tr>");
	out.print("<td>Question</td>");
	out.print("<td>Answer</td>");
	out.print("<td>Posted At</td>");
	out.print("</tr>");

	//parse out the results
	while (result.next()) {
		//make a row
		out.print("<tr>");

		out.print("<td>");
		out.print(result.getString("question"));
		out.print("</td>");

		out.print("<td>");
		out.print(result.getString("answer"));
		out.print("</td>");

		out.print("<td>");
		out.print(result.getTimestamp("postedAt"));
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