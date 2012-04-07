<html>
<head>
<title>Logout</title>
</head>
<body>
<%
	//get all of the cookies
	Cookie cookies[] = request.getCookies();
	Cookie tempCookie = null;
     
	//setMaxAge of each cookie to 0 which will delete them
	for(int i=0; i < cookies.length; i++)
	{
	tempCookie = cookies[i];
	tempCookie.setMaxAge(0);
	response.addCookie(tempCookie);
	}
	//remove any sessions set on login
	session.removeAttribute("class");
	session.removeAttribute("wrongPass");
	session.removeAttribute("user_name");
	session.removeAttribute("patientName");
	session.removeAttribute("doctorName");
	session.removeAttribute("radiologistName");
	session.removeAttribute("testType");
	session.removeAttribute("prescribingDate");
	session.removeAttribute("testDate");
	session.removeAttribute("diagnosis");
	session.removeAttribute("description");
	session.removeAttribute("recordId");
	session.removeAttribute("imageId");
	session.removeAttribute("CCID");
	session.removeAttribute("PASS");
	response.sendRedirect("/RIS/"); //go to the homepage
%>
</body>
</html>