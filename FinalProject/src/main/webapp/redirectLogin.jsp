<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
	
<! DOCTYPE html>
<html>
	<head>
		<title>Redirect Login</title>	

	</head>	
<body>
<%

	String userType =request.getParameter("userType");
	if ("Customer".equals(userType)){
		response.sendRedirect("CustomerLogin.jsp");
	}
	else{
		response.sendRedirect("Employee.jsp");
	}

%>
</body>
</html>
