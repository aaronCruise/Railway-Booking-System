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
%>
    <jsp:include page="LoginPage.jsp" />
<%
    } else {
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
%>
    <h1>Welcome, <%= username %></h1>
    <h1>Online Railway Booking System</h1>
    <form method="post" action="logout.jsp">
        <input type="submit" value="Log Out" />
    </form>

    <!-- Customer and representative functionalities -->
    <h2>Browse and Search Train Schedules</h2>
    <form method="post" action="ScheduleList.jsp">
        <input type="submit" value="Show Schedules" />

        <h3>Filter by:</h3>
        Origin:
        <select name="originInput">
            <option value="">Select Origin Station</option>
            <%= new GenerateStations().generateStations() %>
        </select><br/>

        Destination:
        <select name="destInput">
            <option value="">Select Destination Station</option>
            <%= new GenerateStations().generateStations() %>
        </select><br/>

        Train Number:
        <select name="trainIDInput">
            <option value="">Select Train Number</option>
            <%= new GenerateTrainIDs().generateTrainIDs() %>
        </select><br/>

        Travel Date:
        <input type="text" name="dateInput" placeholder="YYYY-MM-DD"/><br/>

        <h3>Sort By:</h3>
        <label><input type="radio" name="sortBy" value="line"/> Transit Line Name</label><br/>
        <label><input type="radio" name="sortBy" value="startStationName"/> Start Station</label><br/>
        <label><input type="radio" name="sortBy" value="endStationName"/> End Station</label><br/>
        <label><input type="radio" name="sortBy" value="departureTime"/> Departure Time</label><br/>
        <label><input type="radio" name="sortBy" value="arrivalTime"/> Arrival Time</label><br/>
        <label><input type="radio" name="sortBy" value="fare"/> Fare</label><br/>
    </form>

    <h2>Questions</h2>
    <form method="post" action="QuestionList.jsp">
        <h3>Search Questions</h3>
        <input type="text" name="keywords" placeholder="Search">
        <input type="submit" name="search" value="Search">
        <input type="submit" name="questionDump" value="Browse All Questions">
        <br/>
    </form>
    <form method="post" action="AddQuestion.jsp">
        <h3>Have any questions? Send them our way.</h3>
        <br/>
        <textarea rows="5" cols="100" name="question" placeholder="Enter Question here"></textarea>
        <br/>
        <input type="submit" name="submit" value="Submit">
    </form>

<%
    if ("custRep".equalsIgnoreCase(role)) {
%>
    <h2>Customer Representative Tools</h2>
    <form method="get" action="EditDeleteSchedules.jsp">
        <input type="submit" value="Edit/Delete Train Schedules" />
    </form>

    <form method="get" action="StationSchedules.jsp">
        <input type="submit" value="View Schedules by Station"/>
    </form>

    <form method="get" action="ReservationsByLineDate.jsp">
        <input type="submit" value="View Reservations by Line and Date"/>
    </form>
<%
    }
} 
%>
</body>
</html>
