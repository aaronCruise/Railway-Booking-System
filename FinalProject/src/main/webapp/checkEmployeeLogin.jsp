<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page
	import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
	Connection conn = null;

	String back = request.getParameter("back");
	
	if("Go Back".equals(back)){
		response.sendRedirect("LoginPage.jsp");
	}
	

	try {
		// Get database connection
		ApplicationDB db = new ApplicationDB();
		conn = db.getConnection();

		// Get user & pass from LoginPage.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// Create SQL statement
		Statement stmt = conn.createStatement();

		// Create a select query
		String str = "SELECT * FROM employees WHERE" + " employees.username = \"" + username + "\""
		+ " AND employees.pass = \"" + password + "\"";

		// Run the query against the database
		ResultSet result = stmt.executeQuery(str);

		// Login successful
		if (result.next()) {

			// Store username in current user session
			session.setAttribute("username", username);

			// Redirect to correct page
			if (result.getString("role").equals("admin")) {
				response.sendRedirect("AdminPage.jsp");
			}
			else {
				response.sendRedirect("CustRepPage.jsp");
			}
		}
		// Login failure
		else {
			response.sendRedirect("LoginPage.jsp");
		}
	} catch (Exception e) {
		out.print(e);
		
		// Make sure to close connection to DB
	} finally {
		if (conn != null) {
			conn.close();
		}
	}
	%>