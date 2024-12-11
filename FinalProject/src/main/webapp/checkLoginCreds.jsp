<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page
	import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
	Connection conn = null;

	String registration = request.getParameter("Register");
	String back = request.getParameter("back");
	
	if("Register".equals(registration)){
		response.sendRedirect("registration.jsp");
	}
	
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
		String str = "SELECT * FROM customers WHERE" + " customers.username = \"" + username + "\""
		+ " AND customers.pass = \"" + password + "\"";

		// Run the query against the database
		ResultSet result = stmt.executeQuery(str);

		// Login successful
		if (result.next()) {
			String email = result.getString("email");
			// Store username in current user session
			session.setAttribute("username", username);
			session.setAttribute("email",email);

			// Redirect to welcome page
			response.sendRedirect("WelcomePage.jsp");
		}
		// Login failure
		else {
			response.sendRedirect("InvalidCredsPage.jsp");
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