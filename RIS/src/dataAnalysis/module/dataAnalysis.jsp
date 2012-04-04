<%@ include file="/src/header/module/header.jsp"%>

<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>

<HTML>
<HEAD>
<TITLE>Data Analysis</TITLE>
</HEAD>
<BODY>
	<%@ page import="java.sql.*"%>

	<H1>
		<CENTER>Data Analysis</CENTER>
	</H1>

	<% 
Connection conn = connect.connect.dbConnect ();
String className = (String) session.getAttribute("class");
boolean allowed = connect.CheckClass.checkClass("data_analysis", className);
if(allowed){
Statement OLAP = null;
ResultSet OLAPset = null;

	String OLAPquery =	"SELECT PATIENT_NAME, TEST_TYPE, TEST_DATE " + 
						"FROM RADIOLOGY_RECORD " + 
						"GROUP BY CUBE (PATIENT_NAME, TEST_TYPE, TEST_DATE) ";
	
	try{
	        OLAP = conn.createStatement(
	                ResultSet.TYPE_SCROLL_INSENSITIVE,
	                ResultSet.CONCUR_READ_ONLY);
			OLAPset = OLAP.executeQuery(OLAPquery);
		}
	catch(Exception ex){
			out.println("<hr>Error processing the Analysis Report.<hr>");
		}
	    int NUM_COLS = 3;
	    OLAPset.last();
	    int NUM_ROWS = OLAPset.getRow();
	    OLAPset.beforeFirst();
	    %>
	<table>
		<tr>
			<td width="200"><B>Patient Name</B>
			</td>
			<td width="200"><B>Test Type</B>
			</td>
			<td width="200"><B>Test Date</B>
			</td>
		<tr>

			<%
	    while(OLAPset.next()){
	    	%>
		
		<tr>
			<%
	    	for(int j=1;j<=NUM_COLS-1;j++){
	    	    String value = OLAPset.getString(j);
				%>
			<td width="200"><%=value%></td>
			<%

	    	}
	    	String date = OLAPset.getString(NUM_COLS);
	    	String formattedDate;
	    	if(date == null){
	    		formattedDate = "null";
	    	}
	    	else{
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        Date convertedDate = dateFormat.parse(date);        
	        SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
	        formattedDate = finalFormat.format(convertedDate);
	    	}
	    	%>
			<td width="200"><%=formattedDate%></td>
		</tr>
		<%
	        	}
%>
	</table>
	<%
		try{
			conn.close();
		}

		catch(Exception ex){
			out.println("<hr>Error closing the connection to the database<hr>");
		}
}
else{
	out.print("You are not allowed to view this page.");
}
	%>

</BODY>

</HTML>

