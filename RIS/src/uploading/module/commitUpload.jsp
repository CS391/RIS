<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Report Details</title>
</head>
<body>

	<%@ page import="java.sql.*"%>

	<center>
		<h1>Report Details</h1>
	</center>


	<%
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
	    String testDate = (String) session.getAttribute("testDate");
	    String diagnosis = (String) session.getAttribute("diagnosis");
	    String description = (String) session.getAttribute("description");

	            try{           
	            PreparedStatement pst = conn.prepareStatement("INSERT INTO radiology_record (record_id, patient_name, doctor_name, "
	                    				+"radiologist_name, test_type, prescribing_date, test_date, diagnosis, description) "
	                    				+"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
	            pst.setInt(1, recordId);
	            pst.setString(2, patientName);
	            pst.setString(3, doctorName);
	            pst.setString(4, radiologistName);
	            pst.setString(5, testType);
	            pst.setString(6, prescribingDate);
	            pst.setString(7, testDate);
	            pst.setString(8, diagnosis);
	            pst.setString(9, description);
	            pst.execute();

	            conn.commit();
		        out.println("<h3>Changes succesfully committed<h3>");
		        
	 } catch (SQLException e) {
	      if (conn != null) {
	        conn.rollback();
	        out.println("<h3>ROLLBACK: Changes not committed<h3>");
	      }
	      e.printStackTrace();
	    }
	 finally {
	      if (conn != null && !conn.isClosed()) {
	        conn.close();
	      }
	    }
	    
	 	out.println("<br><br><br>");
	 	out.println("<center><h1>Add Image<h1><center>");
	%>

</body>
</html>