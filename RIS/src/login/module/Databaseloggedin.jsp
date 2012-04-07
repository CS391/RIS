<html>
<head>
</head>
<body>
<%@ page import="java.sql.*"%>
<%
	//The username and password used to login to the database
	String CCID = (request.getParameter("CCID")).trim();
	String PASS = (request.getParameter("PASS")).trim();
	connect.connect.setLogin(CCID,PASS);
	Connection conn = connect.connect.dbConnect();
	if(conn != null)
	{
	//calls the connect class that we created to connect to the database
	session.setAttribute("CCID", CCID);
	session.setAttribute("PASS", PASS);
	//with the username and password as parameters
	connect.connect.setLogin(CCID,PASS);
	response.sendRedirect("/RIS/src/login/module/login.jsp");
	}
	else
	{
	session.setAttribute("wrongDBPass", "true");//used to display a "wrong password" message
	response.sendRedirect("/RIS/src/login/module/DatabaseLogin.jsp");
	}
%>
</body>
</html>