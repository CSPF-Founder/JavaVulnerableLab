/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.cysecurity.cspf.jvl.model;

 
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author breakthesec
 */
public class DBConnect {
    public Connection connect(String path) throws IOException,ClassNotFoundException,SQLException
    {
        Properties properties=new Properties();
        properties.load(new FileInputStream(path));
        String dbuser=properties.getProperty("dbuser");
         String dbpass = properties.getProperty("dbpass");
       String dbfullurl = properties.getProperty("dburl")+properties.getProperty("dbname");
       String jdbcdriver = properties.getProperty("jdbcdriver");
            Connection con=null;
          try
                   {
                    Class.forName(jdbcdriver);
                    con= DriverManager.getConnection(dbfullurl,dbuser,dbpass);
                    return con;
                   }
                   finally
                    {
                                 
                    }      
    }
}