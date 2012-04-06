<%@ include file="/src/header/module/header.jsp" %>
<html>

<head>
<title>Upload</title>
</head>

<%@page import="org.apache.commons.fileupload.*, java.util.*, java.io.*, java.sql.*" %>
<%@ include file="/src/header/module/header.jsp"%>
<%
   	// JSP to handle  uploading
   
   	// Create a new file upload handler 
   	DiskFileUpload upload = new DiskFileUpload ();
   
   	// parse request
   	List items = upload.parseRequest (request);
   
   	// get uploaded file 
  	FileItem  file = (FileItem) items.get (0);
   	String source = file.getName ();
   
   	// get taget filename
   	FileItem  name = (FileItem) items.get (1);
   	String  target = name.getString ();
     
    String path = "../../../src/uploading/module/tmpFiles/" + target;
   	File outfile = new File (path);
   	file.write (outfile);
   	
   	Connection conn = connect.connect.dbConnect ();
   
	PreparedStatement ps = null;
	Statement stmt = null;
	ResultSet rset = null;
	 // Retrieve recordId
	    String imageIdQuery = "SELECT MAX(image_id) FROM pacs_images";
	    try{
	        stmt = conn.createStatement(
	                ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	        rset = stmt.executeQuery(imageIdQuery);
	    } 
	    
	    catch (Exception ex){
	        out.println("<hr>" + ex.getMessage() + "<hr>");
	    }

	    	int imageId = -1;
	    if(rset!=null){
	        rset.next();
	    	imageId = rset.getInt(1)+1;
			session.setAttribute("imageId",imageId);
	    }

	// Get record_id from user
	String record_id = ""+session.getAttribute("recordId");
	// Find the next image_id to use
	String image_id = ""+imageId;
	String sql = "insert into pacs_images values ('" + record_id + "', '" + image_id + "', ?, ?, ?)";
	FileInputStream fis = null;
	try
	{
		ps = conn.prepareStatement (sql);

		File image = new File (path);
		fis = new FileInputStream (image);
		// Thumbnail, need to change the size of picture
		ps.setBinaryStream (1, (InputStream) fis, (int) (image.length ()));
		fis = new FileInputStream (image);
		// Regular size, need to change the size of picture
		ps.setBinaryStream (2, (InputStream) fis, (int) (image.length ()));
		fis = new FileInputStream (image);
		// Full size, should be usual do not change.
		ps.setBinaryStream (3, (InputStream) fis, (int) (image.length ()));
		int s = ps.executeUpdate ();
		if (s > 0) 
		{ 
			// Tell user they've uploaded
			out.println("<center><h3>File \""+target+"\" Successfully Uploaded to Patient \""+session.getAttribute("patientName")+"\" Record<h3><center>");
		}
		else
		{
			// Tell user the upload failed
			out.println("<center><h3>File "+target+" Not Successfully Uploaded to Patient "+session.getAttribute("patientName")+" Record<h3><center>");
		}
	}
	catch (Exception ex)
	{
		out.println ("<hr>" + ex.getMessage () + "<hr>");
	}
	
	fis.close ();
	ps.close ();
	
	try
	{
		conn.close();
	}
	catch (Exception ex)
	{
		out.println ("<hr>" + ex.getMessage () + "<hr>");
	}
%>

</html>