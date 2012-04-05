<%@ include file="/src/header/module/header.jsp" %>

<html>

<head>
<title>Search</title>
</head>

<body>
<%@ page import="java.sql.*" %>
<%
	if (request.getParameter ("SubmitSearch") == null)
	{
		out.println ("Please enter your search terms.");
		Connection conn = connect.connect.dbConnect ();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = "select * from users";
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
			out.println ("<br><br><table><tr>");
				out.println ("<td>Keywords: </td>");
				out.println ("<td><input type=\"text\" name=\"search\" value=\"" + "\" /></td>");
			out.println ("</tr><tr>");
				out.println ("<td>Start: </td>");
				out.println ("<td><input type=\"text\" name=\"start\" value=\"" + "\" /></td>");
				out.println ("<td>End: </td>");
				out.println ("<td><input type=\"text\" name=\"end\" value=\"" + "\" /></td>");
			out.println ("</tr><tr>");
				out.println ("<td><INPUT TYPE=\"submit\" NAME=\"SubmitSearch\" VALUE=\"Submit\"></td>");
			out.println ("</tr></table>");
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
	else if (request.getParameter ("SubmitSearch") != null)
	{
		String text = request.getParameter ("search");
		String start = request.getParameter ("start");
		String end = request.getParameter ("end");
		
		out.println (text + "<br>");
		out.println (start + "<br>");
		out.println (end + "<br>");
	}
%>
</body>

</html>