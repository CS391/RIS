<%@ include file="/src/header/module/header.jsp" %>
<html>
<head>
<title>Help Section</title>
</head>
<body>
	<H1>
		<CENTER>Help Section</CENTER>
	</H1>

<B>Home Page</B>
<br>
<p>The home page has no real functionality but is used as a hub to the other pages. Once logged in the user is directed to the home page
where they are welcomed and told of the use of the Radiology Information System. From here they can access the other modules to
do the real work. If the user accesses the home page and is not logged in they are told that they can log in by clicking the 
login button at the top right of the header.</p>
<br>
<B>Login Module</B>
<br>
<p>The login module is a simple interface used to gain access to the Radiology Information System.
The user must be stored in the database and will only gain access to the system if they input the
correct password. This module is linked to the User Management module because the administrator has the ability
to add users and change their passwords. When a user logs in they have a specified class, they can be either
administrators, doctors, patients, or radiologists. They will only be granted access to certain functionalities 
of the site based on their class. The administrator has the ability to use the Uploading, User Management, Report Generating,
Search, Data Analysis and User Settings functionality. The doctors and patients will only have access to the Search,
and User Settings modules. Radiologists can access the Uploading, Search, and User Settings modules.</p>
<br>
<p>When the user logs in and provides a user name that is not in the database, or a password that does not match the user
they will be redirected back to the login page where a message will display that the wrong login information was 
provided.</p>
<br>
<p>
User Settings is accessible to every user. In this section of login module the user can change their password and
all of the personal information that was inputed when the user was created. When changing the password the user must
input the new password, and re-enter it to make sure they match and that is the password that they want. If the passwords
and their old password is correct the password will be changed. Also when the user changes his or her personal
information the password is checked to ensure another level of security.</p>
<br>
<p>Each module has a check before it displays the page that will check the class of the logged in user and will not
grant access to the page if they do not have the correct class. This module is to provide security as well as restrict
accessibility to the people that should be able to use the system.</p>
<br>
<B>Data Analysis</B>
<br>
<p>The Data Analysis module is used to produce an OLAP report that will tell the Administrators of the system needed 
information. Only administrators have access to this module. When the administrator clicks the Data Analysis button at 
the top of the page in the header they will be asked on what information they want to query. They have the choice of 
three parameters, they can query based on patient name and time, or test type patient name and time. When the test type
radio button is selected a drop down menu will appear so a patient can be selected. Once the information is submitted a
report is generated.</p>
<br>
<p>The reports will display the number of records of each type of test each patient has had based on the time specified. If year
is specified the report will be broken down by year. This also follows with week and month. The week and month are displayed
based on the number of any particular year. For example Dec 31 will be the 12th month and 52 week (except for leap year where
it is 53rd). The report is displayed in an easy to understand table that can be printed off using your browsers print function.</p>
<br>
<p>If the user decides to generate the report based on test type, they must select a patient to query on. The report generated will
follow the same format with regards to time as described above. However, now only the information of the selected user will be
displayed for the administrators use.</p>
<br>
<B>Search</B>
<br>
<p>The search module is used by the user to view their own records and test results. The administrator will be able to search over all
patients but any other user will only be able to view their own. The search page has a simple interface that allows the user to 
query the tables based on key words and restrict the results based on time. The time field is not required to display the results.
The results are displayed in an easy to read table that has sorting functionality. If the user wants to sort the results base on date they
can click on the date header and it will sort, click again and it will reverse the order. The default sort is based on rank which
displays the most relevant result first.</p>
<br>
<B>Report Generating</B>
<br>
<p> The report generating module is used by administrators to generate a report of all the patients with a certain condition based on a 
time period. The time fields are necessary to narrow down the results that are returned. If the user was to view a report of patients
diagnosed with cancer from 2001 to 2010 then they can input this into the query fields and press submit and a report will be generated
in a table format that is easy to read.</p>
<br>
<B>User Management</B>
<br>
<p> The User Management module is used by the administrator to view and edit the information of a user on the Radiology Information System.
The administrator can change the users password, class, and all of the personal information. The most important part of the user management
module is that the family doctor can be inserted or updated. This module has a very straight forward interface, just input the information
and press submit.</p>
<br>
<B>Uploading</B>
<p> The uploading module is used by radiologists and administrators to upload radiology records and images from the tests that have
been performed. To use this module press on the upload button at the top of the page. This fill out the form with the patient information
and diagnosis. To use the time fields just click on select and a calendar will pop up, select the date that you want and press submit. Once
the information is submitted the user will be asked to upload the image. Press browse and select the image to upload. Then input the file
name and press submit. The image will then be saved in the system.</p>
</body>
</html>