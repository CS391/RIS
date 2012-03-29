<%@ include file="/src/header/module/header.jsp" %>
<html>
<head>
<title>Upload Radiology Record</title>
</head>
<body>


<%
/*
*This module will be used by radiologists to first enter a radiology record, 
*and then to upload medical images into the radiology record.
*A sample uploading program is in UploadFromLocal.jsp
*/

//STEP 1: Enter a Radiology Record
//STEP 2: Upload a photo from local file

       %>

	<FORM NAME="Select" ACTION="uploadFromLocal.jsp" METHOD="post"">
		<H5>Report Diagnosis</H5>
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