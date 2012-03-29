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
Statement stmt = null;
ResultSet rset = null;

if(request.getParameter("Submit") == null &&
        request.getParameter("Submit Changes") == null){
    
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
			<td width="150">First Name</td>
			<td width="150">Last Name</td>
			<td width="150">Address</td>
			<td width="150">Phone</td>
			<td width="150">Prescribing Date</td>
		<tr>

			<%
    while(rset.next()){
        %>
        <tr>
        <td width ="100">Patient</td>
        <%
    	for(int j=1;j<=NUM_COLS-1;j++){
    	    String value = rset.getString(j);
			%> 
			<td width="150"><%=value%> </td> 
			<%

    	}
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date convertedDate = dateFormat.parse(rset.getString(NUM_COLS));        
        SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
        String formattedDate = finalFormat.format(convertedDate);
	%> 
	<td width="150"><%=formattedDate%> </td> 
	</tr>
	<%
    	}
}
%>
</table>
		
</body>
</html>