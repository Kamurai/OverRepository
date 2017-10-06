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
    
    private boolean boolDeckBuilding;
    public boolean getboolDeckBuilding()
    {
        return boolDeckBuilding;
    }
    public void setboolDeckBuilding(boolean input)
    {
        boolDeckBuilding = input;
    }
    private boolean boolFixedDeck;
    public boolean getboolFixedDeck()
    {
        return boolFixedDeck;
    }
    public void setboolFixedDeck(boolean input)
    {
        boolFixedDeck = input;
    }
    private boolean boolConstructedDeck;
    public boolean getboolConstructedDeck()
    {
        return boolConstructedDeck;
    }
    public void setboolConstructedDeck(boolean input)
    {
        boolConstructedDeck = input;
    }
    private boolean boolStrategy;
    public boolean getboolStrategy()
    {
        return boolStrategy;
    }
    public void setboolStrategy(boolean input)
    {
        boolStrategy = input;
    }
    private boolean boolWar;
    public boolean getboolWar()
    {
        return boolWar;
    }
    public void setboolWar(boolean input)
    {
        boolWar = input;
    }
    private boolean boolEconomy;
    public boolean getboolEconomy()
    {
        return boolEconomy;
    }
    public void setboolEconomy(boolean input)
    {
        boolEconomy = input;
    }
    private boolean boolTableauBuilding;
    public boolean getboolTableauBuilding()
    {
        return boolTableauBuilding;
    }
    public void setboolTableauBuilding(boolean input)
    {
        boolTableauBuilding = input;
    }
    private boolean boolCoop;
    public boolean getboolCoop()
    {
        return boolCoop;
    }
    public void setboolCoop(boolean input)
    {
        boolCoop = input;
    }
    private boolean boolMystery;
    public boolean getboolMystery()
    {
        return boolMystery;
    }
    public void setboolMystery(boolean input)
    {
        boolMystery = input;
    }
    private boolean boolSemiCoop;
    public boolean getboolSemiCoop()
    {
        return boolSemiCoop;
    }
    public void setboolSemiCoop(boolean input)
    {
        boolSemiCoop = input;
    }
    private boolean boolPPRPG;
    public boolean getboolPPRPG()
    {
        return boolPPRPG;
    }
    public void setboolPPRPG(boolean input)
    {
        boolPPRPG = input;
    }
    private boolean boolBluffing;
    public boolean getboolBluffing()
    {
        return boolBluffing;
    }
    public void setboolBluffing(boolean input)
    {
        boolBluffing = input;
    }
    private boolean boolPuzzle;
    public boolean getboolPuzzle()
    {
        return boolPuzzle;
    }
    public void setboolPuzzle(boolean input)
    {
        boolPuzzle = input;
    }
    private boolean boolDexterity;
    public boolean getboolDexterity()
    {
        return boolDexterity;
    }
    public void setboolDexterity(boolean input)
    {
        boolDexterity = input;
    }
    private boolean boolParty;
    public boolean getboolParty()
    {
        return boolParty;
    }
    public void setboolParty(boolean input)
    {
        boolParty = input;
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
        false
        );
        CurrentUser = new User(DefaultUser);
        
        //SignUp Page variables
        username = "";
        password = "";
        confirmPassword = "";
        email = "";
        error = "";
        
        boolDeckBuilding = false;
        boolFixedDeck = false;
        boolConstructedDeck = false;
        boolStrategy = false;
        boolWar = false;
        boolEconomy = false; 
        boolTableauBuilding = false;
        boolCoop = false;
        boolMystery = false;
        boolSemiCoop = false;
        boolPPRPG = false;
        boolBluffing = false;
        boolPuzzle = false;
        boolDexterity = false;
        boolParty = false;

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
        
        String sqlQuery = "BoardOverGetValidUser " + username + ", " + password;
        
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
                rs.getBoolean("DeckBuilding"), 
                rs.getBoolean("FixedDeck"),
                rs.getBoolean("ConstructedDeck"),
                rs.getBoolean("Strategy"),
                rs.getBoolean("War"),
                rs.getBoolean("Economy"),
                rs.getBoolean("TableauBuilding"),
                rs.getBoolean("Coop"),
                rs.getBoolean("Mystery"),
                rs.getBoolean("SemiCoop"),
                rs.getBoolean("PPRPG"),
                rs.getBoolean("Bluffing"),
                rs.getBoolean("Puzzle"),
                rs.getBoolean("Dexterity"),
                rs.getBoolean("Party"),
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
        String sqlQuery = "BoardOversetOnlineStatus 1, " + user;
        
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
        String sqlQuery = "BoardOversetOnlineStatus 0, " + user;
        
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
        
        //if all are false
        if( !CurrentUser.getDeckBuilding() && 
            !CurrentUser.getFixedDeck() && 
            !CurrentUser.getConstructedDeck() && 
            !CurrentUser.getStrategy() &&
            !CurrentUser.getWar() &&
            !CurrentUser.getEconomy() &&
            !CurrentUser.getTableauBuilding() &&
            !CurrentUser.getCoop() &&
            !CurrentUser.getMystery() &&
            !CurrentUser.getSemiCoop() &&
            !CurrentUser.getPPRPG() &&
            !CurrentUser.getBluffing() &&
            !CurrentUser.getPuzzle() &&
            !CurrentUser.getDexterity() &&
            !CurrentUser.getParty()
            )
        {
            //then set female to true
            setboolDeckBuilding(true);
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
        
        sqlQuery = "BoardOverUpdateOptions " + CurrentUser.getUserIndex()+ ", " + 
                CurrentUser.getDeckBuilding() + ", " + 
                CurrentUser.getFixedDeck() + ", " + 
                CurrentUser.getConstructedDeck() + ", " + 
                CurrentUser.getStrategy() + ", " + 
                CurrentUser.getWar() + ", " + 
                CurrentUser.getEconomy() + ", " + 
                CurrentUser.getTableauBuilding() + ", " + 
                CurrentUser.getCoop() + ", " + 
                CurrentUser.getMystery() + ", " + 
                CurrentUser.getSemiCoop() + ", " + 
                CurrentUser.getPPRPG() + ", " + 
                CurrentUser.getBluffing() + ", " + 
                CurrentUser.getPuzzle() + ", " + 
                CurrentUser.getDexterity() + ", " + 
                CurrentUser.getParty() + 
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

            sqlQuery = "BoardOverSignUp '" + username + "', '" + email + "', '" + password + "', '" + 
                    boolDeckBuilding + "', '" + 
                    boolFixedDeck + "', '" + 
                    boolConstructedDeck + "', '" + 
                    boolStrategy + "', '" + 
                    boolEconomy + "', '" + 
                    boolTableauBuilding + "', '" + 
                    boolCoop + "', '" + 
                    boolMystery + "', '" + 
                    boolSemiCoop + "', '" + 
                    boolPPRPG + "', '" + 
                    boolBluffing + "', '" + 
                    boolPuzzle + "', '" + 
                    boolDexterity + "', '" + 
                    boolParty +  
                    "';";

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
