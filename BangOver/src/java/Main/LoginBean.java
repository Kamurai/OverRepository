/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

import java.io.*;
import javax.faces.bean.ManagedBean;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.faces.bean.SessionScoped;
import javax.annotation.PreDestroy;

/**
 * @author Kamurai
 */
@ManagedBean(name="LoginBean")
@SessionScoped
public class LoginBean implements Serializable
{
    private Connection connect;
    private DbInfo dbi;
    private Validator validate;
    
    private User DefaultUser;
    public User getDefaultUser()
    {
        return DefaultUser;
    }
    public void setDefaultUser(User input)
    {
        DefaultUser = input;
    }
    private User CurrentUser;
    public User getCurrentUser()
    {
        return CurrentUser;
    }
    public void setCurrentUser(User input)
    {
        CurrentUser = input;
    }
    
    private String username;
    public String getUsername()
    {
        return username;
    }
    public void setUsername(String input)
    {
        username = input;
    }
    private String password;
    public String getPassword()
    {
        return password;
    }
    public void setPassword(String input)
    {
        password = input;
    }
    private String confirmPassword;
    public String getconfirmPassword()
    {
        return confirmPassword;
    }
    public void setconfirmPassword(String input)
    {
        confirmPassword = input;
    }
    private String email;
    public String getEmail()
    {
        return email;
    }
    public void setEmail(String input)
    {
        email = input;
    }
    private String error;
    public String getError()
    {
        return error;
    }
    public void setError(String input)
    {
        error = input;
    }
    
    private boolean boolWomen;
    public boolean getboolWomen()
    {
        return boolWomen;
    }
    public void setboolWomen(boolean input)
    {
        boolWomen = input;
    }
    private boolean boolMen;
    public boolean getboolMen()
    {
        return boolMen;
    }
    public void setboolMen(boolean input)
    {
        boolMen = input;
    }
    private boolean boolTransWomen;
    public boolean getboolTransWomen()
    {
        return boolTransWomen;
    }
    public void setboolTransWomen(boolean input)
    {
        boolTransWomen = input;
    }
    private boolean boolTransMen;
    public boolean getboolTransMen()
    {
        return boolTransMen;
    }
    public void setboolTransMen(boolean input)
    {
        boolTransMen = input;
    }
    
    
    public LoginBean()
    {
        connect = null;
        dbi = new DbInfo();
        validate = new Validator();

        DefaultUser = new User(
        -1,
        "",
        "",
        0,
        false,
        false,
        false,
        false,
        false
        );
        CurrentUser = new User(DefaultUser);
        
        //SignUp Page variables
        username = "";
        password = "";
        confirmPassword = "";
        email = "";
        error = "";
        
        boolWomen = false;
        boolMen = false;
        boolTransWomen = false;
        boolTransMen = false;
        
    }
    
    public String LogIn(String targetPage)
    {
        String Result = "Login";
        int rows = -1;
        
        try
        {
            //validate given username
                //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            return Result;
        }
        
        if(connect == null)
        {
            return Result;
        }
        
        String sqlQuery = "BangOverGetValidUser " + username + ", " + password;
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        
        try
        {
            rs.next();
            rows = rs.getRow();
            
            CurrentUser = new User(
                rs.getInt("Indext"), 
                rs.getString("Username"), 
                rs.getString("Email"), 
                rs.getInt("AdminLevel"),
                rs.getBoolean("Women"), 
                rs.getBoolean("Men"), 
                rs.getBoolean("TransWomen"), 
                rs.getBoolean("TransMen"), 
                rs.getBoolean("LoggedOn") 
            );
            
            //close connection
            dbi.closeConnection();
        }
        catch(Exception ex)
        {
            //close connection
            dbi.closeConnection();
        
            return Result;
        }

        //if valid
        if(rows < 1)
        {
            return Result;
        }
        //else
        else
        {    
            //Update Username
            setOnline(CurrentUser.getUsername());
        }
        
        Result = targetPage;
        
        return Result;
                
    }
    
    public String LogOut()
    {
        String Result = "Login";
        int rows = -1;
        
        //Update Username
        setOffline(CurrentUser.getUsername());
        
        //reset variables
        CurrentUser = new User(DefaultUser);
        
        return Result;
    }
    
    @PreDestroy
    public void preDestroyLogOut()
    {
        setOffline(CurrentUser.getUsername());
    }
    
    public void setOnline(String user)
    {
        String sqlQuery = "BangOverSetOnlineStatus 1, " + user;
        
        //set local
        CurrentUser.setLoggedOn(true);
        
        //open connection
        connect = dbi.openConnection();
        
        dbi.executeStatement(sqlQuery);
        
        //close connection
        dbi.closeConnection(connect);
        
    }
    
    public void setOffline(String user)
    {
        String sqlQuery = "BangOverSetOnlineStatus 0, " + user;
        
        //set local
        CurrentUser.setLoggedOn(false);
        
        //open connection
        connect = dbi.openConnection();
        
        dbi.executeStatement(sqlQuery);
        
        //close connection
        dbi.closeConnection(connect);
        
    }
    
    public String UpdateOptions()
    {
        String Result = "";
        String sqlQuery = "";
        
        //if all are false
        if( !CurrentUser.getWomen() && 
            !CurrentUser.getMen() && 
            !CurrentUser.getTransWomen() && 
            !CurrentUser.getTransMen())
        {
            //then set default to true
            CurrentUser.setWomen(true);
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            //validate given username
                //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            error = "There seems to be a connection issue.";
            Result = "Options.xhtml";
        }
        
        sqlQuery = "BangOverUpdateOptions " + 
                CurrentUser.getUserIndex() + ", " + 
                CurrentUser.getWomen() + ", " + 
                CurrentUser.getMen() + ", " + 
                CurrentUser.getTransWomen() + ", " + 
                CurrentUser.getTransMen() + 
                ";";
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        
        dbi.closeConnection(connect);
        
        return Result;
    }
    
    public String SignUp()
    {
        String sqlQuery = "";
        String Result = "";
        
        if( password.compareTo(confirmPassword) != 0 )
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            Result = "SignUp.xhtml";
        }
        
        //Update preferences to match check boxes (local variables)
        try
        {
            //validate given username
                //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            error = "There seems to be a connection issue.";
            Result = "SignUp.xhtml";
        }

        if( !validate.ValidateEmail(email) )
        {
            return Result;
        }
        
        if( !boolWomen &&
            !boolMen &&
            !boolTransWomen &&
            !boolTransMen)
        {
            error = "You didn't select any preferences.";
            Result = "SignUp.xhtml";
        }
        
        sqlQuery = "BangOverSignUp '" + username + "', '" + email + "', '" + password + "', '" + 
                boolWomen + "', '" + 
                boolMen + "', '" + 
                boolTransWomen + "', '" + 
                boolTransMen + 
                "';";

        ResultSet rs = dbi.executeStatement(sqlQuery);

        dbi.closeConnection(connect);

        Result = "Login.xhtml";
        
        return Result;
    }
    
    
}
