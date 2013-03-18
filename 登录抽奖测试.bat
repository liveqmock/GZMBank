e:
cd \workspace\GZMBank\WebRoot\WEB-INF\classes
set LIB_HOME=.\extjar
set LIB_COLLECTIONS=.;%E:\workspace\khcx_background\extjar\jconn3d.jar
java -classpath %LIB_COLLECTIONS% com/gdbocom/test/InsertLOTTRecord %1
cd \workspace\GZMBank\WebRoot
