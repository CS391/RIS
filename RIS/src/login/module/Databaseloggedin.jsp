<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
	String CCID = (request.getParameter("CCID")).trim();
	String PASS = (request.getParameter("PASS")).trim();
		
	connect.connect.setLogin(CCID,PASS);
	response.sendRedirect("/RIS/src/login/module/login.jsp");
%>
</body>
</html>