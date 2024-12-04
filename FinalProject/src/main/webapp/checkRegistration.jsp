<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB"%>
<%@ page
	import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<%
	Connection conn = null;

	try {
		ApplicationDB db = new ApplicationDB();
		conn = db.getConnection();
		
		String email = request.getParameter("email");
		String fname = request.getParameter("firstName");
		String lname = request.getParameter("lastName");
		String uname = request.getParameter("username");
		String password = request.getParameter("password");
		
		Statement stmt = conn.createStatement();
		
		String str = "INSERT INTO customers (email, username, fname, lname, pass) values('" + email + "', '" + uname
		+ "', '" + fname + "', '" + lname + "', '" + password + "')";

				
		int row = stmt.executeUpdate(str);
		
		if(row == 1){
			session.setAttribute("username", uname);
			response.sendRedirect("WelcomePage.jsp");
		}
		else{
			response.sendRedirect("InvalidCredsPage.jsp");
		}
		
	}
	catch (Exception e){
		out.print(e);
	} finally{
		if (conn != null){
			conn.close();
		}
	}



%>