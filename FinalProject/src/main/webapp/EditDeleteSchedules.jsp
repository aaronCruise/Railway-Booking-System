<%@ page language="java" import="java.sql.*, java.util.*" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head><title>Edit/Delete Train Schedules</title></head>
<body>
<h1>Edit or Delete Train Schedules</h1>
<form method="GET" action="CustomerRepresentativeServlet">
    <input type="hidden" name="action" value="list_schedules">
    <button type="submit">Load Schedules</button>
</form>

<%
    List<Map<String,Object>> schedules = (List<Map<String,Object>>)request.getAttribute("schedules");
    if (schedules != null && !schedules.isEmpty()) {
%>
<table border="1">
    <tr>
        <th>Schedule ID</th>
        <th>Line Name</th>
        <th>Start Station</th>
        <th>End Station</th>
        <th>Train ID</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Fare</th>
        <th>Actions</th>
    </tr>
<%
    for (Map<String,Object> sch : schedules) {
%>
    <tr>
        <td><%= sch.get("scheduleID") %></td>
        <td><%= sch.get("lineName") %></td>
        <td><%= sch.get("startCity") %></td>
        <td><%= sch.get("endCity") %></td>
        <td><%= sch.get("tid") %></td>
        <td><%= sch.get("departureTime") %></td>
        <td><%= sch.get("arrivalTime") %></td>
        <td><%= sch.get("fare") %></td>
        <td>
            <form style="display:inline;" method="POST" action="CustomerRepresentativeServlet">
                <input type="hidden" name="action" value="delete_schedule">
                <input type="hidden" name="scheduleID" value="<%= sch.get("scheduleID") %>">
                <button type="submit">Delete</button>
            </form>
            <form style="display:inline;" method="GET" action="UpdateSchedule.jsp">
                <input type="hidden" name="scheduleID" value="<%= sch.get("scheduleID") %>">
                <input type="hidden" name="lineName" value="<%= sch.get("lineName") %>">
                <input type="hidden" name="fare" value="<%= sch.get("fare") %>">
                <input type="hidden" name="departureTime" value="<%= sch.get("departureTime") %>">
                <input type="hidden" name="arrivalTime" value="<%= sch.get("arrivalTime") %>">
                <input type="hidden" name="tid" value="<%= sch.get("tid") %>">
                <button type="submit">Edit</button>
            </form>
        </td>
    </tr>
<%
    }
%>
</table>
<%
    }
%>
</body>
</html>
