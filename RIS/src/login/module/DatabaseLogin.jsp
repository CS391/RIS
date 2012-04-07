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
<%

	//if the password was wrong display to the user the wrong password or userId was used
	String wrongPass = (String) session.getAttribute("wrongDBPass");
	if(wrongPass != null)
	{
		if(wrongPass.equals("true"))
		{
		out.println("<B style=\"color:red;\"><I>Wrong Password or User Id</I></B>");
		session.removeAttribute("wrongDBPass");
		}
	}
%>
			<TD><B><I>CCID:</I>
			</B>
			</TD>
			<TD><INPUT TYPE="text" NAME="CCID" ID="CCID"><BR>
			</TD>
		</TR>
		<TR VALIGN=TOP ALIGN=LEFT>
			<TD><B><I>Password:</I>
			</B>
			</TD>
			<TD><INPUT TYPE="password" NAME="PASS">
			</TD>
		</TR>
	</TABLE>
	<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
</FORM>

<script
	type="text/javascript"
	language="javascript">
	document.getElementById("CCID").focus();
</script>

<HR>
</BODY>
</HTML>
