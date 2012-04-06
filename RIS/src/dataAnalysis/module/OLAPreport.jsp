<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<html>

<head>
<title>OLAP Report</title>
</head>

<body>
<H1>
	<CENTER>OLAP Report</CENTER>
</H1>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<% 
	//connect the the database
	Connection conn = connect.connect.dbConnect ();
	//get the logged in users class
	String className = (String) session.getAttribute("class");
	//check to see if the user can access this page
	boolean allowed = connect.CheckClass.checkClass("data_analysis", className);
	if(allowed)
	{
		Statement OLAP = null;
		ResultSet OLAPset = null;
	
		String reportType = (request.getParameter("formselector")).trim();
		out.println(reportType);
		if(reportType.equals("2"))
		{
			String patientName = (request.getParameter("Patient")).trim();
			out.println(patientName);
		}
		String timePeriod = (request.getParameter("Time")).trim();
		out.println(timePeriod);
	
		//OLAP query
		String OLAPquery =	"SELECT PATIENT_NAME, TEST_TYPE, TEST_DATE " + 
							"FROM RADIOLOGY_RECORD " + 
							"GROUP BY ROLLUP (PATIENT_NAME, TEST_TYPE, TEST_DATE) ";
		
		try
		{
		        OLAP = conn.createStatement(
		                ResultSet.TYPE_SCROLL_INSENSITIVE,
		                ResultSet.CONCUR_READ_ONLY);
				OLAPset = OLAP.executeQuery(OLAPquery);
		}
		catch(Exception ex)
		{
				out.println("<hr>Error processing the Analysis Report.<hr>");
		}
	    int NUM_COLS = 3;
	    OLAPset.last();
	    int NUM_ROWS = OLAPset.getRow();
	    OLAPset.beforeFirst();
%>
		<table>
			<tr>
				<td width="200"><B>Patient Name</B></td>
				<td width="200"><B>Test Type</B></td>
				<td width="200"><B>Test Date</B></td>
			<tr>
<%
		try
		{
	        OLAP = conn.createStatement();
			OLAPset = OLAP.executeQuery(OLAPquery);
		}
		catch(Exception ex)
		{
				out.println("<hr>Error processing the Analysis Report.<hr>");
		}
	    while(OLAPset != null && OLAPset.next()) 
	    {
%>
			<tr>
<%
			//print out all the values in the result set
	    	for (int j = 1; j < NUM_COLS; j++)
	    	{
	    	    String value = "";
	    	    if (OLAPset.getString(j) != null)
	    	    	value = OLAPset.getString(j);
%>
				<td width="200"><%=value%></td>
<%
	    	}
			String formattedDate = ""; 
			if (OLAPset.getString(NUM_COLS) != null)
	    		formattedDate = connect.connect.getDateStringFromDateString (OLAPset.getString(NUM_COLS).trim());
// 	    	String formattedDate;
// 	    	if(date == null){
// 	    		formattedDate = "null";
// 	    	}
// 	    	else{
// 	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
// 	        Date convertedDate = dateFormat.parse(date);        
// 	        SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
// 	        formattedDate = finalFormat.format(convertedDate);
// 	    	}
%>
			<td width="200"><%=formattedDate%></td>
			</tr>
<%
	    }
%>
	</table>
<%
		try
		{
			conn.close();
		}
		catch(Exception ex)
		{
			out.println("<hr>Error closing the connection to the database<hr>");
		}
	}
	else
	{
		out.print("You are not allowed to view this page. Log in as a user with the appropriate class");
	}
%>
</body>
</html>