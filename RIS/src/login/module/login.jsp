<%@ include file="/src/header/module/header.jsp"%>
<HTML>
<HEAD>
<TITLE>Radiology Information System</TITLE>
</HEAD>
<BODY>
	<CENTER>
		<H1>Radiology Information System</H1>
	</CENTER>
	<FORM NAME="LoginForm" ACTION="loggedin.jsp" METHOD="post">
		<P>To login successfully, you need to submit a valid user-id and
			password</P>
		<TABLE>
			<TR VALIGN=TOP ALIGN=LEFT>
<%	
	//if the password was wrong display to the user the wrong password or userId was used
	String wrongPass = (String) session.getAttribute("wrongPass");
	if(wrongPass != null)
	{
		if(wrongPass.equals("true"))
		{
		out.println("<B style=\"color:red;\"><I>Wrong Password or User Id</I></B>");
		session.removeAttribute("wrongPass");
		}
	}
%>
				<TD><B><I>Userid:</I> </B></TD>
				<TD><INPUT TYPE="text" NAME="USERID" ID="USERID" VALUE="Admin"><BR></TD>
			</TR>
			<TR VALIGN=TOP ALIGN=LEFT>
				<TD><B><I>Password:</I> </B></TD>
				<TD><INPUT TYPE="password" NAME="PASSWD" VALUE="admin"></TD>
			</TR>
		</TABLE>

		<INPUT TYPE="submit" NAME="Submit" VALUE="LOGIN">
	</FORM>
<script
	type="text/javascript"
	language="javascript">
	document.getElementById("USERID").focus();
</script>
	<HR>
</BODY>
</HTML>
