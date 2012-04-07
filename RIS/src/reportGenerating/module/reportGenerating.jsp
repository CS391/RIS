<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Report Generator</title>
<link rel="stylesheet" type="text/css" href="/391Project/src/CSS/datepicker.css" />
<script type="text/javascript" src="/391Project/src/javascript/datepicker.js"></script>
</head>

<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>

	<CENTER>
		<H1>Report Specification Page</H1>
	</CENTER>

	<%
    Statement stmt = null;
    ResultSet rset = null;
    
	Connection conn = connect.connect.dbConnect ();
	//get the logged in users class
	String className = (String) session.getAttribute("class");
		//check to see if the user can access this page
	boolean allowed = connect.CheckClass.checkClass("report_generating", className);
	if(allowed){
       String diagnosis_sql = "SELECT unique diagnosis FROM radiology_record order by upper(diagnosis)";
       String prescribing_date = "SELECT unique prescribing_date FROM radiology_record order by prescribing_date"; 
       try{
           stmt = conn.createStatement();
           rset = stmt.executeQuery(diagnosis_sql);
       } 
       catch (Exception ex){
           out.println("<hr>" + ex.getMessage() + "<hr>");
       }
       %>

	<FORM NAME="Select" ACTION="reportGenerated.jsp" METHOD="post"">
		<H5>Report Diagnosis</H5>
		<select name="DIAGNOSIS">
			<%
       String diagnosis = "";
       while(rset != null && rset.next()){
           diagnosis = rset.getString(1).trim();
           
           out.println("<option value=\"" + diagnosis + "\">" + diagnosis + "</option>");
		}
//        rset.beforeFirst();
       
	%>

		</select> <br>
		<H5>Report Start Time</H5>

		<%
			
       try{
           stmt = conn.createStatement();
           rset = stmt.executeQuery(prescribing_date);
       } 
       catch (Exception ex){
           out.println("<hr>" + ex.getMessage() + "<hr>");
       }
				out.println ("<td><input name=\"STARTDATE\"></td>"); 
				out.println ("<td><input type=button value=\"select\" onclick=\"displayDatePicker('STARTDATE', false, 'dmy', '-');\"></td>");
	%>
		<br>
		<H5>Report End Time</H5>
		<%
    out.print("Please indicate the end time of the report: <br>");
		       try{
		           stmt = conn.createStatement();
		           rset = stmt.executeQuery(prescribing_date);
		       } 
		       catch (Exception ex){
		           out.println("<hr>" + ex.getMessage() + "<hr>");
		       }
		       
				out.println ("<td><input name=\"ENDDATE\"></td>"); 
				out.println ("<td><input type=button value=\"select\" onclick=\"displayDatePicker('ENDDATE', false, 'dmy', '-');\"></td>");
		       
	%>
		<br> <br> <INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
	</FORM>
	<%   

try{
    conn.close();
  } catch (Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
  }
	}
	else{
		out.print("You are not allowed to view this page. Log in as a user with the appropriate class");
	}
%>
</body>

</html>
