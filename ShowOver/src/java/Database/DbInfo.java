/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

/**
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
    
    public DbInfo()
    {
        driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        url = "jdbc:sqlserver://localhost";
        dbName = ";DatabaseName=Over";
        dbUsername = "publicAccess";
        dbPassword = "yellow23";
    }
}
