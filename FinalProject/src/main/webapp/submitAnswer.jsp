<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, java.io.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB"%>
<%@ page import="java.sql.Connection, java.sql.Statement, java.sql.ResultSet"%>
<%@ page import="java.util.Date" %>


<%
	String ID = request.getParameter("postID");
	String answer = request.getParameter("answer");
	if (ID == null || answer == null){ response.sendRedirect("CustRepPage.jsp");}
	Timestamp postedAt = new Timestamp(new Date().getTime());
	Connection conn = null;
	
	
	try{
		ApplicationDB db = new ApplicationDB();
		conn = db.getConnection();
		
		Statement stmt = conn.createStatement();
		
		
		String str = "UPDATE posts SET answer = '" + answer + "', answeredAt = '" + postedAt + 
				"' WHERE postID = " + ID;
		
		System.out.print(str);
		
		
		int row = stmt.executeUpdate(str);
		
		if(row == 1){
			response.sendRedirect("CustRepPage.jsp");
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