<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>Update Information</title>
</head>
<body>
<%@ page import="java.sql.*"%>
<%
//check if user is logged in
if(request.getParameter("UPDATE") != null)
{
	
	//connect to the database
	Connection conn = connect.connect.dbConnect ();

	//select the user table from the underlying db and validate the user name and password
	try
	{
		//get the filled in parameters from the userSettings page
		String userName = (request.getParameter("USERNAME")).trim();
		String passwd = (request.getParameter("OLDPASSWD")).trim();
		String updatePassword = (request.getParameter("NEWPASSWD")).trim();
		String updateRPassword = (request.getParameter("RNEWPASSWD")).trim();
		String updateFirstName = (request.getParameter("FNAME")).trim();
		String updateLastName = (request.getParameter("LNAME")).trim();
		String updateAddress = (request.getParameter("ADDRESS")).trim();
		String updateEmail = (request.getParameter("EMAIL")).trim();
		String updatePhone = (request.getParameter("PHONE")).trim();
		
		//get the users password from the database
		PreparedStatement prepUserName = conn.prepareStatement("SELECT * FROM USERS WHERE USER_NAME = ?");
		prepUserName.setString(1,userName);
		ResultSet userPass = prepUserName.executeQuery();
		
		String truepwd = "";
		
		//set the user password to check later
		if(userPass.next())
		{
		truepwd = userPass.getString(2);
		}
		
		int update1=0;
		int update2=0;
		if(passwd.equals(truepwd))
		{
			Statement stmt = null;
			ResultSet rset = null;
			String check = "select * from persons where user_name =" + "'" + userName + "'";
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (check);
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}
			String sql = null;
			
			if(!rset.next())
			{
			sql = "insert into persons values(\'" + userName + "\', " +
				"\'" + updateFirstName + "\', " +
				"\'" + updateLastName + "\', " +
				"\'" + updateAddress + "\', " +
				"\'" + updateEmail + "\', " + 
				"'" + updatePhone + "\')";
			Cookie cookieFirstName = new Cookie("first_name", updateFirstName);
			Cookie cookieLastName = new Cookie("last_name", updateLastName);
			Cookie cookieAddress = new Cookie("address", updateAddress);
			Cookie cookieEmail = new Cookie("email", updateEmail);
			Cookie cookiePhone = new Cookie("phone", updatePhone);
			response.addCookie(cookieFirstName);
			response.addCookie(cookieLastName);
			response.addCookie(cookieAddress);
			response.addCookie(cookieEmail);
			response.addCookie(cookiePhone);
			try
			{
				stmt = conn.createStatement ();
				rset = stmt.executeQuery (sql);
				conn.commit();
				out.println("Your information has been added.")
			}
			catch (Exception ex)
			{
				out.println ("<hr>" + ex.getMessage () + "<hr>");
			}			
			}
			else
			{
	
		//update the persons table with the given information
		PreparedStatement UpdateInfo = conn.prepareStatement("UPDATE PERSONS SET FIRST_NAME= ?," +
				"LAST_NAME= ?, ADDRESS= ?, EMAIL= ?, PHONE= ? WHERE USER_NAME = ?");
		UpdateInfo.setString(1,updateFirstName);
		UpdateInfo.setString(2,updateLastName);
		UpdateInfo.setString(3,updateAddress);
		UpdateInfo.setString(4,updateEmail);
		UpdateInfo.setString(5,updatePhone);
		UpdateInfo.setString(6,userName);
		update1 = UpdateInfo.executeUpdate();
		
		PreparedStatement UpdatePass=null;
		//if changed password is empty do not allow to update
		if(!updatePassword.isEmpty())
		{
			//check that the two changed passwords are equal
			if(updatePassword.equals(updateRPassword))
			{
			UpdatePass = conn.prepareStatement("UPDATE USERS SET PASSWORD= ? WHERE USER_NAME = ?");
			UpdatePass.setString(1,updatePassword);
			UpdatePass.setString(2,userName);
			update2 = UpdatePass.executeUpdate();
			}
			else
			{
				out.println("<hr>Your Passwords did not match!</hr>");
			}
		}
		//if nothing was executed to the database do not commit
		if(update1 != 0 || update2 !=0)
		{
		conn.commit();
		out.println("<hr>Your Information has been changed. Thank You!</hr>");
		}
		else
		{
			out.println("<hr> Error processing your information</hr>");
		}
	}
		}
	else
	{
		out.println("<hr>Wrong Password! Your Information has not been changed.</hr>");
	}
}
	catch(Exception ex)
	{
		out.println("<hr>Error processing your querry</hr>");
	}
}
%>
</body>
</html>