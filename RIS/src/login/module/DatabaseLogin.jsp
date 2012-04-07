<%@ include file="/src/header/module/header.jsp"%>
<HTML>
<HEAD>
<TITLE>Database Connection</TITLE>
</HEAD>

<BODY>
<CENTER>
	<H1>Database Connection</H1>
</CENTER>

<FORM NAME="LoginForm" ACTION="Databaseloggedin.jsp" METHOD="post">
	<P>This is the login to connect to the database.</P>
	<TABLE>
		<TR VALIGN=TOP ALIGN=LEFT>
			<TD><B><I>CCID:</I>
			</B>
			</TD>
			<TD><INPUT TYPE="text" NAME="CCID" VALUE="userid"><BR>
			</TD>
		</TR>
		<TR VALIGN=TOP ALIGN=LEFT>
			<TD><B><I>Password:</I>
			</B>
			</TD>
			<TD><INPUT TYPE="password" NAME="PASS" VALUE="password">
			</TD>
		</TR>
	</TABLE>
	<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
</FORM>
<HR>
</BODY>
</HTML>
