<%@ include file="/src/header/module/header.jsp"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>Generated Report</title>
</head>
<body>
	<H1>
		<CENTER>Generated Report</CENTER>
	</H1>
<%
	//Connect to the database
	Connection conn = connect.connect.dbConnect();
	//get the logged in users class
	String className = (String) session.getAttribute("class");
	//check to see if the user can access this page
	if(connect.CheckClass.checkClass("report_generating", className))
	{
	Statement stmt = null;
	ResultSet rset = null;
    
    String selectedDiagnosis = request.getParameter("DIAGNOSIS").trim();
    String selectedStartDate = request.getParameter("STARTDATE").trim();
    String selectedEndDate   = request.getParameter("ENDDATE").trim();
    out.print("<H2> <CENTER>"+selectedDiagnosis+"</CENTER></H2>");
   
    String reportQuery =  "SELECT first_name, last_name, address, phone, prescribing_date " +
                          "FROM  persons p, radiology_record r " +
                          "WHERE r.diagnosis = \'"+selectedDiagnosis+"\' " +
                          "AND r.prescribing_date BETWEEN \'"+selectedStartDate+"\' AND \'"+selectedEndDate+"\' " +
                          "AND p.first_name = r.patient_name";
  
 	 try{
        stmt = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);
        rset = stmt.executeQuery(reportQuery);
    	} 
    	catch (Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
   	 }
    	int NUM_COLS = 5;
    	rset.last();
    	int NUM_ROWS = rset.getRow();
    	rset.beforeFirst();
%>
	<table>
		<tr>
			<td width="150"></td>
			<td width="150"><B>First Name</B></td>
			<td width="150"><B>Last Name</B></td>
			<td width="150"><B>Address</B></td>
			<td width="150"><B>Phone</B></td>
			<td width="150"><B>Prescribing Date</B></td>
		<tr>

<%
	try
	{
	   stmt = conn.createStatement ();
	   rset = stmt.executeQuery (reportQuery);
	} 
	catch (Exception ex)
	{
	   out.println ("<hr>" + ex.getMessage () + "<hr>");
	}
    while (rset.next ())
    {
%>
		<tr>
			<td width="100">Patient</td>
<%
    	for (int j = 1; j < NUM_COLS; j++)
    	{
    	    String value = rset.getString (j);
%>
			<td width="150"><%=value%></td>
<%
    	}
        String formattedDate = connect.connect.getDateStringFromDateString (rset.getString (NUM_COLS));
%>
			<td width="150"><%=formattedDate%></td>
		</tr>
<%
    	}
	}
	else
	{
		out.print ("You are not allowed to view this page. Log in as a user with the appropriate class");
	}
%>
	</table>
</body>
</html>