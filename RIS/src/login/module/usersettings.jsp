<%@ include file="/src/header/module/header.jsp"%>
<html>
<head>
<title>User Settings</title>
</head>
<body>
	<H1>
		<CENTER>User Settings</CENTER>
	</H1>

	<%
	//get all the cookies and assign them to strings
	classname =  (String)session.getAttribute("class");
	String user_name = "";
	String first_name = "";
	String last_name = "";
	String address = "";
	String email = "";
	String phone = "";
	
	if(classname != null)
	{
	user_name = (String)session.getAttribute("user_name");
	if(getcookieFirstName!=null)
	{
	first_name = getcookieFirstName.getValue();
	}
	if(getcookieLastName!=null)
	{
	last_name = getcookieLastName.getValue();
	}
	if(getcookieAddress!=null)
	{
	address = getcookieAddress.getValue();
	}
	if(getcookieEmail!=null)
	{
	email = getcookieEmail.getValue();
	}
	if(getcookiePhone!=null)
	{
	phone = getcookiePhone.getValue();
	}
%>
	<P>To update your information input it into the correct fields and
		press update.</P>
	<P>You must input your current password for any changes to take
		effect. Only changed values will be updated</P>
	<FORM NAME="UserSettingsForm" ACTION="updateUserInfo.jsp" METHOD="post">
		<TABLE>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>New Password:</I> </B></TD>
				<TD><INPUT TYPE="password" NAME="NEWPASSWD" VALUE=""></TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Re-enter New Password:</I> </B></TD>
				<TD><INPUT TYPE="password" NAME="RNEWPASSWD" VALUE="">
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Current Password: 
				</B><B style="color: red;"> *</B></TD>
				<TD><INPUT TYPE="password" NAME="OLDPASSWD" VALUE=""></TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><INPUT TYPE="hidden" NAME="USERNAME" VALUE=<%=user_name %>><BR>
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>First name:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="FNAME" VALUE=<%=first_name%>>
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Last name:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="LNAME" VALUE=<%=last_name %>>
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Address:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="ADDRESS" VALUE="<%=address %>">
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Email:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="EMAIL" VALUE=<%=email %>>
				</TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Phone number:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="PHONE" VALUE=<%=phone %>>
				</TD>
			</TR>
		</TABLE>
		<INPUT TYPE="submit" NAME="UPDATE" VALUE="Update">
	</FORM>

	<P style="color: red;">* Required</P>
	<HR>
<%
	}
	//if not logged in show this to the user
	else{
	out.print("<hr>You must login first.<hr>");
	}
%>
</body>
</html>