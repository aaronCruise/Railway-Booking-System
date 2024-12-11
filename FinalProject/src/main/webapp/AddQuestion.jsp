<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, java.io.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="java.util.Date" %>


<%
	String question = request.getParameter("question");
	String email = (String)session.getAttribute("email");
	if (email == null){ email = "doe@rutgers.edu";}
	Timestamp postedAt = new Timestamp(new Date().getTime());
	Connection conn = null;
	
	
	
	try{
		ApplicationDB db = new ApplicationDB();
		conn = db.getConnection();
		
		Statement stmt = conn.createStatement();
		
		
		String str = "INSERT INTO posts (question,answer,email,postedAt) values('" + question + "', '"  + "', '" + email
		+ "', '" + postedAt + "')";
		
		
		int row = stmt.executeUpdate(str);
		
		if(row == 1){
			response.sendRedirect("WelcomePage.jsp");
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