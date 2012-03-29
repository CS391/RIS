<html>
<head>
<title>Logout</title>
</head>
<body>
        <%
        Cookie cookies[] = request.getCookies();
        Cookie tempCookie = null;
        for(int i=0; i < cookies.length; i++){
        	tempCookie = cookies[i];
        	tempCookie.setMaxAge(0);
        	response.addCookie(tempCookie);
        }
        session.removeAttribute("class");
		response.sendRedirect("/391Project/"); 
        %>
</body>
</html>