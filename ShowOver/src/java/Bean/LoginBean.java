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
        dao = new LoginDAO();
        validate = new Validator();

        DefaultUser = new User(
        -1,
        0,
        false,
        
        "",
        "",
        true,
        //Genres
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        //Settings
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
        //Genres
        boolComedyS = false;
        boolDramaS = false;
        boolActionS = false;
        boolHorrorS = false;
        boolThrillerS = false;
        boolMysteryS = false;
        boolDocumentaryS = false;
        //Settings
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
    
    public void UpdateOptions(){
        dao.callableUpdateOptions(CurrentUser);
    }
    
    public void clearMemories(){
        dao.callableClearMemories(CurrentUser);
    }
    
    public String SignUp(){
        String result = "SignUp";
        
        if( password.compareTo(confirmPassword) != 0 )
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            result = "SignUp";
        }else if(
                //Genres
                !boolComedyS &&
                !boolDramaS &&
                !boolActionS &&
                !boolHorrorS &&
                !boolThrillerS &&
                !boolMysteryS &&
                !boolDocumentaryS &&
                //Settings
                !boolScienceFictionS &&
                !boolFantasyS &&
                !boolWesternS &&
                !boolMartialArtsS &&
                !boolModernS &&
                !boolHistoricS &&
                !boolPrehistoricS &&
                !boolComicsS &&
                !boolPeriodS
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
                    //Genres
                    boolComedyS,
                    boolDramaS,
                    boolActionS,
                    boolHorrorS,
                    boolThrillerS,
                    boolMysteryS,
                    boolDocumentaryS,
                    //Settings
                    boolScienceFictionS,
                    boolFantasyS,
                    boolWesternS,
                    boolMartialArtsS,
                    boolModernS,
                    boolHistoricS,
                    boolPrehistoricS,
                    boolComicsS,
                    boolPeriodS
            )){
                result = "Login";
            }else{
                result = "SignUp";
            }
        }
        
        return result;
    }
    
    //Determine if current user is authorized to edit target user
    public boolean isAuthorized(User rowUser)
    {
        boolean result = false;
        
        if(CurrentUser.getAdminLevel() >= rowUser.getAdminLevel() && CurrentUser.getAdminLevel() != 0){
            result = true;
        }else{
            result = false;
        }
        
        return result;
    }
}
