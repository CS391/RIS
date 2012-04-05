<%@ include file="/src/header/module/header.jsp"%>

<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Generated Report</title>
</head>
<body>
	<%@ page import="java.sql.*"%>

	<H1>
		<CENTER>Generated Report</CENTER>
	</H1>

	<%
Connection conn = connect.connect.dbConnect();
	//get the logged in users class
String className = (String) session.getAttribute("class");
	//check to see if the user can access this page
boolean allowed = connect.CheckClass.checkClass("report_generating", className);
if(allowed){
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
    while(rset.next()){
        %>
		
		<tr>
			<td width="100">Patient</td>
			<%
    	for(int j=1;j<=NUM_COLS-1;j++){
    	    String value = rset.getString(j);
			%>
			<td width="150"><%=value%></td>
			<%

    	}
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date convertedDate = dateFormat.parse(rset.getString(NUM_COLS));        
        SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
        String formattedDate = finalFormat.format(convertedDate);
	%>
			<td width="150"><%=formattedDate%></td>
		</tr>
		<%
    	}
}
else{
	out.print("You are not allowed to view this page. Log in as a user with the appropriate class");
}
%>
	</table>

</body>
</html>