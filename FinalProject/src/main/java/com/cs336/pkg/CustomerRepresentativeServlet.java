package com.cs336.pkg;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class CustomerRepresentativeServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Transit_System";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "mirandagoat";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("list_schedules".equals(action)) {
            listSchedules(request, response);
        } else if ("find_schedules_by_station".equals(action)) {
            findSchedulesByStation(request, response);
        } else if ("find_reservations_line_date".equals(action)) {
            findReservationsByLineDate(request, response);
        } else {
            response.sendRedirect("WelcomePage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete_schedule".equals(action)) {
            deleteSchedule(request, response);
        } else if ("update_schedule".equals(action)) {
            updateSchedule(request, response);
        } else {
            response.sendRedirect("WelcomePage.jsp");
        }
    }

    private void listSchedules(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String,Object>> schedules = new ArrayList<>();
        String sql = "SELECT sc.scheduleID, sc.lineName, s1.cityName AS startCity, s2.cityName AS endCity, sc.tid, sc.departureTime, sc.arrivalTime, t.fare " +
                     "FROM schedules sc " +
                     "JOIN transitlines t ON sc.lineName = t.lineName " +
                     "JOIN stations s1 ON sc.startStation = s1.sid " +
                     "JOIN stations s2 ON sc.endStation = s2.sid";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while(rs.next()){
                Map<String,Object> map = new HashMap<>();
                map.put("scheduleID", rs.getInt("scheduleID"));
                map.put("lineName", rs.getString("lineName"));
                map.put("startCity", rs.getString("startCity"));
                map.put("endCity", rs.getString("endCity"));
                map.put("tid", rs.getInt("tid"));
                map.put("departureTime", rs.getString("departureTime"));
                map.put("arrivalTime", rs.getString("arrivalTime"));
                map.put("fare", rs.getDouble("fare"));
                schedules.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("schedules", schedules);
        RequestDispatcher rd = request.getRequestDispatcher("EditDeleteSchedules.jsp");
        rd.forward(request, response);
    }

    private void deleteSchedule(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scheduleIDStr = request.getParameter("scheduleID");
        if (scheduleIDStr != null) {
            int scheduleID = Integer.parseInt(scheduleIDStr);
            String sql = "DELETE FROM schedules WHERE scheduleID = ?";
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, scheduleID);
                pstmt.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("CustomerRepresentativeServlet?action=list_schedules");
    }

    private void updateSchedule(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String scheduleIDStr = request.getParameter("scheduleID");
        String lineName = request.getParameter("lineName");
        String fareStr = request.getParameter("fare");
        String departureTime = request.getParameter("departureTime");
        String arrivalTime = request.getParameter("arrivalTime");
        String tidStr = request.getParameter("tid");

        if (scheduleIDStr != null && lineName != null && fareStr != null && departureTime != null && arrivalTime != null && tidStr != null) {
            int scheduleID = Integer.parseInt(scheduleIDStr);
            double fare = Double.parseDouble(fareStr);
            int tid = Integer.parseInt(tidStr);

            Connection conn = null;
            PreparedStatement updateScheduleStmt = null;
            PreparedStatement updateFareStmt = null;

            try {
                conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                conn.setAutoCommit(false);

                // Update schedules table
                String scheduleSQL = "UPDATE schedules SET lineName = ?, tid = ?, departureTime = ?, arrivalTime = ? WHERE scheduleID = ?";
                updateScheduleStmt = conn.prepareStatement(scheduleSQL);
                updateScheduleStmt.setString(1, lineName);
                updateScheduleStmt.setInt(2, tid);
                updateScheduleStmt.setString(3, departureTime);
                updateScheduleStmt.setString(4, arrivalTime);
                updateScheduleStmt.setInt(5, scheduleID);
                updateScheduleStmt.executeUpdate();

                // Update transitlines fare
                String fareSQL = "UPDATE transitlines SET fare = ? WHERE lineName = ?";
                updateFareStmt = conn.prepareStatement(fareSQL);
                updateFareStmt.setDouble(1, fare);
                updateFareStmt.setString(2, lineName);
                updateFareStmt.executeUpdate();

                conn.commit();
            } catch (Exception e) {
                e.printStackTrace();
                if (conn != null) {
                    try { conn.rollback(); } catch (SQLException ignore) {}
                }
            } finally {
                if (updateScheduleStmt != null) try { updateScheduleStmt.close(); } catch (SQLException ignore) {}
                if (updateFareStmt != null) try { updateFareStmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }

        response.sendRedirect("CustomerRepresentativeServlet?action=list_schedules");
    }

    private void findSchedulesByStation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String stationName = request.getParameter("stationName");
        String stationType = request.getParameter("stationType"); // "origin" or "destination"
        List<Map<String,Object>> results = new ArrayList<>();

        if (stationName != null && stationType != null) {
            // If searching by origin, we match stations.origin; if destination, match stations.destination
            String condition = ("origin".equals(stationType)) ? "s1.cityName = ?" : "s2.cityName = ?";

            String sql = "SELECT t.lineName, s1.cityName as originCity, s2.cityName as destinationCity, t.fare " +
                         "FROM transitlines t " +
                         "JOIN stations s1 ON t.origin = s1.sid " +
                         "JOIN stations s2 ON t.destination = s2.sid " +
                         "WHERE " + condition;

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, stationName);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while(rs.next()){
                        Map<String,Object> map = new HashMap<>();
                        map.put("lineName", rs.getString("lineName"));
                        map.put("originCity", rs.getString("originCity"));
                        map.put("destinationCity", rs.getString("destinationCity"));
                        map.put("fare", rs.getDouble("fare"));
                        results.add(map);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("stationSchedules", results);
        RequestDispatcher rd = request.getRequestDispatcher("StationSchedules.jsp");
        rd.forward(request, response);
    }

    private void findReservationsByLineDate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String lineName = request.getParameter("lineName");
        String date = request.getParameter("date");

        List<Map<String,String>> reservations = new ArrayList<>();
        if (lineName != null && date != null) {
            String sql = "SELECT passenger, email, totalFare FROM reservationHas " +
                         "WHERE transitLine = ? AND DATE(date) = ?";
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, lineName);
                pstmt.setString(2, date);
                try (ResultSet rs = pstmt.executeQuery()) {
                    while(rs.next()){
                        Map<String,String> map = new HashMap<>();
                        map.put("passenger", rs.getString("passenger"));
                        map.put("email", rs.getString("email"));
                        map.put("totalFare", rs.getString("totalFare"));
                        reservations.add(map);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("reservations", reservations);
        RequestDispatcher rd = request.getRequestDispatcher("ReservationsByLineDate.jsp");
        rd.forward(request, response);
    }
}
