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

<form method="post" action="QNA.jsp" >
		<h3>Get all Questions</h3>
		<input type="submit" name = "questionDump" value="Browse All Questions">
		<input type="submit" name = "unans" value="See all unanswered">
<br />
</form>

<form method="post" action="QNA.jsp" >
		<h3>Get all Questions</h3>
		<input type="submit" name = "questionDump" value="Browse All Questions">
		<input type="submit" name = "unans" value="See all unanswered">
<br />
</form>
<form method="post" action="submitAnswer.jsp" >
		<h3>Answer Question</h3>
		<input type="text" name = "postID" placeholder="PostID">
		<input type="text" name = "answer" placeholder="Answer">
		<input type="submit" name = "submit" value="Submit">
<br />
</form>







</body>
</html>