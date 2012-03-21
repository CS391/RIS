<%@ include file="/src/header/module/header.jsp" %>
<HTML>
<HEAD>
<TITLE>Radiology Information System</TITLE>
</HEAD>

<BODY>
<!--This is the login page-->
<CENTER><H1>Radiology Information System</H1></CENTER>

<FORM NAME="LoginForm" ACTION="loggedin.jsp" METHOD="post" >

<P>To login successfully, you need to submit a valid user-id and password</P>
<TABLE>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Userid:</I></B></TD>
<TD><INPUT TYPE="text" NAME="USERID" VALUE="userid"><BR></TD>
</TR>
<TR VALIGN=TOP ALIGN=LEFT>
<TD><B><I>Password:</I></B></TD>
<TD><INPUT TYPE="password" NAME="PASSWD" VALUE="password"></TD>
</TR>
</TABLE>

<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
</FORM>

<HR>
</BODY>
</HTML>
