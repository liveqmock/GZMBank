set LIB_HOME=..\lib
set LIB_COLLECTIONS=.;%LIB_HOME%\jconn3d.jar;%LIB_HOME%\commons-net-2.0.jar;

java -classpath %LIB_COLLECTIONS% com/gdbocom/report/CommonReport DrawReport.ini
