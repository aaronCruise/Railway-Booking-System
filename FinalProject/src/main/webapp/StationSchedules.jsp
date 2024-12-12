<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Station Schedules</title></head>
<body>
<h1>Find Train Schedules by Station</h1>
<form method="GET" action="CustomerRepresentativeServlet">
    <input type="hidden" name="action" value="find_schedules_by_station">
    <label>Station Name: <input type="text" name="stationName" required></label><br>
    <label>Type:
        <select name="stationType">
            <option value="origin">Origin</option>
            <option value="destination">Destination</option>
        </select>
    </label><br><br>
    <button type="submit">Search</button>
</form>

<%
    List<Map<String,Object>> stationSchedules = (List<Map<String,Object>>)request.getAttribute("stationSchedules");
    if (stationSchedules != null) {
        if (stationSchedules.isEmpty()) {
            out.println("<p>No schedules found for the given station.</p>");
        } else {
%>
<table border="1">
    <tr>
        <th>Line Name</th>
        <th>Origin</th>
        <th>Destination</th>
        <th>Fare</th>
    </tr>
<%
    for (Map<String,Object> sch : stationSchedules) {
%>
    <tr>
        <td><%= sch.get("lineName") %></td>
        <td><%= sch.get("originCity") %></td>
        <td><%= sch.get("destinationCity") %></td>
        <td><%= sch.get("fare") %></td>
    </tr>
<%
    }
%>
</table>
<%
        }
    }
%>
</body>
</html>
