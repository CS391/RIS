<%@ include file="/src/header/module/header.jsp" %>

<html>

<head>
<title>Search</title>
<link rel="stylesheet" type="text/css" href="/RIS/src/CSS/datepicker.css" />
<link rel="stylesheet" type="text/css" href="/RIS/src/CSS/sorttable.css" />
<script type="text/javascript" src="/RIS/src/javascript/datepicker.js"></script>
<script type="text/javascript" src="/RIS/src/javascript/sorttable.js"></script>
</head>

<body>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.Collections, java.util.Date, java.text.SimpleDateFormat" %>
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
		String[] terms = text.split(" ");
		String start = request.getParameter ("start");
		String end = request.getParameter ("end");
		
		out.println ("Search Terms: \"" + text + "\"" + "<br>");
		out.println ("Start Date: \"" + start + "\""  + "<br>");
		out.println ("End Date: \"" + end + "\""  + "<br>");
		
		Connection conn = connect.connect.dbConnect ();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql1 = "select record_id, patient_name, diagnosis, description, test_date,";
		String sql2 = " score(1), score(2), score(3)";
		String sql3 = " from radiology_record";
		String sql4 = " where contains(patient_name, '%" + terms[0] + "%', 1) > 0 or" +
			" contains(diagnosis, '%" + terms[0] + "%', 2) > 0 or" +
			" contains(description, '%" + terms[0] + "%', 3) > 0";
		for (int i = 1; i < terms.length; i++)
		{
			int first = (i * 3) + 1;
			int secon = (i * 3) + 2;
			int third = (i * 3) + 3;
			sql2 += ", score(" + Integer.toString (first) + 
					"), score(" + Integer.toString (secon) + 
					"), score(" + Integer.toString (third) + ")";
			sql4 += " or" +
			" contains(patient_name, '%" + terms[i] + "%', " + Integer.toString (first) + ") > 0 or" +
			" contains(diagnosis, '%" + terms[i] + "%', " + Integer.toString (secon) + ") > 0 or" +
			" contains(description, '%" + terms[i] + "%', " + Integer.toString (third) + ") > 0";
		}
		String sql = sql1 + sql2 + sql3 + sql4;
		if (className.equals ("p"))
			sql += " and patient_name='" + user + "'";
		else if (className.equals ("d"))
			sql += " and doctor_name='" + user + "'";
		else if (className.equals ("r"))
			sql += " and radiologist_name='" + user + "'";

		try
		{
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sql);
		}
		catch (Exception ex)
		{
			out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
		
		ArrayList<connect.counter> rows = new ArrayList<connect.counter>();
		while (rset != null && rset.next ())
		{
			SimpleDateFormat finalFormat = new SimpleDateFormat ("dd-MMM-yy");
			Date after = new Date ();
			if (! start.equals (""))
			{
				try
				{
					after = finalFormat.parse (start);				
				}
				catch (Exception e)
				{
					out.println ("<hr>" + e.getMessage () + "<hr>");
				}
			}
			Date before = new Date ();
			if (! end.equals (""))
			{
				try
				{
					before = finalFormat.parse (end);
				}
				catch (Exception e)
				{
					out.println ("<hr>" + e.getMessage () + "<hr>");
				}
			}
			Date rDate = new Date ();
			try
			{
				rDate = finalFormat.parse (connect.connect.getDateStringFromDateString (rset.getString (5)));				
			}
			catch (Exception e)
			{
				out.println ("<hr>" + e.getMessage () + "<hr>");
			}
			if ((! start.equals ("") && end.equals ("") && rDate.before (before)) || 
				(! end.equals ("") && start.equals ("") && rDate.after (after)) ||
				(! start.equals ("") && ! end.equals ("") && rDate.before (before) && rDate.after (after)) ||
				(start.equals ("") && end.equals ("")))
			{
				int record_id = rset.getInt (1);
				int total = 0;
				int patientTotal = 0;
				int diagnosisTotal = 0;
				int descriptionTotal = 0;
				for (int i = 6; i < (terms.length * 3) + 6; i += 3)
				{
					patientTotal += rset.getInt (i);
					diagnosisTotal += rset.getInt (i + 1);
					descriptionTotal += rset.getInt (i + 2);
				}
				total = 6 * patientTotal + 3 * diagnosisTotal + descriptionTotal;
				connect.counter c = new connect.counter (total, record_id);
				rows.add (c);
			}
		}
		
		out.println ("<br>" + rows.size () + " Results (Click on a table header to sort):<br><br>");
		out.println ("<table class=\"sortable\" border=\"1\">");
			out.println ("<tr>");
				out.println ("<th>Rank</th>");
				out.println ("<th>Patient Name</th>");
				out.println ("<th>Doctor Name</th>");
				out.println ("<th>Radiologist Name</th>");
				out.println ("<th>Test Type</th>");
				out.println ("<th>Precribing Date</th>");
				out.println ("<th>Test Date</th>");
				out.println ("<th>Diagnosis</th>");
				out.println ("<th>Description</th>");
				out.println ("<th>Images</th>");
			out.println ("</tr>");
		
		Collections.sort (rows);
		for (connect.counter c : rows)
		{
			sql = "select * from radiology_record where record_id='" + c.getRecordID () + "'";
			String sql_img = "select * from pacs_images where record_id='" + c.getRecordID () + "'";
			Statement imgstmt = null;
			ResultSet imgrset = null;
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
				imgstmt = conn.createStatement ();
				imgrset = imgstmt.executeQuery (sql_img);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			
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
				
				out.println ("<td>" + c.getTotal () + "</td>");
				out.println ("<td>" + patient + "</td>");
				out.println ("<td>" + doctor + "</td>");
				out.println ("<td>" + radiologist + "</td>");
				out.println ("<td>" + testType + "</td>");
				out.println ("<td>" + connect.connect.getDateStringFromDateString (prescribingDate) + "</td>");
				out.println ("<td>" + connect.connect.getDateStringFromDateString (testDate) + "</td>");
				out.println ("<td>" + diagnosis + "</td>");
				out.println ("<td>" + description + "</td>");
				out.println ("<td>");
				while (imgrset != null && imgrset.next ())
				{
					out.println("<a href=\"/RIS/src/search/module/getOnePic.jsp?big" + imgrset.getString (2) + "\">");
				    out.println("<img src=\"/RIS/src/search/module/getOnePic.jsp?" + imgrset.getString (2) + "\"></a>");
				}
				out.println ("</td>");
				
				out.println ("</tr>");
			}
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