<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Report Generator</title>

</head>

<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.util.Calendar"%>
	<%@ page import="java.text.SimpleDateFormat"%>
	
	<H2><CENTER>Report Specification Page</CENTER></H2>
	
	<%

/*report generating module

This module will be used by a system 
*administrator to get the list of all 
*patients with a specified diagnosis for a given time period. 
*For each patient, the list must contain the name, address and phone number 
*of the patient, and testing date of the first radiology record that 
*contains the specified diagnosis. For example, a system administrator 
*shall be able to use this tool to generate the list of all patients who
*have been diagnosed having breast cancer in 2010.
*
*/
    Connection conn = connect.connect.dbConnect();
    Statement stmt = null;
    ResultSet rset = null;

	
if(request.getParameter("Submit") == null &&
   request.getParameter("Submit Changes") == null)
   {
    out.println("DEBUG: submit + submit changes null");
       String infoQuery = "SELECT diagnosis, prescribing_date FROM radiology_record";
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
	<FORM NAME="Select" ACTION="reportGenerated.jsp" METHOD="post"">
		<select name="DIAGNOSIS">

			<%
       out.println("\nPlease indicate the diagnosis to report: ");
       String diagnosis = "";
       while(rset != null && rset.next()){
           diagnosis = rset.getString(1).trim();
           
           out.println("<option value=\"" + diagnosis + "\">" + diagnosis + "</option>");
		}
       rset.beforeFirst();
	%>
		</select> <br> <select name="STARTDATE">

			<%
       out.println("\nPlease indicate the start time of the report: ");
       String startDate = "";
       while(rset != null && rset.next()){
           startDate = rset.getString(2).trim();
           SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
           Date convertedDate = dateFormat.parse(startDate);        
           SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
           startDate = finalFormat.format(convertedDate);
           out.println("<option value=\"" + startDate + "\">" + startDate + "</option>");
		}
       rset.beforeFirst();
	%>
		</select> <br> <select name="ENDDATE">
			<%
    out.println("\nPlease indicate the end time of the report: ");
       String endDate = "";
       while(rset != null && rset.next()){
           endDate = rset.getString(2).trim();
           SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
           Date convertedDate = dateFormat.parse(endDate);        
           SimpleDateFormat finalFormat = new SimpleDateFormat("dd-MMM-yy");
           endDate = finalFormat.format(convertedDate);
           out.println("<option value=\"" + endDate + "\">" + endDate + "</option>");
		}
       rset.beforeFirst();
	%>
		</select> <br> <INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
	</FORM>

	<%   

   }
else{
    out.println("Invalid Navigation");
}

try{
    conn.close();
  } catch (Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
  }


%>
</body>

</html>