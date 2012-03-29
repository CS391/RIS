<%@ include file="/src/header/module/header.jsp" %>

<html>
<head>
<title>Upload Radiology Picture</title>
</head>
<body>


<%

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

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

public class PictureFromFile extends HttpServlet {

  public void doGet(HttpServletRequest request,
                    HttpServletResponse response)
      throws ServletException, IOException {

    String gifLocation = "images/window.jpg";

    if ((gifLocation == null) ||
        (gifLocation.length() == 0)) {
      reportError(response, "Image File Not Specified");
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
      reportError(response, "Error: " + ioe);
    }
  }

  public void reportError(HttpServletResponse response,
                          String message)
      throws IOException {
    response.sendError(response.SC_NOT_FOUND,
                       message);
  }
}
%>

</body>
</html>