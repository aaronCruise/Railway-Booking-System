<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin-Level Functions</title>
</head>
<body>

	<h1>Admin-Level Functions</h1>

	<h2>Show All Customer Representatives</h2>
	<form method="post" action="EmployeeList.jsp">
		<input type="submit" value="Show Employees" />
	</form>

	<h2>Manage Customer Representatives</h2>
	<!-- Add Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="add" /> Employee SSN: <input
			type="text" id="essn" name="essn" required /> <br /> First Name: <input
			type="text" id="fname" name="fname" required /> <br /> Last Name: <input
			type="text" id="lname" name="lname" required /> <br /> <input
			type="submit" value="Add Employee" /> <br />
	</form>
	<br />

	<!-- Delete Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="delete" /> Employee SSN: <input
			type="text" id="essn" name="essn" required /> <br /> <input
			type="submit" value="Delete Employee" /><br />
	</form>
	<br />

	<!-- Edit Employee -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="edit" /> Employee SSN: <input
			type="text" id="essn" name="essn" required /> <br /> First Name: <input
			type="text" id="fname" name="fname" /> <br /> Last Name: <input
			type="text" id="lname" name="lname" /> <br /> <input type="submit"
			value="Change Employee Info" /> <br />
	</form>
	<br />

	<!-- Clear All Employees -->
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="clear"> <input
			type="submit" value="Clear All Employees" />
	</form>
	<br />


	<!-- Handle managing customer representatives -->
	<%
	String action = request.getParameter("action");
	String essn = request.getParameter("essn");
	String fName = request.getParameter("fname");
	String lName = request.getParameter("lname");
	ManageCustomerReps repManager = null;
	
	if (action != null) {
		try {
			repManager = new ManageCustomerReps();
			repManager.handleEmployeeEdit(action, essn, fName, lName);
			out.println("<p style='color: green;'>Success!</p>");
		}
		catch (SQLIntegrityConstraintViolationException e) {
			out.println("<p style='color: red;'> The ESSN already exists. </p>");
		}
		catch (SQLException e) {
			 out.println("<p style='color: red;'>A database error occurred: " + e.getMessage() + "</p>");
		}
		catch (Exception e) {
			out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
		}
	}
	%>

	<h2>Monthly Revenue</h2>
	<form method="post" action="MonthlyRevenue.jsp">
		<input type="submit" value="Show Revenue per Month" />
	</form>

	<h2>Reservations List</h2>
	<form method="post" action="ReservationList.jsp">
		<label> 
		<input type="radio" name="filterBy" value="line" required /> Filter by Transit Line
		</label> <br /> 
		<label> 
		<input type="radio" name="filterBy" value="name" required /> Filter by Customer Last Name
		</label> <br /> 
		<label> 
		Input: <input type="text" name="input" required />
		</label> <br /> 
		<input type="submit" value="Show Reservations" />
	</form>

	<h2>Revenue List</h2>
	<form method="post" action="RevenueList.jsp">
		<label> 
		<input type="radio" name="filterBy" value="line" required /> Filter by Transit Line
		</label> <br /> 
		<label> 
		<input type="radio" name="filterBy" value="name" required /> Filter by Customer Last Name
		</label> <br /> 
		<label> 
		Input: <input type="text" name="input" required />
		</label> <br /> 
		<input type="submit" value="Show Revenue" />
	</form>


	<h2>Best Customer</h2>
	<p>
		The customer that generated the most total revenue is: 
		<strong><%= new FindBestCustomer().getBestCustomer()%></strong>
	</p>
	<form method="post" action="AdminPage.jsp">
		<button type="submit">Refresh</button>
	</form>

	<h2>Top 5 Most Active Transit Lines</h2>
	<p>
		The transit lines with the most reservations per month are: 
		<strong><%= new FindTopActiveLines().getTopActiveLines()%></strong>
	</p>
	<form method="post" action="AdminPage.jsp">
		<button type="submit">Refresh</button>
	</form>
</body>
</html>