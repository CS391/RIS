<%@ include file="/src/header/module/header.jsp" %>

<html>

<head>
<title>Picture</title>
</head>

<body>
<!-- <%@ page import="java.sql.*, java.io.*" %>  -->
<%
	String picid  = request.getQueryString ();
	String query;

	if (picid.startsWith ("big"))  
	    query = "select full_size from pacs_images where image_id=" + picid.substring (3);
	else
	    query = "select thumbnail from pacs_images where image_id=" + picid;

	Connection conn = null;
	Statement stmt = null;
	try 
	{
	    conn = connect.connect.dbConnect ();
	    out.println ("Hey");
	    stmt = conn.createStatement ();
	    out.println ("Hey1");
	    ResultSet rset = stmt.executeQuery (query);
	    out.println ("Hey2");

	    if (rset.next ()) 
	    {
	    	InputStream imgByt = rset.getBinaryStream (1);
	    	response.setContentType ("image/jpg");
	    	int imageByte;
	    	while ((imageByte = imgByt.read ()) != -1)
	    	{
	    		response.getOutputStream ().write (imageByte);	    		
	    	}
	    	response.getOutputStream ().flush ();
	    	response.getOutputStream ().close ();
	    	imgByt.close ();
	    } 
	    else
	    {
			out.println ("No picture available.");
	    }
	} 
	catch (Exception ex) 
	{
		out.println ("<hr>" + ex.getMessage () + "<hr>");
	}
	
	try
	{
		conn.close();
	}
	catch (Exception ex)
	{
		out.println ("<hr>" + ex.getMessage () + "<hr>");
	}
%>
</body>

</html>