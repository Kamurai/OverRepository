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
    
    //Genres
    private boolean boolComedyS;
    public boolean getboolComedyS()
    {
        return boolComedyS;
    }
    public void setboolComedyS(boolean input)
    {
        boolComedyS = input;
    }
    private boolean boolDramaS;
    public boolean getboolDramaS()
    {
        return boolDramaS;
    }
    public void setboolDramaS(boolean input)
    {
        boolDramaS = input;
    }
    private boolean boolActionS;
    public boolean getboolActionS()
    {
        return boolActionS;
    }
    public void setboolActionS(boolean input)
    {
        boolActionS = input;
    }
    private boolean boolHorrorS;
    public boolean getboolHorrorS()
    {
        return boolHorrorS;
    }
    public void setboolHorrorS(boolean input)
    {
        boolHorrorS = input;
    }
    private boolean boolThrillerS;
    public boolean getboolThrillerS()
    {
        return boolThrillerS;
    }
    public void setboolThrillerS(boolean input)
    {
        boolThrillerS = input;
    }
    private boolean boolMysteryS;
    public boolean getboolMysteryS()
    {
        return boolMysteryS;
    }
    public void setboolMysteryS(boolean input)
    {
        boolMysteryS = input;
    }
    private boolean boolDocumentaryS;
    public boolean getboolDocumentaryS()
    {
        return boolDocumentaryS;
    }
    public void setboolDocumentaryS(boolean input)
    {
        boolDocumentaryS = input;
    }
    
    //Settings
    private boolean boolScienceFictionS;
    public boolean getboolScienceFictionS()
    {
        return boolScienceFictionS;
    }
    public void setboolScienceFictionS(boolean input)
    {
        boolScienceFictionS = input;
    }
    private boolean boolFantasyS;
    public boolean getboolFantasyS()
    {
        return boolFantasyS;
    }
    public void setboolFantasyS(boolean input)
    {
        boolFantasyS = input;
    }
    private boolean boolWesternS;
    public boolean getboolWesternS()
    {
        return boolWesternS;
    }
    public void setboolWesternS(boolean input)
    {
        boolWesternS = input;
    }
    private boolean boolMartialArtsS;
    public boolean getboolMartialArtsS()
    {
        return boolMartialArtsS;
    }
    public void setboolMartialArtsS(boolean input)
    {
        boolMartialArtsS = input;
    }
    private boolean boolModernS;
    public boolean getboolModernS()
    {
        return boolModernS;
    }
    public void setboolModernS(boolean input)
    {
        boolModernS = input;
    }
    private boolean boolHistoricS;
    public boolean getboolHistoricS()
    {
        return boolHistoricS;
    }
    public void setboolHistoricS(boolean input)
    {
        boolHistoricS = input;
    }
    private boolean boolPrehistoricS;
    public boolean getboolPrehistoricS()
    {
        return boolPrehistoricS;
    }
    public void setboolPrehistoricS(boolean input)
    {
        boolPrehistoricS = input;
    }
    private boolean boolComicsS;
    public boolean getboolComicsS()
    {
        return boolComicsS;
    }
    public void setboolComicsS(boolean input)
    {
        boolComicsS = input;
    }
    private boolean boolPeriodS;
    public boolean getboolPeriodS()
    {
        return boolPeriodS;
    }
    public void setboolPeriodS(boolean input)
    {
        boolPeriodS = input;
    }
     
    
    public LoginBean()
    {
        connect = null;
        dbi = new DbInfo();

        DefaultUser = new User(
        -1,
        "",
        "",
        0,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
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
        
        boolComedyS = false;
        boolDramaS = false;
        boolActionS = false;
        boolHorrorS = false;
        boolThrillerS = false;
        boolMysteryS = false;
        boolDocumentaryS = false;
        boolScienceFictionS = false;
        boolFantasyS = false;
        boolWesternS = false;
        boolMartialArtsS = false;
        boolModernS = false;
        boolHistoricS = false;
        boolPrehistoricS = false;
        boolComicsS = false;
        boolPeriodS = false;
        
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
        
        String sqlQuery = "ShowOverGetValidUser " + username + ", " + password;
        
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
                //Genres
                rs.getBoolean("ComedyS"),
                rs.getBoolean("DramaS"),
                rs.getBoolean("ActionS"),
                rs.getBoolean("HorrorS"),
                rs.getBoolean("ThrillerS"),
                rs.getBoolean("MysteryS"),
                rs.getBoolean("DocumentaryS"),
                //Settings
                rs.getBoolean("ScienceFictionS"),
                rs.getBoolean("FantasyS"),
                rs.getBoolean("WesternS"),
                rs.getBoolean("MartialArtsS"),
                rs.getBoolean("ModernS"), 
                rs.getBoolean("HistoricS"), 
                rs.getBoolean("PrehistoricS"), 
                rs.getBoolean("ComicsS"), 
                rs.getBoolean("PeriodS"), 
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
        String sqlQuery = "ShowOverSetOnlineStatus 1, " + user;
        
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
        String sqlQuery = "ShowOverSetOnlineStatus 0, " + user;
        
        //set local
        CurrentUser.setLoggedOn(false);
        
        //open connection
        connect = dbi.openConnection();
        
        dbi.executeStatement(sqlQuery);
        
        //close connection
        dbi.closeConnection(connect);
        
    }
    
    public void UpdateOptions()
    {
        String sqlQuery = "";
        
        //if all Genres are false
        if( !CurrentUser.getComedyS() && 
            !CurrentUser.getDramaS() && 
            !CurrentUser.getActionS() && 
            !CurrentUser.getHorrorS() && 
            !CurrentUser.getThrillerS() && 
            !CurrentUser.getMysteryS() && 
            !CurrentUser.getDocumentaryS()
        )
        {
            //then set female to true
            CurrentUser.setComedyS(true);
        }
        
        //if all Settings are false
        if( !CurrentUser.getScienceFictionS() && 
            !CurrentUser.getFantasyS() && 
            !CurrentUser.getWesternS() && 
            !CurrentUser.getMartialArtsS() && 
            !CurrentUser.getModernS() && 
            !CurrentUser.getHistoricS() && 
            !CurrentUser.getPrehistoricS() && 
            !CurrentUser.getComicsS() && 
            !CurrentUser.getPeriodS()
        )
        {
            //then set female to true
            CurrentUser.setModernS(true);
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
            //return null;
        }
        
        sqlQuery = "ShowOverUpdateOptions " + CurrentUser.getUserIndex() + ", " + 
                //Genres
                CurrentUser.getComedyS() + ", " + 
                CurrentUser.getDramaS() + ", " + 
                CurrentUser.getActionS() + ", " + 
                CurrentUser.getHorrorS() + ", " + 
                CurrentUser.getThrillerS() + ", " + 
                CurrentUser.getMysteryS() + ", " + 
                CurrentUser.getDocumentaryS() + ", " + 
                //Settings
                CurrentUser.getScienceFictionS() + ", " + 
                CurrentUser.getFantasyS() + ", " + 
                CurrentUser.getWesternS() + ", " + 
                CurrentUser.getMartialArtsS() + ", " + 
                CurrentUser.getModernS() + 
                CurrentUser.getHistoricS() + 
                CurrentUser.getPrehistoricS() + 
                CurrentUser.getComicsS() + 
                CurrentUser.getPeriodS() + 
                ";";
        ResultSet rs = dbi.executeStatement(sqlQuery);
        
        dbi.closeConnection(connect);
    }
    
    public String SignUp()
    {
        String sqlQuery = "";
        String Result = "";
        
        if( password.compareTo(confirmPassword) == 0 )
        {
        
            //Update preferences to match check boxes (local variables)
            try
            {
                //validate given username
                    //open connection
                connect = dbi.openConnection();
            }
            catch(Exception ex)
            {
                //return null;
            }

            sqlQuery = "ShowOverSignUp '" + username + "', '" + email + "', '" + password + "', '" + 
                    //Genres
                    CurrentUser.getComedyS() + ", " + 
                    CurrentUser.getDramaS() + ", " + 
                    CurrentUser.getActionS() + ", " + 
                    CurrentUser.getHorrorS() + ", " + 
                    CurrentUser.getThrillerS() + ", " + 
                    CurrentUser.getMysteryS() + ", " + 
                    CurrentUser.getDocumentaryS() + ", " + 
                    //Settings
                    CurrentUser.getScienceFictionS() + ", " + 
                    CurrentUser.getFantasyS() + ", " + 
                    CurrentUser.getWesternS() + ", " + 
                    CurrentUser.getMartialArtsS() + ", " + 
                    CurrentUser.getModernS() + 
                    CurrentUser.getHistoricS() + 
                    CurrentUser.getPrehistoricS() + 
                    CurrentUser.getComicsS() + 
                    CurrentUser.getPeriodS() + 
                    ";";
            ResultSet rs = dbi.executeStatement(sqlQuery);

            dbi.closeConnection(connect);
            
            
            
            
            Result = "Login.xhtml";
        }
        else
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            Result = "SignUp.xhtml";
        }
        
        
        return Result;
    }
    
    
}
