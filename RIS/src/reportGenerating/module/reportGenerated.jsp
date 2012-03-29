<%@ include file="/src/header/module/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Generated Report</title>
</head>
<body>
	<%@ page import="java.sql.*"%>

	<H2><CENTER>Generated Report</CENTER></H2>
	
	<%
Connection conn = connect.connect.dbConnect();
Statement stmt = null;
ResultSet rset = null;

if(request.getParameter("Submit") == null &&
        request.getParameter("Submit Changes") == null){
    
    String selectedDiagnosis = request.getParameter("DIAGNOSIS").trim();
    String selectedStartDate = request.getParameter("STARTDATE").trim();
    String selectedEndDate   = request.getParameter("ENDDATE").trim();
   
    //TODO: This will break...
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
    int NUM_ROWS = 5;
   // int NUM_COLS = rset.
    
    while(rset.next()){
    out.println(rset.getString());
    }
}
%>
</body>
</html>