<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.ApplicationDB, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin-Level Functions</title>
</head>
<body>

	<h1> Admin-Level Functions</h1>

	<h2>Show All Customer Representatives</h2>
	<form method="post" action="EmployeeList.jsp">
		<input type="submit" value="Show Employees" />
	</form>

	<h2>Manage Customer Representatives</h2>

	<!-- Add Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="add" /> 
		Employee SSN: <input type="text" id="essn" name="essn" required /> <br />
		First Name: <input type="text" id="fname" name="fname" required /> <br />
		Last Name: <input type="text" id="lname" name="lname" required /> <br />
		<input type="submit" value="Add Employee" /> <br />
	</form>
	<br />

	<!-- Delete Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="delete" /> 
		Employee SSN: <input type="text" id="essn" name="essn" required /> <br />
		<input type="submit" value="Delete Employee" /><br />
	</form>
	<br />

	<!-- Edit Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="edit" /> 
		Employee SSN: <input type="text" id="essn" name="essn" required /> <br />
		First Name: <input type="text" id="fname" name="fname" /> <br />
		Last Name: <input type="text" id="lname" name="lname" /> <br />
		<input type="submit" value="Change Employee Info" /> <br />
	</form>
	<br />
	
	<!-- Clear All Employees -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="clear">
		<input type="submit" value="Clear All Employees" /> 
	</form>
	<br />
	<%
	
	String action = request.getParameter("action");
	
	if (action != null) {
		Connection conn = null;
		
		try {
			// Get database connection
			ApplicationDB db = new ApplicationDB();
			conn = db.getConnection();
			Statement stmt = conn.createStatement();

			// Create and execute SQL statement
			String essn = request.getParameter("essn");
			String fName = request.getParameter("fname");
			String lName = request.getParameter("lname");
			PreparedStatement str;
			
			switch (action) {
				case "add":	
					str = conn.prepareStatement(
							"INSERT INTO employees (essn, fname, lname) VALUES (?, ?, ?)");
					str.setString(1, essn);
					str.setString(2, fName);
					str.setString(3, lName);
					str.executeUpdate();
					break;
				case "delete":
					str = conn.prepareStatement("DELETE FROM employees" + 
							" WHERE essn = ?");
					str.setString(1, essn);
					str.executeUpdate();
					break;
				case "edit":
					if (fName != null) {
						str = conn.prepareStatement("UPDATE employees SET " + 
								"fname = ? WHERE essn = " + essn);
						str.setString(1, fName);
						str.executeUpdate();
					}
					if (lName != null) {
						str = conn.prepareStatement("UPDATE employees SET " + 
								"lname = ? WHERE essn = " + essn);
						str.setString(1, lName);
						str.executeUpdate();
					}
					break;
				case "clear":
					stmt.executeUpdate("DELETE FROM employees");
					break;	
			}
			

			// Create a select query
			String all = "SELECT * FROM employees";

			// Run the query against the database
			ResultSet result = stmt.executeQuery(all);

		} catch (SQLIntegrityConstraintViolationException e) {
			out.println("<p style='color: red;'> The ESSN already exists. </p>");
		}
		catch (SQLException e) {
			 out.println("<p style='color: red;'>A database error occurred: " + e.getMessage() + "</p>");
		} finally { // Make sure to close connection to DB
			if (conn != null) {
				conn.close();
			}
		}
		
	}
	
	
	%>

</body>
</html>