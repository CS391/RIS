<%@ include file="/src/header/module/header.jsp"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.servlet.*"%>


<html>
<head>
<title>Upload Radiology Picture</title>
</head>
<body>

	<H1>Upload Local Photo</H1>
	<%

/** A servlet that reads a GIF file off the local system
 *  and sends it to the client with the appropriate MIME type.
 *  Includes the Content-Length header to support the
 *  use of persistent HTTP connections unless explicitly
 *  instructed not to through "usePersistence=no".
 *  Used by the PersistentConnection servlet.
 *  <P>
 *  Do <I>not</I> install this servlet permanently on
 *  a public server, as it provides access to image
 *  files that are not necessarily in the Web
 *  server path.
 *  <P>
 *  Taken from Core Servlets and JavaServer Pages
 *  from Prentice Hall and Sun Microsystems Press,
 *  http://www.coreservlets.com/.
 *  &copy; 2000 Marty Hall; may be freely used or adapted.
 */

 /*

 // THIS MIGHT WORK!
 String gifLocation = "images/window.jpg";

    if ((gifLocation == null) ||
        (gifLocation.length() == 0)) {
      return;
    }

    String file = getServletContext().getRealPath(gifLocation);

    try {

      BufferedInputStream in =
        new BufferedInputStream(new FileInputStream(file));
      ByteArrayOutputStream byteStream =
        new ByteArrayOutputStream(512);
      int imageByte;
      while((imageByte = in.read()) != -1) {
        byteStream.write(imageByte);
      }
      in.close();
      String persistenceFlag =
      request.getParameter("usePersistence");
      boolean usePersistence =
        ((persistenceFlag == null) ||
         (!persistenceFlag.equals("no")));


      response.setContentType("image/gif");

      if (usePersistence) {
        response.setContentLength(byteStream.size());
      } 
      byteStream.writeTo(response.getOutputStream());
      response.sendRedirect("window");


    } catch(IOException ioe) {
    }
*/

%>

</body>
</html>