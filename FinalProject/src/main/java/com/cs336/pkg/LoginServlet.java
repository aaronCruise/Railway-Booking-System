package com.cs336.pkg;
import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Transit_System";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "mirandagoat"; // adjust as needed

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null) {
            response.sendRedirect("LoginPage.jsp?error=Missing credentials");
            return;
        }

        Connection conn = null;
        PreparedStatement empStmt = null, custStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Check if user is an employee
            String empSQL = "SELECT role FROM employees WHERE username = ? AND pass = ?";
            empStmt = conn.prepareStatement(empSQL);
            empStmt.setString(1, username);
            empStmt.setString(2, password);
            rs = empStmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role); // role could be CustRep, admin, etc.
                response.sendRedirect("WelcomePage.jsp");
                return;
            }

            rs.close();
            empStmt.close();

            // If not employee, check if it's a customer
            String custSQL = "SELECT * FROM customers WHERE username = ? AND pass = ?";
            custStmt = conn.prepareStatement(custSQL);
            custStmt.setString(1, username);
            custStmt.setString(2, password);
            rs = custStmt.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", "customer");
                response.sendRedirect("WelcomePage.jsp");
            } else {
                response.sendRedirect("LoginPage.jsp?error=Invalid credentials");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("LoginPage.jsp?error=Internal error");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (empStmt != null) try { empStmt.close(); } catch (SQLException ignore) {}
            if (custStmt != null) try { custStmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
