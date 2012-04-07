<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>OLAP Report</title>
</head>
<body>
<H1>
	<CENTER>OLAP Report</CENTER>
</H1>

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
	
		String OLAPQuery="";
		
		String reportType = (request.getParameter("formselector")).trim();
		String timePeriod = (request.getParameter("Time")).trim();
		
%>
		<table>
			<tr>
				<td width="200"><B>Patient Name</B></td>
				<td width="200"><B>Test Type</B></td>
				<td width="200"><B>Number of Records</B></td>

<%
		if(reportType.equals("1")){
			if(timePeriod.equals("Year")){
				OLAPQuery =	"SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), extract (year from test_date) " +
					"FROM RADIOLOGY_RECORD " +
					"GROUP BY rollup " +
					"(PATIENT_NAME, TEST_TYPE, extract (year from test_date))";
%>
				<td width="200"><B>Year</B></td>
				<tr>
<%
				}
				else if(timePeriod.equals("Month")){
				OLAPQuery = "SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), extract (month from test_date) " +
					"FROM RADIOLOGY_RECORD " +
					"GROUP BY rollup " +
					"(PATIENT_NAME, TEST_TYPE, extract (month from test_date))";
%>
				<td width="200"><B>Number of Month</B></td>
				<tr>
<%
				}
				else if(timePeriod.equals("Week")){
				OLAPQuery = "SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), TO_CHAR((TEST_DATE),'WW') " +
					"FROM RADIOLOGY_RECORD " +
					"GROUP BY rollup " +
        			"(PATIENT_NAME, TEST_TYPE, to_char((TEST_DATE),'WW'))";
%>
				<td width="200"><B>Number of Week</B></td>
				<tr>
<%
				}
		}
		
		if(reportType.equals("2"))
		{
			String patientName = (request.getParameter("Patient")).trim();

			if(timePeriod.equals("Year")){
			OLAPQuery = "SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), extract (YEAR from test_date) " +
			"FROM RADIOLOGY_RECORD " +
			"WHERE patient_name =" + "'" + patientName + "'" +
			" GROUP BY rollup " +
			"(PATIENT_NAME, TEST_TYPE, extract (YEAR from test_date))";
%>
			<td width="200"><B>Year</B></td>
			<tr>
<%
			}
			if(timePeriod.equals("Month")){
				OLAPQuery = "SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), extract (Month from test_date) " +
				"FROM RADIOLOGY_RECORD " +
				"WHERE patient_name =" + "'" + patientName + "'" +
				" GROUP BY rollup " +
				"(PATIENT_NAME, TEST_TYPE, extract (Month from test_date))";
%>
				<td width="200"><B>Number of Month</B></td>
				<tr>
<%
				}
			else if(timePeriod.equals("Week")){
				OLAPQuery = "SELECT PATIENT_NAME, TEST_TYPE, count(TEST_DATE), TO_CHAR((TEST_DATE),'WW') " +
					"FROM RADIOLOGY_RECORD " +
					"WHERE patient_name =" + "'" + patientName + "'" +
					"GROUP BY rollup " +
        			"(PATIENT_NAME, TEST_TYPE, to_char((TEST_DATE),'WW'))";
%>
				<td width="200"><B>Number of Week</B></td>
				<tr>
<%
				}
		}

		try
		{
		        OLAP = conn.createStatement(
		                ResultSet.TYPE_SCROLL_INSENSITIVE,
		                ResultSet.CONCUR_READ_ONLY);
				OLAPset = OLAP.executeQuery(OLAPQuery);
		}
		catch(Exception ex)
		{
				out.println("<hr>Error processing the Analysis Report.<hr>");
		}
	    int NUM_COLS = 4;
	    OLAPset.last();
	    int NUM_ROWS = OLAPset.getRow();
	    OLAPset.beforeFirst();
		try
		{
	        OLAP = conn.createStatement();
			OLAPset = OLAP.executeQuery(OLAPQuery);
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
			if(OLAPset.getInt(NUM_COLS)!=0){
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
			int formattedDate = OLAPset.getInt(NUM_COLS); 
%>
			<td width="200"><%=formattedDate%></td>
			</tr>
<%
			}
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