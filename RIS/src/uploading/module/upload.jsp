<%@ include file="/src/header/module/header.jsp" %>
<html>

<head>
<title>Upload</title>
</head>

<%@page import="org.apache.commons.fileupload.*, java.util.*, java.io.*, java.sql.*, java.awt.image.*, javax.imageio.*, oracle.jdbc.*, oracle.sql.*" %>
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
     
   	String dir = "../../../src/uploading/module/tmpFiles/";
    String path = dir + target;
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
// 	String sql = "insert into pacs_images values ('" + record_id + "', '" + image_id + "', ?, ?, ?)";
// 	FileInputStream fis1 = null;
// 	FileInputStream fis2 = null;
// 	FileInputStream fis3 = null;
	try
	{
 		File image = new File (path);
		
// 		Full size
		BufferedImage rImage = ImageIO.read (image);
// 		Thumbnail size
		BufferedImage thumbnail = connect.connect.scale (rImage, 50, 50);
// 		Regular size
		BufferedImage reg_img = connect.connect.scale (rImage, 120, 120);
		
		stmt = conn.createStatement();
	    /*
	     *  First, to generate a unique pic_id using an SQL sequence
	     */
	    int pic_id = imageId;

	    //Insert an empty blob into the table first. Note that you have to 
	    //use the Oracle specific function empty_blob() to create an empty blob
	    stmt.execute("INSERT INTO pacs_images VALUES('" + record_id + "', '" + pic_id + "', empty_blob(), empty_blob(), empty_blob())");
 
	    // to retrieve the lob_locator 
	    // Note that you must use "FOR UPDATE" in the select statement
	    String cmd = "SELECT * FROM pacs_images WHERE image_id = " + pic_id + " FOR UPDATE";
	    rset = stmt.executeQuery (cmd);
	    rset.next ();
	    BLOB myblob1 = ((OracleResultSet) rset).getBLOB (3);
	    BLOB myblob2 = ((OracleResultSet) rset).getBLOB (4);
	    BLOB myblob3 = ((OracleResultSet) rset).getBLOB (5);

	    //Write the image to the blob object
	    OutputStream outstream = myblob1.getBinaryOutputStream ();
	    ImageIO.write (thumbnail, "jpg", outstream);
	    outstream = myblob2.getBinaryOutputStream ();
	    ImageIO.write (reg_img, "jpg", outstream);
	    outstream = myblob3.getBinaryOutputStream ();
	    ImageIO.write (rImage, "jpg", outstream);
	    
	    /*
	    int size = myblob.getBufferSize();
	    byte[] buffer = new byte[size];
	    int length = -1;
	    while ((length = instream.read(buffer)) != -1)
		outstream.write(buffer, 0, length);
	    */
	    //instream.close();
	    outstream.close();
        
// 		ps = conn.prepareStatement (sql);

// 		int full = 0;
// 		int reg = 0;
// 		int thumb = 0;
		
// 		File image = new File (path);
		
// 		Full size
// 		BufferedImage rImage = ImageIO.read (image);
// 		String full_path = dir + "Full" + target;
// 		File output = new File (full_path);
// 		ImageIO.write (rImage, "jpg", output);
// 		output = new File (full_path);
// 		full = (int) output.length ();
// 		Thumbnail size
// 		BufferedImage thumbnail = connect.connect.scale (rImage, 50, 50);
// 		String thumb_path = dir + "Thumbnail" + target;
// 		output = new File (thumb_path);
// 		ImageIO.write (thumbnail, "jpg", output);
// 		output = new File (thumb_path);
// 		thumb = (int) output.length ();
// 		Regular size
// 		BufferedImage reg_img = connect.connect.scale (rImage, 120, 120);
// 		String reg_path = dir + "Regular" + target;
// 		output = new File (reg_path);
// 		ImageIO.write (reg_img, "jpg", output);
// 		output = new File (reg_path);
// 		reg = (int) output.length ();
		
// 		fis1 = new FileInputStream (thumb_path);
// 		Thumbnail, need to change the size of picture
// 		ps.setBinaryStream (1, (InputStream) fis1, thumb);
		
// 		fis2 = new FileInputStream (reg_path);
// 		Regular size, need to change the size of picture
// 		ps.setBinaryStream (2, (InputStream) fis2, reg);
		
// 		fis3 = new FileInputStream (full_path);
// 		Full size, should be usual do not change.
// 		ps.setBinaryStream (3, (InputStream) fis3, full);
		int s = stmt.executeUpdate("commit");
		if (s == 0) 
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
	
// 	fis1.close ();
// 	fis2.close ();
// 	fis3.close ();
// 	ps.close ();
	
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