<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Upload Radiology Record</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.ArrayList"%>

	<H1>Ender Radiology Record</H1>
	<%
/*
*This module will be used by radiologists to first enter a radiology record, 
*and then to upload medical images into the radiology record.
*A sample uploading program is in UploadFromLocal.jsp
*/
   
//STEP 2: Upload a photo from local file
	boolean returned = false;

	    // First entry
	    if (request.getParameter("PATIENTNAME") == null){
	    	//TODO: Finish verification test!
	    	returned = false;
	    } else{
	       	returned = true;
	       	
	       	
	      // Invalid submission
		  if(request.getParameter("PATIENTNAME").equals("") || request.getParameter("DOCTORNAME").equals("") || 
		        request.getParameter("RADIOLOGISTNAME").equals("") || request.getParameter("TESTTYPE").equals("") || 
		        request.getParameter("PRESCRIBINGDATE").equals("") || request.getParameter("TESTDATE").equals("") ||
		        request.getParameter("DIAGNOSIS").equals("") || request.getParameter("DESCRIPTION").equals("") || 
		        !testDates(request.getParameter("PRESCRIBINGDATE"), request.getParameter("TESTDATE"))){
		      	out.println("Please fill out the form with all fields this time");
		      // Valid submission
		  } else{
			out.println("<jsp:forward page=\"inputValidator.jsp\"></jsp:forward>");

			//TODO: still not passing parameters........
	   String patientName = request.getParameter( "patientName");
  	   session.setAttribute( "theName", );


		    String redirectURL = "inputValidator.jsp";
		    response.sendRedirect(redirectURL);
		  }
	      }
	String valueToSet = "";

	// Set up connection
    Connection conn = connect.connect.dbConnect();
    Statement stmt = null;
    ResultSet rset = null;
    
    	//Retrieve Doctor and Radiologist names
		ArrayList<String> doctorNames = new ArrayList<String>();
    	ArrayList<String> radiologistNames = new ArrayList<String>();
    String infoQuery = "SELECT user_name, class FROM users u WHERE u.class ='r' OR u.class='d'";
    try{
        stmt = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rset = stmt.executeQuery(infoQuery);
    }     catch (Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
    }
    	// Prepare doctor and radiologist names
    	while( rset != null && rset.next()){
    	    if(rset.getString(2).equals("d"))
    	    {
    		doctorNames.add(rset.getString(1));
    	    } 
    	    else if (rset.getString(2).equals("r"))
    	    {
    	    radiologistNames.add(rset.getString(1));

		}

    	}
    	    	

       %>

	<FORM NAME="UploadingForm" ACTION="uploading.jsp" METHOD="post"">
		<%
		out.println("<H4>Enter Patient Name</H4>");
			if(returned){
			    valueToSet = request.getParameter("PATIENTNAME");
			}
			out.println("<br> <input name=\"PATIENTNAME\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
			valueToSet = "";
		
		out.println("<H4>Select Doctor Name</H4>");
		out.println("<br> <select name=\"DOCTORNAME\">");
			
			// Populate doctor dropdown
			String doctorName = "";
			for(int i=0; i<doctorNames.size();i++){
			    doctorName = doctorNames.get(i);
			    if(doctorName != null){
					out.println("<option value=\"" + doctorName + "\">" + doctorName + "</option>");
				}
			}
	
		out.println("</select><br> <br>");
		out.println("<H4>Select Radiologist Name</H4>");
		out.println("<br> <select name=\"RADIOLOGISTNAME\">");
		
			// Populate radiologist dropdown
			String radiologistName = "";
		for(int i=0; i<radiologistNames.size();i++){
		    radiologistName = radiologistNames.get(i);
		    if(radiologistName != null){
				out.println("<option value=\"" + radiologistName + "\">" + radiologistName + "</option>");
			}
		}
		out.println("</select><br> <br>");
		
		out.println("<H4>Enter Test Type</H4>");
		if(returned){
		    valueToSet = request.getParameter("TESTTYPE");
		}
		out.println("<br> <input name=\"TESTTYPE\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
		valueToSet = "";
		
		out.println("<H4>Enter Prescribing Date</H4>");
		if(returned){
		    valueToSet = request.getParameter("PRESCRIBINGDATE");
		}
		out.println("<br> <input name=\"PRESCRIBINGDATE\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
		valueToSet = "";
		
		out.println("<H4>Enter Test Date</H4>");
		if(returned){
		    valueToSet = request.getParameter("TESTDATE");
		}
		out.println("<br> <input name=\"TESTDATE\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
		valueToSet = "";
		
		out.println("<H4>Enter Diagnosis</H4>");
		if(returned){
		    valueToSet = request.getParameter("DIAGNOSIS");
		}
		out.println("<br> <input name=\"DIAGNOSIS\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
		valueToSet = "";
		
		out.println("<H4>Enter Description</H4>");
		if(returned){
		    valueToSet = request.getParameter("DESCRIPTION");
		}
		out.println("<br> <input name=\"DESCRIPTION\" type=\"text\" size=\"25\"value=\""+valueToSet+"\"> <input type=\"reset\" value=\"Reset\">");
		valueToSet = "";
		%>
		
		<%!private boolean testDates(String prescribingDate, String testDate){

		    return true;
		}
		    %>
		<br> <INPUT TYPE="submit" NAME="SUBMIT" VALUE="UploadingForm">
	</FORM>