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
	
	<form method="post" action="logout.jsp">
		<input type="submit" value="Log Out" />
	</form>

	<h2>Show All Customer Representatives</h2>
	<form method="post" action="EmployeeList.jsp">
		<input type="submit" value="Show Employees" />
	</form>

	<h2>Manage Customer Representatives</h2>
	<table style="width: 50%; text-alight: left">
	<tr>
	<td style="vertical-align: top">
	<!-- Add Employee -->
	<h3> Add an Employee </h3>
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="add" /> 
		<input type="text" id="essn" name="essn" placeholder="Employee SSN" required /> <br /> 
		<input type="text" id="fname" name="fname" placeholder="First Name" required /> <br /> 
		<input type="text" id="lname" name="lname" placeholder="Last Name" required /> <br /> 
		<input type="text" id="username" name="username" placeholder="Username" required /> <br /> 
		<input type="text" id="password" name="password" placeholder="Password" required /> <br /> 
		<input type="submit" value="Add Employee" /> <br />
	</form>
	</td>

	<td style="vertical-align: top">
	<!-- Delete Employee -->
	<h3> Delete an Employee </h3>
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="delete" /> 
		<select id="essn" name="essn" required>
		<option value="" disabled selected> Employee SSN </option>
		<%= new SelectColumnEntries().selectColumnEntries("employees", "essn")%>
		</select>
		<input type="submit" value="Delete Employee" /><br />
	</form>
	<br />
	</td>

	<td style="vertical-align: top">
	<!-- Edit Employee -->
	<h3> Update an Employee's Info </h3>
	<form method="post" action="AdminPage.jsp">
		<input type="hidden" name="action" value="edit" /> 
		<select id="essn" name="essn" required>
		<option value="" disabled selected> Employee SSN </option>
		<%= new SelectColumnEntries().selectColumnEntries("employees", "essn")%>
		</select>
		<input type="text" id="fname" name="fname" placeholder="First Name"  /> <br /> 
		<input type="text" id="lname" name="lname" placeholder="Last Name"  /> <br /> 
		<input type="text" id="username" name="username" placeholder="Username"  /> <br /> 
		<input type="text" id="password" name="password" placeholder="Password"  /> <br />
			<input type="submit" value="Change Employee Info" /> <br />
	</form>
	<br />
	</td>
	</tr>
	</table>

	<!-- Clear All Employees -->
	<h3> Remove All Employees </h3>
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
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	ManageCustomerReps repManager = null;
	
	if (action != null) {
		try {
			repManager = new ManageCustomerReps();
			repManager.handleEmployeeEdit(action, essn, fName, lName, username, password);
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
		</label> 
		<select id="lineInput" name="lineInput" >
		<option value="" disabled selected> Transit Line Name </option>
		<%= new SelectColumnEntries().selectColumnEntries("reservationHas", "transitLine")%>
		</select> <br /> 
		<label> 
		<input type="radio" name="filterBy" value="name" required /> Filter by Customer Name
		</label>
		<select id="custNameInput" name="custNameInput" >
		<option value="" disabled selected> Customer Name </option>
		<%= new SelectColumnEntries().selectColumnEntries("reservationHas", "passenger")%>
		</select> <br /> 
		<input type="submit" value="Show Reservations" />
	</form>

	<h2>Revenue List</h2>
	<form method="post" action="RevenueList.jsp">
		<label> 
		<input type="radio" name="filterBy" value="line" required /> Filter by Transit Line
		</label> 
		<select id="lineInput" name="lineInput" >
		<option value="" disabled selected> Transit Line Name </option>
		<%= new SelectColumnEntries().selectColumnEntries("reservationHas", "transitLine")%>
		</select> <br /> 
		<label> 
		<input type="radio" name="filterBy" value="name" required /> Filter by Customer Name
		</label>
		<select id="custNameInput" name="custNameInput" >
		<option value="" disabled selected> Customer Name </option>
		<%= new SelectColumnEntries().selectColumnEntries("reservationHas", "passenger")%>
		</select> <br /> 
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