<%-- Header file --%>
<HTML>

<BODY>
    <FORM NAME="Header" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="buttonName">
        
        <INPUT TYPE="BUTTON" VALUE="User Management" ONCLICK="button2()">
        <INPUT TYPE="BUTTON" VALUE="Report Generating" ONCLICK="button3()">
        <INPUT TYPE="BUTTON" VALUE="Uploading" ONCLICK="button4()">
        <INPUT TYPE="BUTTON" VALUE="Search" ONCLICK="button5()">
        <INPUT TYPE="BUTTON" VALUE="Data Analysis" ONCLICK="button6()">
        <INPUT TYPE="BUTTON" VALUE="User Settings" ONCLICK="button7()">
        
        <%-- TODO: Check if user is logged in and replace with logout --%>
        <INPUT TYPE="BUTTON" VALUE="Login" ONCLICK="button1()">
    </FORM>
    <SCRIPT LANGUAGE="JavaScript">
        function button1()
        {
        	parent.location='/391Project/src/login/module/login.jsp'
        }    
        function button2()
        {
        	parent.location='/391Project/src/userManagement/module/userManagement.jsp'
        }    
        function button3()
        {
        	parent.location='/391Project/src/reportGenerating/module/reportGenerating.jsp'
        }    
        function button4()
        {
        	parent.location='/391Project/src/uploading/module/uploading.jsp'
        }    
        function button5()
        {
        	parent.location='/391Project/src/search/module/search.jsp'
        }    
        function button6()
        {
        	parent.location='/391Project/src/dataAnalysis/module/dataAnalysis.jsp'
        }
        function button7()
        {
        	parent.location='/391Project/src/login/module/usersettings.jsp'
        }
    </SCRIPT>
</BODY>

</HTML>