<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Welcome Page</title>
</head>
<body>

<%
	// User not logged in, go back to Login Page
	if (session.getAttribute("username") == null) {
		%> <jsp:include page="LoginPage.jsp" /> <%
	}
	else {
%>
	<body>
	<h1> Welcome, <%= session.getAttribute("username") %> </h1>
	<h1>Online Railway Booking System </h1>
	<form method="post" action="logout.jsp">
		<input type="submit" value="Log Out" />
	</form>
<% 
	}
%>

</body>
</html>

