<%@page import="org.apache.commons.fileupload.*, java.util.*, java.io.*, java.sql.*" %>
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
   
   	out.println ("Upload Is Successful!");
   
   	Connection conn = connect.connect.dbConnect ();
   
	PreparedStatement ps = null;
	ResultSet rset = null;
	// Get record_id from user
	String record_id = "5";
	// Find the next image_id to use
	String image_id = "5";
	String sql = "insert into pacs_images values ('" + record_id + "', '" + image_id + "', ?, ?, ?)";
	FileInputStream fis = null;
	try
	{
		ps = conn.prepareStatement (sql);

		out.println ("Hi");
		File image = new File (path);
		out.println ("Hi2");
		fis = new FileInputStream (image);
		out.println ("Hi3");
		// Thumbnail, need to change the size of picture
		ps.setBinaryStream (1, (InputStream) fis, (int) (image.length ()));
		// Regular size, need to change the size of picture
		ps.setBinaryStream (2, (InputStream) fis, (int) (image.length ()));
		// Full size, should be usual do not change.
		ps.setBinaryStream (3, (InputStream) fis, (int) (image.length ()));
		out.println ("Hi4");
		int s = ps.executeUpdate ();
		out.println ("Hi5");
		if (s > 0) 
		{ 
			// Tell user they've uploaded
			out.println ("Winning");
		}
		else
		{
			// Tell user the upload failed
			out.println ("I've failed my ancestors");			
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
