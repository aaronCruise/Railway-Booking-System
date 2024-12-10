<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Representative </title>
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
		<h1>Customer Representation Page </h1>
		<form method="post" action="logout.jsp">
			<input type="submit" value="Log Out" />
		</form>
<%
	}
%>

<h2>Edit Information on Train Schedule</h2>





<h2> Questions </h2>

<h3> Unanswered Questions </h3>

<h3> All Questions Questions </h3>
<form method="post" action="QnA.jsp">
	<input type="">

</form>






</body>
</html>