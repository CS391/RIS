<html>
<head>
<title>User Settings</title>
</head>
<body>

<!--This is the User Settings page-->
<H1><CENTER>User Settings</CENTER></H1>

<FORM NAME="UserSettingsForm" ACTION="loggedin.jsp" METHOD="post" >
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Userid:</I></B></TD>
<TD><INPUT TYPE="text" NAME="USERID" VALUE="userid"><BR></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Old Password:</I></B></TD>
<TD><INPUT TYPE="password" NAME="OLDPASSWD" VALUE="oldpassword"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>New Password:</I></B></TD>
<TD><INPUT TYPE="password" NAME="NEWPASSWD" VALUE="newpassword"></TD>
</TR>
<TR><TD></TD></TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>First name:</I></B></TD>
<TD><INPUT TYPE="text" NAME="FNAME" VALUE="fname"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Last name:</I></B></TD>
<TD><INPUT TYPE="text" NAME="LNAME" VALUE="lname"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Address:</I></B></TD>
<TD><INPUT TYPE="text" NAME="ADDRESS" VALUE="address"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Email:</I></B></TD>
<TD><INPUT TYPE="text" NAME="EMAIL" VALUE="email"></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Phone number:</I></B></TD>
<TD><INPUT TYPE="text" NAME="PHONE" VALUE="phone"></TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="UPDATE" VALUE="Update">
<INPUT TYPE="submit" NAME="CANCEL" VALUE="Cancel">
</FORM>

<HR>


</body>
</html>