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
	<%@ page import="java.io.*"%>

	<center>
		<h1>Report Details</h1>
	</center>


	<%
		// Set up connection
	    Connection conn = connect.connect.dbConnect();
	    Statement stmt = null;
	    ResultSet rset = null;
	 // Retrieve recordId
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
	 	

	 	/** A servlet that reads a GIF file off the local system
	 	 *  and sends it to the client with the appropriate MIME type.
	 	 *  Includes the Content-Length header to support the
	 	 *  use of persistent HTTP connections unless explicitly
	 	 *  instructed not to through "usePersistence=no".
	 	 *  Used by the PersistentConnection servlet.
	 	 *  <P>
	 	 *  Do <I>not</I> install this servlet permanently on
	 	 *  a public server, as it provides access to image
	 	 *  files that are not necessarily in the Web
	 	 *  server path.
	 	 *  <P>
	 	 *  Taken from Core Servlets and JavaServer Pages
	 	 *  from Prentice Hall and Sun Microsystems Press,
	 	 *  http://www.coreservlets.com/.
	 	 *  &copy; 2000 Marty Hall; may be freely used or adapted.
	 	 */
	 	 
	%>
	<form name="UPLOAD" method="POST" enctype="multipart/form-data"
		action="">
		<table>
			<tr>
				<th>File path:</th>
				<td><input name="FILEPATH" type="file" size="30"></input>
				</td>
			</tr>
			<tr>
				<td ALIGN=CENTER COLSPAN="2"><input type="submit"
					name=".submit" value="Upload">
				</td>
			</tr>
		</table>
	</form>
	<%
/*
	 	OutputStream o = response.getOutputStream();
	 	InputStream is = new FileInputStream(new File("/home/dsk03/ugrad/jabrand/Desktop/ALLIEScreenshots/21EasterEggInput.jpg"));
	 	byte[] buf = new byte[32 * 1024]; 
	 	int nRead = 0;
	 	while( (nRead=is.read(buf)) != -1 ) {
	 	    o.write(buf, 0, nRead);
	 	}
	 	o.flush();
	 	o.close();
*/


	%>

</body>
</html>