<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Report Generator</title>
</head>

<body>
	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.Date"%>
	<%@ page import="java.text.SimpleDateFormat"%>

		<CENTER><H1>Report Specification Page</H1></CENTER>
		
	<%
    Connection conn = connect.connect.dbConnect();
    Statement stmt = null;
    ResultSet rset = null;

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
		<H5>Report Diagnosis</H5>
		<select name="DIAGNOSIS">
			<%
       String diagnosis = "";
       while(rset != null && rset.next()){
           diagnosis = rset.getString(1).trim();
           
           out.println("<option value=\"" + diagnosis + "\">" + diagnosis + "</option>");
       rset.beforeFirst();
       
	%>

		</select>
			<br>
		<H5>Report Start Time</H5>
		<select name="STARTDATE">
			<%
			
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

		</select> 
		<br>
		<H5>Report End Time</H5>
		
		 <select name="ENDDATE">
			<%
    out.print("<br>Please indicate the end time of the report: <br>");
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
		</select> 
		<br> 
		<br>
		<INPUT TYPE="submit" NAME="SUBMIT" VALUE="Select">
	</FORM>
	<%   

   }
try{
    conn.close();
  } catch (Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
  }


%>
</body>

</html>