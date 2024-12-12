<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.io.*" %>
<%
    String originCity = request.getParameter("origin");
    String destCity = request.getParameter("destination");
    String passengerType = request.getParameter("passenger_type");
    String tripType = request.getParameter("trip_type");
    String action = request.getParameter("action");
    String dateStr = request.getParameter("date");
    String inputEmail = request.getParameter("userEmail");

    double fare = 0.0;
    String lineNameFound = "";
    String fname = "";
    String lname = "";
    String emailFromDB = "";
    String passengerName = "";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/transit_system", "root", "mirandagoat");
        
        if ("findTrain".equals(action) && originCity != null && destCity != null){
            String sql = "SELECT t.lineName, t.fare FROM transitlines t JOIN stations s1 ON t.origin = s1.sid JOIN stations s2 ON t.destination = s2.sid WHERE s1.cityName = ? AND s2.cityName = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, originCity);
            stmt.setString(2, destCity);
            rs = stmt.executeQuery();
            if (rs.next()){
                lineNameFound = rs.getString("lineName");
                double baseFare = rs.getDouble("fare");
                fare = baseFare;
                if (passengerType != null) {
                    if (passengerType.equals("child")) fare = baseFare * 0.75;
                    else if (passengerType.equals("senior")) fare = baseFare * 0.65;
                    else if (passengerType.equals("disabled")) fare = baseFare * 0.50;
                    else fare = baseFare;
                }
                if ("round".equals(tripType)) fare *= 2;
                fare = Math.round(fare * 100.0) / 100.0;
            } else {
                lineNameFound = "No route found.";
                fare = 0.0;
            }
            rs.close();
            stmt.close();
        }

        if("makeReservation".equals(action)){
            String sqlUser = "SELECT fname, lname, email FROM customers WHERE email = ?";
            stmt = conn.prepareStatement(sqlUser);
            stmt.setString(1, inputEmail);
            rs = stmt.executeQuery();
            if(rs.next()){
                fname = rs.getString("fname");
                lname = rs.getString("lname");
                emailFromDB = rs.getString("email");
                passengerName = fname + " " + lname;
            }else{
                passengerName = "No name passenger";
                emailFromDB = "noemail@rutgers.edu";
            }
            rs.close();
            stmt.close();

            lineNameFound = request.getParameter("lineName");
            fare = Double.parseDouble(request.getParameter("fare"));

            String insertSql = "INSERT INTO reservationHas (date, totalFare, transitLine, passenger, email) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, dateStr + " 00:00:00");
            stmt.setDouble(2, fare);
            stmt.setString(3, lineNameFound);
            stmt.setString(4, passengerName);
            stmt.setString(5, emailFromDB);
            stmt.executeUpdate();
            stmt.close();

            out.println("<script>alert('Reservation made successfully!');</script>");
        }
    }catch (Exception e){
        e.printStackTrace();
    }finally{
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Make a Reservation</title>
</head>
<body>
    <header>
        <h1>Railway Reservations</h1>
        <form method="post" action="WelcomePage.jsp">
            <input type="submit" value="Go Back"/>
        </form>
    </header>
    <div class="container">
        <h2>Find Your Train</h2>
        <form class="search-form" action="makeReservation.jsp" method="GET">
            <div class="field">
                <label for="userEmail">Your Email</label>
                <input type="email" id="userEmail" name="userEmail" value="<%= inputEmail != null ? inputEmail : "" %>" required />
            </div>
            <div class="field">
                <label for="origin">Origin Station</label>
                <input type="text" id="origin" name="origin" placeholder="e.g. Trenton" value="<%= originCity != null ? originCity : "" %>" required />
            </div>
            <div class="field">
                <label for="destination">Destination Station</label>
                <input type="text" id="destination" name="destination" placeholder="e.g. New York" value="<%= destCity != null ? destCity : "" %>" required />
            </div>
            <div class="field">
                <label for="date">Departure Date</label>
                <input type="date" id="date" name="date" value="<%= dateStr != null ? dateStr : "" %>" required />
            </div>
            <div class="field">
                <label for="passenger_type">Passenger Type</label>
                <select name="passenger_type" id="passenger_type">
                    <option value="adult" <%
					    if("adult".equals(passengerType)){
					        out.print("selected");
					    }
					%>>Adult</option>
					<option value="child" <%
					    if("child".equals(passengerType)){
					        out.print("selected");
					    }
					%>>Child</option>
					<option value="senior" <%
					    if("senior".equals(passengerType)){
					        out.print("selected");
					    }
					%>>Senior</option>
					<option value="disabled" <%
					    if("disabled".equals(passengerType)){
					        out.print("selected");
					    }
					%>>Disabled</option>
                </select>
            </div>
            <div class="field">
                <label for="trip_type">Trip Type</label>
                <select name="trip_type" id="trip_type">
                    <option value="one-way" <%
					    if("one-way".equals(tripType)){
					        out.print("selected");
					    }
					%>>One-Way</option>
					<option value="round" <%
					    if("round".equals(tripType)){
					        out.print("selected");
					    }
					%>>Round</option>
                </select>
            </div>
            <div class="actions">
                <button type="submit" name="action" value="findTrain">Find Train</button>
            </div>
            <div class="field">
                <label for="lineName">Line Name:</label>
                <input type="text" id="lineName" name="lineName" value="<%= lineNameFound %>" readonly />
            </div>
            <div class="field">
                <label for="fare">Fare Price ($)</label>
                <input type="text" id="fare" name="fare" value="<%= fare %>" readonly />
            </div>
            <div class="actions">
                <%
                    if(lineNameFound != null && !lineNameFound.equals("") && !lineNameFound.equals("No route found.")){
                %>
                    <button type="submit" name="action" value="makeReservation">Make Reservation</button>
                <%
                    }
                %>
            </div>
        </form>
     </div>
     
     <form action="reservationDetails.jsp" method="GET">
	    <input type="hidden" name="userEmail" value="<%= inputEmail != null ? inputEmail : "" %>" />
	    <button type="submit">View Reservations</button>
	</form>
</body>
</html>
