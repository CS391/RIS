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

//STEP 1: Enter a Radiology Record
 //radiology_record(record_id,patient_name,doctor_name,radiologist_name,
 //test_type,prescribing_date,test_date,diagnosis, description)
   
//STEP 2: Upload a photo from local file

    Connection conn = connect.connect.dbConnect();
    Statement stmt = null;
    ResultSet rset = null;
    
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
    
		ArrayList<String> doctorNames = new ArrayList<String>();
    	ArrayList<String> radiologistNames = new ArrayList<String>();
    	ArrayList<String> testTypes = new ArrayList<String>();
    	
    String infoQuery = "SELECT doctor_name, radiologist_name, test_type FROM radiology_record";
    try{
        stmt = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        rset = stmt.executeQuery(infoQuery);
    }     catch (Exception ex){
        out.println("<hr>" + ex.getMessage() + "<hr>");
    }
    
    //TODO: Broken?
    	while(rset.next() && rset != null){
    		doctorNames.add(rset.getString(1));
    	    radiologistNames.add(rset.getString(2));
    	    testTypes.add(rset.getString(3));
    	}

    
       %>

	<FORM NAME="UploadingForm" ACTION="uploadFromLocal.jsp" METHOD="post"">
		<H4>Enter Patient Name</H4>
		<br> <input name="PATIENTNAME" type="text" size="25"> <input
			type="reset" value="Reset"><br> <br>
		<H4>Select Doctor Name</H4>
		<br> <select name="DOCTORNAME">
			<% 
			//TODO: Broken
			String doctorName = "";
			for(int i=0; i<doctorNames.size();i++){
			    doctorName = doctorNames.get(i);
			    if(doctorName != null){
					out.println("<option value=\"" + doctorName + "\">" + doctorName + "</option>");
				}
			}
	%>
		</select><br> <br>
		<H4>Enter Radiologist Name</H4>
		<br> <input name="RADIOLOGISTNAME" type="text" size="25">
		<input type="reset" value="Reset"> <br> <br>
		<H4>Enter Test Type</H4>
		<br> <input name="TESTTYPE" type="text" size="25"> <input
			type="reset" value="Reset"> <br> <br>
		<H4>Enter Prescribing Date</H4>
		<br> <input name="PRESCRIBINGDATE" type="text" size="25">
		<input type="reset" value="Reset"> <br> <br>
		<H4>Enter Test Date</H4>
		<br> <input name="TESTDATE" type="text" size="25"> <input
			type="reset" value="Reset"> <br> <br>
		<H4>Enter Diagnosis</H4>
		<br> <input name="DIAGNOSIS" type="text" size="25"> <input
			type="reset" value="Reset"> <br> <br>
		<H4>Enter Description</H4>
		<br> <input name="DESCRIPTION" type="text" size="25"> <input
			type="reset" value="Reset"> <br> <br>
		<%
	
	%>

		<br> <INPUT TYPE="submit" NAME="SUBMIT" VALUE="UploadingForm">
	</FORM>
	<%   
			
			
%>