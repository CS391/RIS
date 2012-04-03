<%@ include file="/src/header/module/header.jsp" %>
<html>
<head>
<title>Upload Radiology Record</title>
</head>
<body>
	<%@ page import="java.sql.*"%>
	
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
       %>

	<FORM NAME="Select" ACTION="uploadFromLocal.jsp" METHOD="post"">
	<H4>Enter Record ID</H4>
	<br>
	<input name="RECORDID" type="text" size="25" value="Enter Rocord ID">
	<input type="reset" value="Reset"><br>
	<br>
		<H4>Enter Patient_name</H4>
	<br>
	<input name="PATIENTNAME" type="text" size="25" value="Enter Patient Name">
	<input type="reset" value="Reset"><br>
	<br>
		<H4>Enter Doctor Name</H4>
	<br>
	<input name="DOCTORNAME" type="text" size="25" value="Enter Doctor Name">
	<input type="reset" value="Reset"><br>
	<br>
		<H4>Enter Radiologist Name</H4>
	<br>
	<input name="RADIOLOGISTNAME"type="text" size="25" value="Enter Radiologist Name">
	<input type="reset" value="Reset"><br>
	<br>
		<H4>Enter Test Type</H4>
	<br>
	<input name="TESTTYPE" type="text" size="25" value="Enter Test Type">
	<input type="reset" value="Reset"><br>
	<br>
			<H4>Enter Prescribing Date</H4>
	<br>
	<input name="PRESCRIBINGDATE" type="text" size="25" value="ex) 02-JAN-91">
	<input type="reset" value="Reset"><br>
	<br>
			<H4>Enter Test Date</H4>
	<br>
	<input name="TESTDATE" type="text" size="25" value="ex) 05-Jun-99">
	<input type="reset" value="Reset"><br>
	<br>
			<H4>Enter Diagnosis</H4>
	<br>
	<input name="DIAGNOSIS" type="text" size="25" value="Enter Diagnosis">
	<input type="reset" value="Reset"><br>
	<br>
			<H4>Enter Test Type</H4>
	<br>
	<input name="DESCRIPTION" type="text" size="25" value="Enter Description">
	<input type="reset" value="Reset"><br>
	<br>
	<%
	
	%>

		<br>

		<INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
	</FORM>
	<%   
			
			
%>