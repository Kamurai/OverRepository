/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;

import Database.LoginDAO;
import Main.User;
import Main.Validator;
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
    private LoginDAO dao;
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
        dao = new LoginDAO();
        validate = new Validator();

        DefaultUser = new User(
        -1,
        0,
        false,
                
        "",
        "",
                
        //Genres
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
        String result = "Login";
        
        CurrentUser = dao.callableLogIn(username, password);
        
        if(CurrentUser != null){
            CurrentUser.setLoggedOn(dao.callableSetOnline(CurrentUser.getUsername()));
            
            if(CurrentUser.getLoggedOn()){
                result = targetPage;
            }
        }
        
        return result;                
    }
    
    public String LogOut()
    {
        String Result = "Login";
        int rows = -1;
        
        //Update Username
        dao.callableSetOffline(CurrentUser.getUsername());
        
        //reset variables
        CurrentUser = new User(DefaultUser);
        
        return Result;
    }
    
    @PreDestroy
    public void preDestroyLogOut()
    {
        dao.callableSetOffline(CurrentUser.getUsername());
    }
    
    public void UpdateOptions()
    {
//        String result = "Options";
        
        dao.callableUpdateOptions(CurrentUser);
        
//        return result;
    }
    
    public String SignUp(){
        String result = "SignUp";
        
        if( password.compareTo(confirmPassword) != 0 )
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            result = "SignUp";
        }else if( !boolDeckBuilding &&
                !boolFixedDeck &&
                !boolConstructedDeck &&
                !boolStrategy &&
                !boolEconomy &&
                !boolTableauBuilding &&
                !boolCoop &&
                !boolMystery &&
                !boolSemiCoop &&
                !boolPPRPG &&
                !boolBluffing &&
                !boolPuzzle &&
                !boolDexterity &&
                !boolParty
                )
        {
            error = "You didn't select any preferences.";
            result = "SignUp";
        }else if( !validate.ValidateEmail(email) )
        {
            error = "You didn't enter a valid e-mail.";
            result = "SignUp";
        }else{
            if(dao.callableSignUp(username,
                    email,
                    password,
                    boolDeckBuilding,
                    boolFixedDeck,
                    boolConstructedDeck,
                    boolStrategy,
                    boolWar,
                    boolEconomy,
                    boolTableauBuilding,
                    boolCoop,
                    boolMystery,
                    boolSemiCoop,
                    boolPPRPG,
                    boolBluffing,
                    boolPuzzle,
                    boolDexterity,
                    boolParty
            )){
                result = "Login";
            }else{
                result = "SignUp";
            }
        }
        
        return result;
    }
    
    
}
