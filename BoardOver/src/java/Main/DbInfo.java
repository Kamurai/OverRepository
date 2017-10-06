/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Kamurai
 */
public class DbInfo 
{
    private String driver;
    public String getDriver()
    {
        return driver;
    }
    private String url;
    public String getUrl()
    {
        return url;
    }
    private String dbName;
    public String getDbName()
    {
        return dbName;
    }
    private String dbUsername;
    public String getDbUsername()
    {
        return dbUsername;
    }
    private String dbPassword;
    public String getDbPassword()
    {
        return dbPassword;
    }
    private Connection connect;
    public Connection getConnect()
    {
        return connect;
    }
    
    public DbInfo()
    {
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        url = "jdbc:sqlserver://localhost\\SQLSERVER";
        dbName = ";DatabaseName=Over";
        dbUsername = "SA";
        dbPassword = "yellow23";
        connect = null;
    }
    
    public Connection openConnection()
    {
        try
        {
            Class.forName(driver);
        }
        catch (ClassNotFoundException e)
        {
                System.out.println("Could not load the driver");
        }
        
        try
        {
            connect = DriverManager.getConnection((url+dbName), dbUsername, dbPassword);
        }
        catch(Exception lex)
        {
            lex.printStackTrace();
        }
        
        return connect;
    }
    
    public void closeConnection()
    {
        if(connect != null)
        {
            try
            {
               connect.close();
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
    
    public void closeConnection(Connection connect)
    {
        if(connect != null)
        {
            try
            {
               connect.close();
            }
            catch (Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
    
    public ResultSet executeStatement(String query)
    {
        ResultSet rs;
        
        try
        {
            Statement stmt = connect.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(query);
        }
        catch( Exception ex )
        {
            ex.printStackTrace();
            return null;
        }
        return rs;
    }
    
    
}
