<%@ include file="/src/header/module/header.jsp" %>
<html>

<head>
<title>User Management</title>
<link rel="stylesheet" type="text/css" href="/391Project/src/CSS/datepicker.css" />
<script type="text/javascript" src="/391Project/src/javascript/datepicker.js"></script>
</head>

<body>
<%@ page import="java.sql.*, java.util.Date, java.text.SimpleDateFormat, java.util.Calendar" %>
<% 
	//get the logged in users class
	String className = (String) session.getAttribute ("class");
	//check to see if the user can access this page
	if (connect.CheckClass.checkClass("user_management", className))
	{
		if (request.getParameter ("Submit") == null &&
			request.getParameter ("Submit Changes") == null &&
			request.getParameter ("SubmitNewUser") == null)
		{
			out.println ("Please select a user to manage: ");
			Connection conn = connect.connect.dbConnect ();
			
			Statement stmt = null;
			ResultSet rset = null;
			String sql = "select user_name from users";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("<FORM NAME=\"Select\" ACTION=\"\" METHOD=\"post\">");
				out.println ("<select name=\"USER\">");
			
			String result = "";
			while(rset != null && rset.next ())
			{
				result = rset.getString (1).trim ();
				out.println ("<option value=\"" + result + "\">" + result + "</option>");
			}
			
				out.println ("</select>");
				out.println ("<INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Select\">");
			out.println ("</FORM>");
			
			try
			{
				conn.close();
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("<br><br>");
			out.println ("<FORM NAME=\"Select\" ACTION=\"\" METHOD=\"post\">");
				out.println ("Create New User:<br><br><table>");
				out.println ("<tr>");
				out.println ("<td>User Name: </td>");
					out.println ("<td><input type=\"text\" name=\"newUser\" value=\"" + "\" /></td>");
				out.println ("</tr><tr>");
				out.println ("<td>Password: </td>");
					out.println ("<td><input type=\"password\" name=\"pass\" value=\"" + "\" /></td>");
				out.println ("</tr><tr>");
				out.println ("<td>Class: </td>");
					out.println ("<td><select name=\"class\">");
						out.println ("<option value=\"a\">a</option>");
						out.println ("<option value=\"p\">p</option>");
						out.println ("<option value=\"d\">d</option>");
						out.println ("<option value=\"r\">r</option>");
					out.println ("</select></td>");
				out.println ("</tr></table>");
				out.println ("<INPUT TYPE=\"submit\" NAME=\"SubmitNewUser\" VALUE=\"Submit\">");
			out.println ("</FORM>");
			
		}
		else if (request.getParameter ("Submit") != null &&
				 request.getParameter ("Submit Changes") == null)
		{
			Connection conn = connect.connect.dbConnect ();
			String userName = request.getParameter ("USER").trim ();
			
			out.println ("Selected User: " + userName + "<br><br><br>");
			
			Statement stmt = null;
			ResultSet rset = null;
			String sql = "select * from users where user_name=\'" + userName + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("<form action=\"\" method=\"POST\" >"); // Start of form
			
		    out.println ("User Information<br><br><table>");
			String user = ""; // INFORMATION FROM USERS TABLE
			String pass = "";
			String uClass = "";
			String dateRegistered = "";
			while (rset != null && rset.next ())
			{
				user = rset.getString (1).trim ();
				pass = rset.getString (2).trim ();
				uClass = rset.getString (3).trim ();
				dateRegistered = rset.getString (4).trim ();
			}
			out.println ("<tr>");
				out.println ("<input type=\"hidden\" name=\"user\" value=\"" + user + "\" />");
		//			out.println ("<td>User: </td>");
		//			out.println ("<td>");
		//				out.println ("<input type=\"text\" name=\"user\" value=\"" + user + "\" />");
		//			out.println ("</td>");
		//		out.println ("</tr><tr>");
				out.println ("<td>Password: </td>");
				out.println ("<td>");
					out.println ("<input type=\"text\" name=\"pass\" value=\"" + pass + "\" />");
				out.println ("</td>");
			out.println ("</tr><tr>");
				out.println ("<td>Class: </td>");
	// 			out.println ("<td>");
	// 				out.println ("<input type=\"text\" name=\"uClass\" value=\"" + uClass + "\" />");
	// 			out.println ("</td>");
				out.println ("<td><select name=\"class\">");
				if (uClass.equals("a"))
					out.println ("<option selected=\"selected\" value=\"a\">a</option>");
				else
					out.println ("<option value=\"a\">a</option>");
				if (uClass.equals("p"))
					out.println ("<option selected=\"selected\" value=\"p\">p</option>");
				else
					out.println ("<option value=\"p\">p</option>");
				if (uClass.equals("d"))
					out.println ("<option selected=\"selected\" value=\"d\">d</option>");
				else
					out.println ("<option value=\"d\">d</option>");
				if (uClass.equals("r"))
					out.println ("<option selected=\"selected\" value=\"r\">r</option>");
				else
					out.println ("<option value=\"r\">r</option>");
				out.println ("</select></td>");
			out.println ("</tr><tr>");
				out.println ("<td>Date Registered: </td>");
	// 			out.println ("<td>");
	// 				out.println ("<input type=\"text\" name=\"dateRegistered\" value=\"" + 
	// 						connect.connect.getDateStringFromDateString (dateRegistered) + "\" />");
	// 			out.println ("</td>");
	// 		out.println ("</tr><tr>");
			out.println ("<form>");
				out.println ("<td><input name=\"YetAnotherDate\" readonly=\"readonly\" onfocus=\"this.blur();\" value=\"" + 
						connect.connect.getDateStringFromDateString (dateRegistered) + "\"></td>"); 
				out.println ("<td><input type=button value=\"select\" onclick=\"displayDatePicker('YetAnotherDate', false, 'dmy', '-');\"></td>");
			out.println ("</form>");
			out.println ("</tr>");
			
			out.println ("</table><br>");
			
			stmt = null;
			rset = null;
			sql = "select * from persons where user_name=\'" + userName + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("<br>Person Information<br><br><table>");
			String pUser = ""; // INFORMATION FROM PERSONS TABLE
			String first = "";
			String last = "";
			String address = "";
			String email = "";
			String phone = "";
			while (rset != null && rset.next ())
			{
				pUser = rset.getString (1).trim ();
				first = rset.getString (2).trim ();
				last = rset.getString (3).trim ();
				address = rset.getString (4).trim ();
				email = rset.getString (5).trim ();
				phone = rset.getString (6).trim ();
			}
			out.println ("<tr>");
	//			out.println ("<td>User: </td>");
	//			out.println ("<td>");
	//				out.println ("<input type=\"text\" name=\"pUser\" value=\"" + pUser + "\" />");
	//			out.println ("</td>");
	//		out.println ("</tr><tr>");
				out.println ("<td>First Name: </td>");
				out.println ("<td>");
					out.println ("<input type=\"text\" name=\"first\" value=\"" + first + "\" />");
				out.println ("</td>");
			out.println ("</tr><tr>");
				out.println ("<td>Last Name: </td>");
				out.println ("<td>");
					out.println ("<input type=\"text\" name=\"last\" value=\"" + last + "\" />");
				out.println ("</td>");
			out.println ("</tr><tr>");
				out.println ("<td>Address: </td>");
				out.println ("<td>");
					out.println ("<input type=\"text\" name=\"address\" value=\"" + address + "\" />");
				out.println ("</td>");
			out.println ("</tr><tr>");
				out.println ("<td>Email: </td>");
				out.println ("<td>");
					out.println ("<input type=\"text\" name=\"email\" value=\"" + email + "\" />");
				out.println ("</td>");
			out.println ("</tr><tr>");
				out.println ("<td>Phone: </td>");
				out.println ("<td>");
				out.println ("<input type=\"text\" name=\"phone\" value=\"" + phone + "\" />");
				out.println ("</td>");
			out.println ("</tr>");
			
			out.println ("</table><br>");
			
			stmt = null;
			rset = null;
			sql = "select * from family_doctor where patient_name=\'" + userName + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("<br>Family Doctor<br><br><table>");
			String doctor = ""; // INFORMATION FROM FAMILY_DOCTOR TABLE
			String patient = "";
			while (rset != null && rset.next ())
			{
				doctor = rset.getString (1).trim ();
				patient = rset.getString (2).trim ();
			}
				out.println ("<tr>");
					out.println ("<td>Doctor Name: </td>");
					out.println ("<td>");
						out.println ("<input type=\"text\" name=\"doctor\" value=\"" + doctor + "\" />");
					out.println ("</td>");
		//		out.println ("</tr><tr>");
		//			out.println ("<td>Patient Name: </td>");
		//			out.println ("<td>");
		//				out.println ("<input type=\"text\" name=\"patient\" value=\"" + patient + "\" />");
		//			out.println ("</td>");
				out.println ("</tr>");
			out.println ("</table>"); // End of form
			
			out.println ("<p>"); 
				out.println ("<input type=\"submit\" name=\"Submit Changes\" value=\"Submit\" />");
				out.println ("<br><br>");
				out.println ("<input type=\"reset\" name=\"Reset\" value=\"Reset Form\" />");
			out.println ("</p>");
			out.println ("</form>");
			
			try
			{
				conn.close();
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
		}
		else if (request.getParameter ("Submit") == null &&
				 request.getParameter ("Submit Changes") != null)
		{
			Connection conn = connect.connect.dbConnect ();
			
			String user = request.getParameter ("user");
			
			String pass = request.getParameter ("pass");
			String uClass = request.getParameter ("class");
			String date = request.getParameter ("YetAnotherDate");
			
			String formattedDate = connect.connect.getDateStringFromDateString (date);
			
			Statement stmt = null;
			ResultSet rset = null;
			String sql = "update users set password=\'" + pass + "\', " +
				"class=\'" + uClass + "\', " +
				"date_registered=\'" + formattedDate + "\' " +
				"where user_name=\'" + user + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			String first = request.getParameter ("first");
			String last = request.getParameter ("last");
			String address = request.getParameter ("address");
			String email = request.getParameter ("email");
			String phone = request.getParameter ("phone");
			
			stmt = null;
			rset = null;
			sql = "update persons set first_name=\'" + first + "\', " +
				"last_name=\'" + last + "\', " +
				"address=\'" + address + "\', " +
				"email=\'" + email + "\', " + 
				"phone=\'" + phone + "\' " +
				"where user_name=\'" + user + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			String doctor = request.getParameter ("doctor");
			
			stmt = null;
			rset = null;
			sql = "update family_doctor set doctor_name=\'" + doctor + "\' " +
				"where patient_name=\'" + user + "\'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("Information submitted!"); // Get parameters and put into db
			
			try
			{
				conn.close();
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
		}
		else if (request.getParameter ("SubmitNewUser") != null)
		{
			String newUser = request.getParameter ("newUser");
			String pass = request.getParameter ("pass");
			String uClass = request.getParameter ("class");
			
			Date now = Calendar.getInstance ().getTime ();
			SimpleDateFormat finalFormat = new SimpleDateFormat ("dd-MMM-yy");
			String date = connect.connect.getDateStringFromDateString (finalFormat.format (now));
			
			Connection conn = connect.connect.dbConnect ();
			Statement stmt = null;
			ResultSet rset = null;
			String sql = "insert into users values ('" + newUser + "', '" + pass + "', '" + uClass + "', '" + date + "')";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			try
			{
				conn.close();
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
			out.println ("User: " + newUser + " created.");
		}
	}
	else
	{
		out.print ("You are not allowed to view this page. Log in as a user with the appropriate class");
	}
%>
</body>

</html>