<%@ include file="/src/header/module/header.jsp" %>
<html>

<head>
<title>User Management</title>
</head>

<body>
<!--  
	Tables: users, persons, family_doctor 
	system administrator only, "a" h
-->
Please select a user to manage:
<br>
<%@ page import="java.sql.*" %>
<%@ page import="src.javaFunctions.connect" %>
<% 

	if (request.getParameter ("Submit") == null)
	{
		Connection conn = null;
		
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "select user_name from users";
		try
		{
			stmt = conn.createStatement ();
			rset = stmt.executeQuery (sql);
		}
		catch (Exception ex)
		{
			out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
		
		out.println ("<FORM NAME=\"Select\" ACTION=\"\" METHOD=\"post\">");
		out.println ("<select name=\"USER\">");
		
		String result = "";
		while(rset != null && rset.next ())
		{
			result = rset.getString (1).trim ();
			out.println ("<option value=\"" + result + "\">" + result + "</option>");
		}
		
		out.println ("</select>");
		out.println ("<INPUT TYPE=\"submit\" NAME=\"Submit\" VALUE=\"Select\">");
		out.println ("</FORM>");
		
		try
		{
			conn.close();
		}
		catch (Exception ex)
		{
			out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
	}
	else
	{
		String userName = request.getParameter ("USER").trim ();
		out.println ("Found: " + userName);
	}
%>
</body>

</html>