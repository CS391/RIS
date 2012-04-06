<%@ include file="/src/header/module/header.jsp"%>

<%@ page import="java.io.*"%>

<HTML>
<HEAD>
<TITLE>Data Analysis</TITLE>
</HEAD>
<BODY>
	<%@ page import="java.sql.*"%>

	<H1>
		<CENTER>Data Analysis</CENTER>
	</H1>
	<% 
	//connect the the database
Connection conn = connect.connect.dbConnect ();
	//get the logged in users class
String className = (String) session.getAttribute("class");
	//check to see if the user can access this page
boolean allowed = connect.CheckClass.checkClass("data_analysis", className);
if(allowed){
	
	Statement Patients= null;
	ResultSet patientSet = null;

String patientQuery =	"SELECT USER_NAME " + 
					"FROM USERS " + 
					"WHERE CLASS = 'p'";

try{
        Patients = conn.createStatement();
		patientSet = Patients.executeQuery(patientQuery);
	}
catch(Exception ex){
		out.println("<hr>Error processing the Analysis Report.<hr>");
	}
%>

<head>
<script type="text/javascript">
    function displayForm(c){
        if(c.value == "1"){
            document.getElementById("Patient").style.visibility='hidden';
        }
        else if(c.value =="2"){
            document.getElementById("Patient").style.visibility='visible';
        }
        else{
        }
    }        
</script>
</head>

<form name="input" action="OLAPreport.jsp" method="post">
	<b>Display by:</b><br> <label>Patient Name<input value="1"
		type="radio" name="formselector" onclick="displayForm(this)" checked>
	</label> <label> Test Type<input value="2" type="radio"
		name="formselector" onclick="displayForm(this)">
	</label> <select style="visibility: hidden" id="Patient" name="Patient">
		<%
while(patientSet.next()){
	out.println("<option id="+"'"+patientSet.getString(1)+"'"+">"+patientSet.getString(1)+"</option>");
	}
	%>
	</select><br> <label> Time Period:<select name="Time">
		<option id="year">Year</option>
		<option id="month">Month</option>
		<option id="week">Week</option>
	</select></label><br> <input type="submit" value="Submit" />
</form>
<%

		try{
			conn.close();
		}

		catch(Exception ex){
			out.println("<hr>Error closing the connection to the database<hr>");
		}
}
else{
	out.print("You are not allowed to view this page. Log in as a user with the appropriate class");
}
	%>
</BODY>

</HTML>

