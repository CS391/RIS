echo "Copying files . . ."
cp -r ~/git/RIS/RIS/src/ ~/catalina/webapps/391Project/
echo "Starting tomcat . . ."
terminal -x starttomcat &
#test if tomcat is running
var1=http://
var2=$(uname --nodename)
var3=.cs.ualberta.ca:8080/391Project/src/login/module/login.jsp
#echo $var1$var2$var3
sleep 3
echo "Starting firefox . . ."
firefox $var1$var2$var3
#get website as argument to firefox
