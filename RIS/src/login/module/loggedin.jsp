	<HTML>
	<HEAD>
	<TITLE>Your Login Result</TITLE>
	</HEAD>
	<BODY>
	<%@ page import="java.sql.*" %>
	<% 
	
	final String DB_USER_NAME="jletourn";
	final String DB_PASSWORD="JL3492916";

	if(request.getParameter("Submit") != null){
		//get the user input from the login page
		String userName = (request.getParameter("USERID")).trim();
		String passwd = (request.getParameter("PASSWD")).trim();

		//establish the connection to the underlying database

		Connection conn = null;
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";

		try{
			//load and register the driver
			Class drvClass = Class.forName(driverName); 
			DriverManager.registerDriver((Driver) drvClass.newInstance());
		}

		catch(Exception ex){
			out.println("<hr>Database Driver did not load.<hr>");
		}

		try{
			//establish the connection 
			conn = DriverManager.getConnection(dbstring,DB_USER_NAME,DB_PASSWORD);
			conn.setAutoCommit(false);
		}

		catch(Exception ex){
			out.println("<hr>Error connecting to the database<hr>");

		}

		//select the user table from the underlying db and validate the user name and password

		try{
			PreparedStatement prepUserName = conn.prepareStatement("SELECT * FROM USERS WHERE USER_NAME = ? AND PASSWORD = ?");
			prepUserName.setString(1,userName);
			prepUserName.setString(2,passwd);
			ResultSet userSet = prepUserName.executeQuery();
			
			String truepwd = "";
			
			if(userSet.next()){
			truepwd = userSet.getString(2);
			}


			//display the result
			if(passwd.equals(truepwd))
				out.println("<p><b>Your Login is Successful!</b></p>");

			else
				out.println("<p><b>Either your userName or Your password is inValid!</b></p>");
		}

		catch(Exception ex){
			out.println("<hr>Error processing your login.<hr>");

		}

		try{
			conn.close();
		}

		catch(Exception ex){
			out.println("<hr>Error closing the connection to the database<hr>");
		}

	}
	else
	{
		out.println("<form method=post action=login.jsp>");
		out.println("UserName: <input type=text name=USERID maxlength=20><br>");
		out.println("Password: <input type=password name=PASSWD maxlength=20><br>");
		out.println("<input type=submit name=Submit value=Submit>");
		out.println("</form>");
	} 

	%>

	</BODY>

	</HTML>

