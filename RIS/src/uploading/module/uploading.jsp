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

       String recordQuery = "SELECT record_id,  FROM radiology_record";
       try{
           stmt = conn.createStatement(
                   ResultSet.TYPE_SCROLL_INSENSITIVE,
                   ResultSet.CONCUR_READ_ONLY);
           rset = stmt.executeQuery(infoQuery);
       } 
       catch (Exception ex){
           out.println("<hr>" + ex.getMessage() + "<hr>");
       }
       %>

	<FORM NAME="Select" ACTION="uploadFromLocal.jsp" METHOD="post"">

		<select name="TEST">
						<%
       String testing = "";
           out.println("<option value=\"" + testing + "\">" + testing + "</option>");

	%>

		</select> 
		<br>

		<INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
	</FORM>
	<%   
			
			
%>