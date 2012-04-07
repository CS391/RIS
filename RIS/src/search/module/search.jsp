<%@ include file="/src/header/module/header.jsp" %>

<html>

<head>
<title>Search</title>
<link rel="stylesheet" type="text/css" href="/RIS/src/CSS/datepicker.css" />
<script type="text/javascript" src="/RIS/src/javascript/datepicker.js"></script>
</head>

<body>
<%@ page import="java.sql.*" %>
<%
	if (request.getParameter ("SubmitSearch") == null)
	{
		out.println ("Please enter your search terms.");
		
		out.println ("<FORM NAME=\"Select\" ACTION=\"\" METHOD=\"post\">");
			out.println ("<br><br><table><tr>");
				out.println ("<td>Keywords: </td>");
				out.println ("<td><input type=\"text\" name=\"search\" value=\"" + "\" /></td>");
			out.println ("</tr><tr>");
				out.println ("<td>Start: </td>");
					out.println ("<td><input name=\"start\" readonly=\"readonly\" onfocus=\"this.blur();\"></td>"); 
					out.println ("<td><input type=button value=\"select\" onclick=\"displayDatePicker('start', false, 'dmy', '-');\"></td>");
				out.println ("<td>End: </td>");
					out.println ("<td><input name=\"end\" readonly=\"readonly\" onfocus=\"this.blur();\"></td>"); 
					out.println ("<td><input type=button value=\"select\" onclick=\"displayDatePicker('end', false, 'dmy', '-');\"></td>");
			out.println ("</tr><tr>");
				out.println ("<td><INPUT TYPE=\"submit\" NAME=\"SubmitSearch\" VALUE=\"Submit\"></td>");
			out.println ("</tr></table>");
		out.println ("</FORM>");
	}
	else if (request.getParameter ("SubmitSearch") != null)
	{
		String className = (String) session.getAttribute ("class");
		String user = (String) session.getAttribute ("user_name");
		//p own, where patient_name = user
		//d patients, where doctor_name = user
		//r own, where radiologist_name = user
		//a all
		
		String text = request.getParameter ("search");
		String start = request.getParameter ("start");
		String end = request.getParameter ("end");
		
		out.println (text + "<br>");
		out.println (start + "<br>");
		out.println (end + "<br>");
		
		Connection conn = connect.connect.dbConnect ();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "select * from radiology_record";
		if (className.equals ("p"))
			sql += " where patient_name =\"" + user + "\"";
		else if (className.equals ("d"))
			sql += " where doctor_name =\"" + user + "\"";
		else if (className.equals ("r"))
			sql += " where radiologist_name =\"" + user + "\"";
		try
		{
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sql);
		}
		catch (Exception ex)
		{
			out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
		
		// DO STUFF WITH QUERY
		out.println ("<br>Results:<br><br>");
		out.println ("<table border=\"1\">");
			out.println ("<tr>");
				out.println ("<th>Patient Name</th>");
				out.println ("<th>Doctor Name</th>");
				out.println ("<th>Radiologist Name</th>");
				out.println ("<th>Test Type</th>");
				out.println ("<th>Precribing Date</th>");
				out.println ("<th>Test Date</th>");
				out.println ("<th>Diagnosis</th>");
				out.println ("<th>Description</th>");
			out.println ("</tr>");
		String patient = "";
		String doctor = "";
		String radiologist = "";
		String testType = "";
		String prescribingDate = "";
		String testDate = "";
		String diagnosis = "";
		String description = "";
		while (rset != null && rset.next ())
		{
			out.println ("<tr>");
			
			if (rset.getString (2) != null)
				patient = rset.getString (2).trim ();
			if (rset.getString (3) != null)
				doctor = rset.getString (3).trim ();
			if (rset.getString (4) != null)
				radiologist = rset.getString (4).trim ();
			if (rset.getString (5) != null)
				testType = rset.getString (5).trim ();
			if (rset.getString (6) != null)
				prescribingDate = rset.getString (6).trim ();
			if (rset.getString (7) != null)
				testDate = rset.getString (7).trim ();
			if (rset.getString (8) != null)
				diagnosis = rset.getString (8).trim ();
			if (rset.getString (9) != null)
				description = rset.getString (9).trim ();
			
			out.println ("<td>" + patient + "</td>");
			out.println ("<td>" + doctor + "</td>");
			out.println ("<td>" + radiologist + "</td>");
			out.println ("<td>" + testType + "</td>");
			out.println ("<td>" + connect.connect.getDateStringFromDateString (prescribingDate) + "</td>");
			out.println ("<td>" + connect.connect.getDateStringFromDateString (testDate) + "</td>");
			out.println ("<td>" + diagnosis + "</td>");
			out.println ("<td>" + description + "</td>");
			
			out.println ("</tr>");
		}
		out.println ("</table>");
		
		try
		{
			conn.close();
		}
		catch (Exception ex)
		{
			out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
	}
%>
</body>

</html>