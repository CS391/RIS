<%-- Header file --%>
<HTML>

<BODY>
    <FORM NAME="Header" METHOD="POST">
        <INPUT TYPE="HIDDEN" NAME="buttonName">
        
        <%
        //get all the cookies set in the log in
        Cookie cookies[] = request.getCookies();
        Cookie getcookiePassword = null;
        Cookie getcookieFirstName = null;
        Cookie getcookieLastName = null;
        Cookie getcookieClass = null;
        Cookie getcookieAddress = null;
        Cookie getcookieEmail = null;
        Cookie getcookiePhone = null;
        if(cookies != null){
        	//assign the cookies to their appropriate variables
        for(int i=0; i < cookies.length; i++){
        	
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
        //get the class that the user is logged in as
        String classname =  (String) session.getAttribute("class");
        //class will be null if not logged in
        if(classname == null){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Login\" ONCLICK=\"Login_button()\">");//value is login when not logged in
        }
        //display the buttons that the administrator class can access
        else if(classname.equals("a")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Management\" ONCLICK=\"UM_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Report Generating\" ONCLICK=\"Report_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Data Analysis\" ONCLICK=\"DA_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");//value is logout when logged in
        }
        //diplay the buttons that the patient class can access
        else if(classname.equals("p")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");//value is logout when logged in
        }
        //display the buttons that the doctor class can access
        else if(classname.equals("d")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");//value is logout when logged in
        }
        //display the buttons that the radiologist class can access
        else if(classname.equals("r")){
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Home\" ONCLICK=\"Home_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Uploading\" ONCLICK=\"Uploading_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"Search\" ONCLICK=\"Search_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"User Settings\" ONCLICK=\"US_button()\">");
        	out.println("<INPUT TYPE=\"BUTTON\" VALUE=\"LogOut\" ONCLICK=\"LogOut_button()\">");//value is logout when logged in
        }
        	
        	%>
    
    </FORM>
    <SCRIPT LANGUAGE="JavaScript">
        function Login_button()
        {
        	parent.location='/RIS/src/login/module/login.jsp'
        }    
        function UM_button()
        {
        	parent.location='/RIS/src/userManagement/module/userManagement.jsp'
        }    
        function Report_button()
        {
        	parent.location='/RIS/src/reportGenerating/module/reportGenerating.jsp'
        }    
        function Uploading_button()
        {
        	parent.location='/RIS/src/uploading/module/uploading.jsp'
        }    
        function Search_button()
        {
        	parent.location='/RIS/src/search/module/search.jsp'
        }    
        function DA_button()
        {
        	parent.location='/RIS/src/dataAnalysis/module/dataAnalysis.jsp'
        }
        function Home_button()
        {
        	parent.location='/RIS/'
        }
        function US_button()
        {
        	parent.location='/RIS/src/login/module/usersettings.jsp'
        }
        function LogOut_button()
        {
        	parent.location='/RIS/src/login/module/logout.jsp'
        }   
    </SCRIPT>
</BODY>

</HTML>
