<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head><title>Reservations by Line and Date</title></head>
<body>
<h1>Find Reservations by Line and Date</h1>
<form method="GET" action="CustomerRepresentativeServlet">
    <input type="hidden" name="action" value="find_reservations_line_date">
    <label>Transit Line Name: <input type="text" name="lineName" required></label><br>
    <label>Date (YYYY-MM-DD): <input type="date" name="date" required></label><br><br>
    <button type="submit">Search</button>
</form>

<%
    List<Map<String,String>> reservations = (List<Map<String,String>>)request.getAttribute("reservations");
    if (reservations != null) {
        if (reservations.isEmpty()) {
            out.println("<p>No reservations found for the given line and date.</p>");
        } else {
%>
<table border="1">
    <tr>
        <th>Passenger Name</th>
        <th>Email</th>
        <th>Total Fare</th>
    </tr>
<%
    for (Map<String,String> res : reservations) {
%>
    <tr>
        <td><%= res.get("passenger") %></td>
        <td><%= res.get("email") %></td>
        <td><%= res.get("totalFare") %></td>
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
