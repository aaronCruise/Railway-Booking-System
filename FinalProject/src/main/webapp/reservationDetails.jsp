<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.io.*" %>
<%
    String userEmail = request.getParameter("userEmail");
    String action = request.getParameter("action");
    String cancelRnumberStr = request.getParameter("cancelRnumber");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/transit_system", "root", "mirandagoat");

        // If the user clicked cancel and provided an rnumber
        if ("cancel".equals(action) && cancelRnumberStr != null && !cancelRnumberStr.trim().isEmpty()) {
            int cancelRnumber = Integer.parseInt(cancelRnumberStr);
            String deleteSql = "DELETE FROM reservationHas WHERE rnumber = ? AND email = ?";
            stmt = conn.prepareStatement(deleteSql);
            stmt.setInt(1, cancelRnumber);
            stmt.setString(2, userEmail);
            int rowsDeleted = stmt.executeUpdate();
            stmt.close();
            
            if (rowsDeleted > 0) {
                out.println("<script>alert('Reservation " + cancelRnumber + " canceled successfully!');</script>");
            } else {
                out.println("<script>alert('No reservation found with rnumber " + cancelRnumber + " for this email.');</script>");
            }
        }

        String sql = "SELECT rnumber, date, totalFare, transitLine, passenger FROM reservationHas WHERE email = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, userEmail);
        rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation Details</title>
</head>
<body>
    <h1>Your Reservations</h1>
    <p>Email: <%= (userEmail != null ? userEmail : "Unknown") %></p>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>Reservation Number (rnumber)</th>
            <th>Date</th>
            <th>Total Fare</th>
            <th>Transit Line</th>
            <th>Passenger</th>
        </tr>
        <%
            while (rs.next()) {
                int rnumber = rs.getInt("rnumber");
                Timestamp date = rs.getTimestamp("date");
                double totalFare = rs.getDouble("totalFare");
                String transitLine = rs.getString("transitLine");
                String passenger = rs.getString("passenger");
        %>
        <tr>
            <td><%= rnumber %></td>
            <td><%= date %></td>
            <td><%= totalFare %></td>
            <td><%= transitLine %></td>
            <td><%= passenger %></td>
        </tr>
        <%
            }
        %>
    </table>

    <h2>Cancel a Reservation</h2>
    <form action="reservationDetails.jsp" method="GET">
        <input type="hidden" name="userEmail" value="<%= userEmail %>" />
        <label for="cancelRnumber">Enter Reservation Number to Cancel:</label>
        <input type="text" name="cancelRnumber" id="cancelRnumber" required />
        <button type="submit" name="action" value="cancel">Cancel</button>
    </form>
    
    <form method="post" action="makeReservation.jsp">
        <input type="submit" value="Go Back"/>
    </form>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
