<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>
	
<%

	String userType =request.getParameter("userType");
	if ("Customer".equals(userType)){
		response.sendRedirect("CustomerLogin.jsp");
	}
	else{
		response.sendRedirect("EmployeeLogin.jsp");
	}

%>
