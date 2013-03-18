package com.gdbocom.util;

import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.NamingException;


public class ConnPool {

	public Connection getConn() throws NamingException, SQLException{
		
		Context initCtx = new javax.naming.InitialContext();
		DataSource ds = (DataSource)initCtx.lookup("MidServPoolDs");
		return ds.getConnection();

	}
}
