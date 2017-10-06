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
    private String error;
    public String getError()
    {
        return error;
    }
    public void setError(String input)
    {
        error = input;
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
    private String confirmPassword;
    public String getconfirmPassword()
    {
        return confirmPassword;
    }
    public void setconfirmPassword(String input)
    {
        confirmPassword = input;
    }
    
    //Genres
    private boolean boolComedyM;
    public boolean getboolComedyM()
    {
        return boolComedyM;
    }
    public void setboolComedyM(boolean input)
    {
        boolComedyM = input;
    }
    private boolean boolDramaM;
    public boolean getboolDramaM()
    {
        return boolDramaM;
    }
    public void setboolDramaM(boolean input)
    {
        boolDramaM = input;
    }
    private boolean boolActionM;
    public boolean getboolActionM()
    {
        return boolActionM;
    }
    public void setboolActionM(boolean input)
    {
        boolActionM = input;
    }
    private boolean boolHorrorM;
    public boolean getboolHorrorM()
    {
        return boolHorrorM;
    }
    public void setboolHorrorM(boolean input)
    {
        boolHorrorM = input;
    }
    private boolean boolThrillerM;
    public boolean getboolThrillerM()
    {
        return boolThrillerM;
    }
    public void setboolThrillerM(boolean input)
    {
        boolThrillerM = input;
    }
    private boolean boolMysteryM;
    public boolean getboolMysteryM()
    {
        return boolMysteryM;
    }
    public void setboolMysteryM(boolean input)
    {
        boolMysteryM = input;
    }
    private boolean boolDocumentaryM;
    public boolean getboolDocumentaryM()
    {
        return boolDocumentaryM;
    }
    public void setboolDocumentaryM(boolean input)
    {
        boolDocumentaryM = input;
    }
    
    //Settings
    private boolean boolScienceFictionM;
    public boolean getboolScienceFictionM()
    {
        return boolScienceFictionM;
    }
    public void setboolScienceFictionM(boolean input)
    {
        boolScienceFictionM = input;
    }
    private boolean boolFantasyM;
    public boolean getboolFantasyM()
    {
        return boolFantasyM;
    }
    public void setboolFantasyM(boolean input)
    {
        boolFantasyM = input;
    }
    private boolean boolWesternM;
    public boolean getboolWesternM()
    {
        return boolWesternM;
    }
    public void setboolWesternM(boolean input)
    {
        boolWesternM = input;
    }
    private boolean boolMartialArtsM;
    public boolean getboolMartialArtsM()
    {
        return boolMartialArtsM;
    }
    public void setboolMartialArtsM(boolean input)
    {
        boolMartialArtsM = input;
    }
    private boolean boolModernM;
    public boolean getboolModernM()
    {
        return boolModernM;
    }
    public void setboolModernM(boolean input)
    {
        boolModernM = input;
    }
    private boolean boolHistoricM;
    public boolean getboolHistoricM()
    {
        return boolHistoricM;
    }
    public void setboolHistoricM(boolean input)
    {
        boolHistoricM = input;
    }
    private boolean boolPrehistoricM;
    public boolean getboolPrehistoricM()
    {
        return boolPrehistoricM;
    }
    public void setboolPrehistoricM(boolean input)
    {
        boolPrehistoricM = input;
    }
    private boolean boolComicsM;
    public boolean getboolComicsM()
    {
        return boolComicsM;
    }
    public void setboolComicsM(boolean input)
    {
        boolComicsM = input;
    }
    private boolean boolPeriodM;
    public boolean getboolPeriodM()
    {
        return boolPeriodM;
    }
    public void setboolPeriodM(boolean input)
    {
        boolPeriodM = input;
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
        
        username = "";
        password = "";
        error = "";
        email = "";
        confirmPassword = "";
        //Genres
        boolComedyM = false;
        boolDramaM = false;
        boolActionM = false;
        boolHorrorM = false;
        boolThrillerM = false;
        boolMysteryM = false;
        boolDocumentaryM = false;
        //Settings
        boolScienceFictionM = false;
        boolFantasyM = false;
        boolWesternM = false;
        boolMartialArtsM = false;
        boolModernM = false;
        boolHistoricM = false;
        boolPrehistoricM = false;
        boolComicsM = false;
        boolPeriodM = false;
        
    }
    
    public String LogIn(String targetPage)
    {
        String Result = "Login";
        int rows = -1;
        
        try
        {
            //validate given username
                //open connection
            //connect = db.openConnection(dbi.getDriver(), dbi.getUrl(), dbi.getDbName(), dbi.getDbUsername(), dbi.getDbPassword());
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
        
        String sqlQuery = "WatchOverGetValidUser " + username + ", " + password;
        
        //ResultSet rs = db.executeStatement(connect, sqlQuery);
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
                rs.getBoolean("ComedyM"), 
                rs.getBoolean("DramaM"), 
                rs.getBoolean("ActionM"), 
                rs.getBoolean("HorrorM"), 
                rs.getBoolean("ThrillerM"), 
                rs.getBoolean("MysteryM"), 
                rs.getBoolean("DocumentaryM"), 
                //Settings
                rs.getBoolean("ScienceFictionM"), 
                rs.getBoolean("FantasyM"), 
                rs.getBoolean("WesternM"), 
                rs.getBoolean("MartialArtsM"), 
                rs.getBoolean("ModernM"), 
                rs.getBoolean("HistoricM"), 
                rs.getBoolean("PrehistoricM"), 
                rs.getBoolean("ComicsM"), 
                rs.getBoolean("PeriodM"), 
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
            setOnline(username);
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
        String sqlQuery = "WatchOverSetOnlineStatus 1, " + user;
        
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
        String sqlQuery = "WatchOverSetOnlineStatus 0, " + user;
        
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
        if( !CurrentUser.getComedyM() && 
            !CurrentUser.getDramaM() && 
            !CurrentUser.getActionM() && 
            !CurrentUser.getHorrorM() && 
            !CurrentUser.getThrillerM() && 
            !CurrentUser.getMysteryM() && 
            !CurrentUser.getDocumentaryM()
        )
        {
            //then set female to true
            CurrentUser.setComedyM(true);
        }
        
        //if all Settings are false
        if( !CurrentUser.getScienceFictionM() && 
            !CurrentUser.getFantasyM() && 
            !CurrentUser.getWesternM() && 
            !CurrentUser.getMartialArtsM() && 
            !CurrentUser.getModernM() && 
            !CurrentUser.getHistoricM() && 
            !CurrentUser.getPrehistoricM() && 
            !CurrentUser.getComicsM() && 
            !CurrentUser.getPeriodM()
        )
        {
            //then set female to true
            CurrentUser.setModernM(true);
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
        
        sqlQuery = "WatchOverUpdateOptions " + CurrentUser.getUserIndex() + ", " + 
                //Genres
                CurrentUser.getComedyM() + ", " + 
                CurrentUser.getDramaM() + ", " + 
                CurrentUser.getActionM() + ", " + 
                CurrentUser.getHorrorM() + ", " + 
                CurrentUser.getThrillerM() + ", " + 
                CurrentUser.getMysteryM() + ", " + 
                CurrentUser.getDocumentaryM() + ", " + 
                //Settings
                CurrentUser.getScienceFictionM() + ", " + 
                CurrentUser.getFantasyM() + ", " + 
                CurrentUser.getWesternM() + ", " + 
                CurrentUser.getMartialArtsM() + ", " + 
                CurrentUser.getModernM() + 
                CurrentUser.getHistoricM() + 
                CurrentUser.getPrehistoricM() + 
                CurrentUser.getComicsM() + 
                CurrentUser.getPeriodM() + 
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

            sqlQuery = "WatchOverSignUp '" + username + "', '" + email + "', '" + password + "', '" + 
                    //Genres
                    CurrentUser.getComedyM() + ", " + 
                    CurrentUser.getDramaM() + ", " + 
                    CurrentUser.getActionM() + ", " + 
                    CurrentUser.getHorrorM() + ", " + 
                    CurrentUser.getThrillerM() + ", " + 
                    CurrentUser.getMysteryM() + ", " + 
                    CurrentUser.getDocumentaryM() + ", " + 
                    //Settings
                    CurrentUser.getScienceFictionM() + ", " + 
                    CurrentUser.getFantasyM() + ", " + 
                    CurrentUser.getWesternM() + ", " + 
                    CurrentUser.getMartialArtsM() + ", " + 
                    CurrentUser.getModernM() + 
                    CurrentUser.getHistoricM() + 
                    CurrentUser.getPrehistoricM() + 
                    CurrentUser.getComicsM() + 
                    CurrentUser.getPeriodM() + 
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
