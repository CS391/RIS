cp ~/git/RIS/RIS/src/ ~/catalina/webapps/391Project/
starttomcat &
#test if tomcat is running
var1=http://
var2=$(uname --nodename)
var3=.cs.ualberta.ca:8080/391Project/src/login/module/login.html
#echo $var1$var2$var3
sleep 3
firefox $var1$var2$var3
#get website as argument to firefox
