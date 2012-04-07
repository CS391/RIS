echo "Copying files . . ."
cp -r RIS/ ~/catalina/webapps/
cd ~/catalina/webapps/RIS/WEB-INF/classes/connect/
for f in *.java; do
	b=$(basename $f .java);
	javac $f;
	jar cf $b.jar $f;
	mv *.jar ~/catalina/webapps/RIS/WEB-INF/lib/;
done
echo "Starting tomcat . . ."
terminal -x starttomcat &
#test if tomcat is running
var1=http://
var2=$(uname --nodename)
var3=.cs.ualberta.ca:8080/RIS/src/login/module/DatabaseLogin.jsp
#echo $var1$var2$var3
sleep 4
echo "Starting firefox . . ."
firefox $var1$var2$var3 &
#get website as argument to firefox
