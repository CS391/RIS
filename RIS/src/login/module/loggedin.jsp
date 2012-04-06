	<%@ include file="/src/header/module/header.jsp" %>
	<HTML>
	<HEAD>
	<TITLE>Your Login Result</TITLE>
	</HEAD>
	<BODY>
	<%@ page import="java.sql.*" %>
	<% 
	

	if(request.getParameter("Submit") != null){
		//get the user input from the login page
		String userName = (request.getParameter("USERID")).trim();
		String passwd = (request.getParameter("PASSWD")).trim();

		//connect to the database
		Connection conn = connect.connect.dbConnect ();

		//select the user table from the underlying db and validate the user name and password

		try{
			//get a result set of all users in the system
			PreparedStatement prepUserName = conn.prepareStatement("SELECT * FROM USERS WHERE USER_NAME = ?");
			prepUserName.setString(1,userName);
			ResultSet userPass = prepUserName.executeQuery();
			
			String truepwd = "";
			classname = "";
			
			//set the required variables from the user table and add them as cookies
			if(userPass.next()){
			truepwd = userPass.getString(2);
			classname = userPass.getString(3);
			Cookie cookiePassword = new Cookie("password", truepwd);
			response.addCookie(cookiePassword);
			}
			
			//get a result set of all people in the persons table with the given username
			PreparedStatement prepUser = conn.prepareStatement("SELECT * FROM PERSONS WHERE USER_NAME = ?");
			prepUser.setString(1,userName);
			ResultSet userSet = prepUser.executeQuery();

			//set the required variables from the persons table and add them as cookies
			while(userSet.next()){
							
			Cookie cookieFirstName = new Cookie("first_name", userSet.getString(2));
			Cookie cookieLastName = new Cookie("last_name", userSet.getString(3));
			Cookie cookieAddress = new Cookie("address", userSet.getString(4));
			Cookie cookieEmail = new Cookie("email", userSet.getString(5));
			Cookie cookiePhone = new Cookie("phone", userSet.getString(6));
			response.addCookie(cookieFirstName);
			response.addCookie(cookieLastName);
			response.addCookie(cookieAddress);
			response.addCookie(cookieEmail);
			response.addCookie(cookiePhone);
			}
			
			//check if the password is correct for the given user
			if(passwd.equals(truepwd)){
				session.setAttribute("class", classname);
				session.setAttribute("user_name", userName);
				response.sendRedirect("/391Project/");  //go to the home page
			}
			
			//if the password is wrong
			else
			response.sendRedirect("/391Project/src/login/module/login.jsp"); //go to the login module again
			session.setAttribute("wrongPass", "true");//used to display a "wrong password" message
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

