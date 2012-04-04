<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Upload Radiology Record</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	<%@ page import="jave.text.*" %>

	<H1>Ender Radiology Record</H1>
	<%
/*
*This module will be used by radiologists to first enter a radiology record, 
*and then to upload medical images into the radiology record.
*A sample uploading program is in UploadFromLocal.jsp
*/
	boolean returned = false;

	    // First entry
	    if (request.getParameter("PATIENTNAME") == null){
	    	//TODO: Finish verification test!
	    	returned = false;
	    } else{
	       	returned = true;
	       	
		    String patientName = request.getParameter( "PATIENTNAME");
		    String doctorName   = request.getParameter("DOCTORNAME");
		    String radiologistName = request.getParameter("RADIOLOGISTNAME");
		    String testType   = request.getParameter("TESTTYPE");
		    String prescribingDate = request.getParameter("PRESCRIBINGDATE");
		    String testDate   = request.getParameter("TESTDATE");
		    String diagnosis = request.getParameter("DIAGNOSIS");
		    String description   = request.getParameter("DESCRIPTION");
	       	
	      // Invalid submission
		  if(patientName.equals("") || doctorName.equals("") || 
		        radiologistName.equals("") ||testType.equals("") || 
		        prescribingDate.equals("") ||testDate.equals("") ||
		        diagnosis.equals("") ||description.equals("") || 
		        !validDates(prescribingDate, testDate)){
		      	out.println("Please fill out the form with all fields in the correct format");
		      // Valid submission
		  } else{

	   		session.setAttribute( "patientName", patientName);
	   		session.setAttribute( "doctorName", doctorName);
	   		session.setAttribute( "radiologistName", radiologistName);
	   		session.setAttribute( "testType", testType);
	   		session.setAttribute( "prescribingDate", prescribingDate);
	   		session.setAttribute( "testDate", testDate);
	   		session.setAttribute( "diagnosis", diagnosis);
	   		session.setAttribute( "description", description);
	   		
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

		<%!private boolean validDates(String prescribingDate, String testDate){

		    try{
		           SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy");
		           Date convertedDate = dateFormat.parse(prescribingDate);
		           convertedDate = dateFormat.parse(testDate);
		           return true;
		    	} catch (Exception pe){
		    	    return false;
		    	}
		}
		    %>
		<br> <INPUT TYPE="submit" NAME="SUBMIT" VALUE="UploadingForm">
	</FORM>