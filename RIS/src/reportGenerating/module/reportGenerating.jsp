<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Report Generator</title>
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

		</select> 
		<br>
		<H5>Report Start Time</H5>
		<select name="STARTDATE">
			<%
			
       try{
           stmt = conn.createStatement();
           rset = stmt.executeQuery(prescribing_date);
       } 
       catch (Exception ex){
           out.println("<hr>" + ex.getMessage() + "<hr>");
       }
		String startDate = "";
       while(rset != null && rset.next()){
//            startDate = rset.getString(1).trim();
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//            Date convertedDate = null;
//            try
//            {
//            	convertedDate = dateFormat.parse(startDate);
//            }
//            catch (Exception e)
//            {
//         	   out.println ("<hr>" + e.getMessage () + "<hr>");
//            }
//            SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
//            startDate = finalFormat.format(convertedDate);
// 			startDate = connect.connect.getDateStringFromDateString (rset.getString(1).trim());
			startDate = connect.connect.getDateStringFromDateString (rset.getString(1).trim());
           out.println("<option value=\"" + startDate + "\">" + startDate + "</option>");
		}
//        rset.beforeFirst();
	%>

		</select> 
		<br>
		<H5>Report End Time</H5>

		<select name="ENDDATE">
			<%
    out.print("<br>Please indicate the end time of the report: <br>");
		       try{
		           stmt = conn.createStatement();
		           rset = stmt.executeQuery(prescribing_date);
		       } 
		       catch (Exception ex){
		           out.println("<hr>" + ex.getMessage() + "<hr>");
		       }
       String endDate = "";
       while(rset != null && rset.next()){
//            endDate = rset.getString(1).trim();
//            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//            Date convertedDate = null;
//            try
//            {
//            	convertedDate = dateFormat.parse(startDate);
//            }
//            catch (Exception e)
//            {
//         	   out.println ("<hr>" + e.getMessage () + "<hr>");
//            }     
//            SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
//            endDate = finalFormat.format(convertedDate);
			endDate = connect.connect.getDateStringFromDateString (rset.getString(1).trim());
           out.println("<option value=\"" + endDate + "\">" + endDate + "</option>");
		}
//        rset.beforeFirst();
	%>
		</select> 
		<br> 
		<br> 
		<INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
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
