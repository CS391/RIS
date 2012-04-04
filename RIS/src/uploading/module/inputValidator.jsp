<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Confirm Report Contents</title>
</head>
<body>

	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>


	<center>
		<h1>Please Confirm Report Contents</h1>
	</center>


	<%
	//STEP 1: Enter a Radiology Record
	 //radiology_record(record_id,patient_name,doctor_name,radiologist_name,
	//test_type,prescribing_date,test_date,diagnosis, description)	 
			// Set up connection
	    Connection conn = connect.connect.dbConnect();
	    Statement stmt = null;
	    ResultSet rset = null;
	 // Retrieve recordIdQuery
    String recordIdQuery = "SELECT MAX(record_id) FROM radiology_record";
    try{
        stmt = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rset = stmt.executeQuery(recordIdQuery);
    } 
    
    catch (Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
    }

    	int recordId = -1;
    if(rset!=null){
        rset.next();
    	recordId = rset.getInt(1)+1;
    }
	
		String patientName = (String) session.getAttribute("patientName");
	    String doctorName = (String) session.getAttribute("doctorName");
	    String radiologistName = (String) session.getAttribute("radiologistName");
	    String testType = (String) session.getAttribute("testType");
	    String prescribingDate = (String) session.getAttribute("prescribingDate");
	    out.println("prescribingDate = " + prescribingDate);
	    String testDate = (String) session.getAttribute("testDate");
	    out.println("testDate = " + testDate);
	    String diagnosis = (String) session.getAttribute("diagnosis");
	    String description = (String) session.getAttribute("description");

	%>

</body>
</html>