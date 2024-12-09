<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Welcome Page</title>
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

	<h2> Browse and Search Train Schedules </h2>
	<form method="post" action="ScheduleList.jsp" >
		<input type="submit" value="Show Schedules" />
		
		<h3> Filter by: </h3>
		Origin:
		<select name="originInput"> 
		<option value=""> Select Origin Station </option>
		<%= new GenerateStations().generateStations() %>
		</select> <br /> 
		
		Destination:
		<select name="destInput"> 
		<option value=""> Select Destination Station </option>
		<%= new GenerateStations().generateStations() %>
		</select> <br /> 
		
		Train Number:
		<select name="trainIDInput"> 
		<option value=""> Select Train Number </option>
		<%= new GenerateTrainIDs().generateTrainIDs() %>
		</select> <br />
		
		Travel Date:
		<input type="text" name="dateInput" placeholder="YYYY-MM-DD"/> <br /> 
		
		<h3> Sort By: </h3>
		<label> 
		<input type="radio" name="sortBy" value="line"/> Transit Line Name
		</label> <br /> 
		<label> 
		<input type="radio" name="sortBy" value="startStationName"/> Start Station
		</label> <br /> 
		<label> 
		<input type="radio" name="sortBy" value="endStationName"/> End Station
		</label> <br />
		<label> 
		<input type="radio" name="sortBy" value="departureTime"/> Departure Time
		</label> <br />
		<label> 
		<input type="radio" name="sortBy" value="arrivalTime"/> Arrival Time
		</label> <br />
		<label> 
		<input type="radio" name="sortBy" value="fare"/> Fare
		</label> <br />
	</form>
</body>
</html>

