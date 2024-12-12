<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head><title>Update Schedule</title></head>
<body>
<h1>Update Schedule</h1>
<%
    String scheduleID = request.getParameter("scheduleID");
    String lineName = request.getParameter("lineName");
    String fare = request.getParameter("fare");
    String departureTime = request.getParameter("departureTime");
    String arrivalTime = request.getParameter("arrivalTime");
    String tid = request.getParameter("tid");
%>
<form method="POST" action="CustomerRepresentativeServlet">
    <input type="hidden" name="action" value="update_schedule">
    <input type="hidden" name="scheduleID" value="<%= scheduleID %>">
    <div>
        <label>Line Name:</label>
        <input type="text" name="lineName" value="<%= lineName %>" required>
    </div>
    <div>
        <label>Fare:</label>
        <input type="text" name="fare" value="<%= fare %>" required>
    </div>
    <div>
        <label>Departure Time (YYYY-MM-DD HH:MM:SS):</label>
        <input type="text" name="departureTime" value="<%= departureTime %>" required>
    </div>
    <div>
        <label>Arrival Time (YYYY-MM-DD HH:MM:SS):</label>
        <input type="text" name="arrivalTime" value="<%= arrivalTime %>" required>
    </div>
    <div>
        <label>Train ID:</label>
        <input type="text" name="tid" value="<%= tid %>" required>
    </div>
    <button type="submit">Update</button>
</form>
</body>
</html>
