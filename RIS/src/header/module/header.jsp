<%-- Header file --%>
<HTML>

<BODY>
    <FORM NAME="Header" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="buttonName">
        
        <%
        Cookie cookies[] = request.getCookies();
        Cookie getcookieUserName = null;
        Cookie getcookiePassword = null;
        Cookie getcookieFirstName = null;
        Cookie getcookieLastName = null;
        Cookie getcookieClass = null;
        Cookie getcookieAddress = null;
        Cookie getcookieEmail = null;
        Cookie getcookiePhone = null;
        if(cookies != null){
        for(int i=0; i < cookies.length; i++){
        	
        	if(cookies[i].getName().equals("user_name")){
        		getcookieUserName = cookies[i];
        	}
        	if(cookies[i].getName().equals("password")){
        		getcookiePassword = cookies[i];
        	}
        	if(cookies[i].getName().equals("first_name")){
        		getcookieFirstName = cookies[i];
        	}
        	if(cookies[i].getName().equals("last_name")){
        		getcookieLastName = cookies[i];
        	}
        	if(cookies[i].getName().equals("class")){
        		getcookieClass = cookies[i];
        	}
        	if(cookies[i].getName().equals("address")){
        		getcookieAddress = cookies[i];
        	}
        	if(cookies[i].getName().equals("email")){
        		getcookieEmail = cookies[i];
        	}
        	if(cookies[i].getName().equals("phone")){
        		getcookiePhone = cookies[i];
        	}
        }
        }
        String classname =  (String) session.getAttribute("class");
        if(classname == null){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Management\" ONCLICK=\"UM_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Report Generating\" ONCLICK=\"Report_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Uploading\" ONCLICK=\"Uploading_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Data Analysis\" ONCLICK=\"DA_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Login\" ONCLICK=\"Login_button()\">");
        }
        else if(classname.equals("a")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Management\" ONCLICK=\"UM_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Report Generating\" ONCLICK=\"Report_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Data Analysis\" ONCLICK=\"DA_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");
        }
        else if(classname.equals("p")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");
        }
        else if(classname.equals("d")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");
        }
        else if(classname.equals("r")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Uploading\" ONCLICK=\"Uploading_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");
        }
        	
        	%>
    
    </FORM>
    <SCRIPT LANGUAGE="JavaScript">
        function Login_button()
        {
        	parent.location='/391Project/src/login/module/login.jsp'
        }    
        function UM_button()
        {
        	parent.location='/391Project/src/userManagement/module/userManagement.jsp'
        }    
        function Report_button()
        {
        	parent.location='/391Project/src/reportGenerating/module/reportGenerating.jsp'
        }    
        function Uploading_button()
        {
        	parent.location='/391Project/src/uploading/module/uploading.jsp'
        }    
        function Search_button()
        {
        	parent.location='/391Project/src/search/module/search.jsp'
        }    
        function DA_button()
        {
        	parent.location='/391Project/src/dataAnalysis/module/dataAnalysis.jsp'
        }
        function Home_button()
        {
        	parent.location='/391Project/'
        }
        function US_button()
        {
        	parent.location='/391Project/src/login/module/usersettings.jsp'
        }
        function LogOut_button()
        {
        	parent.location='/391Project/src/login/module/logout.jsp'
        }   
    </SCRIPT>
</BODY>

</HTML>
