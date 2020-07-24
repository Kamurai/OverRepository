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
    private boolean boolComedy;
    public boolean getboolComedy()
    {
        return boolComedy;
    }
    public void setboolComedy(boolean input)
    {
        boolComedy = input;
    }
    private boolean boolDrama;
    public boolean getboolDrama()
    {
        return boolDrama;
    }
    public void setboolDrama(boolean input)
    {
        boolDrama = input;
    }
    private boolean boolAction;
    public boolean getboolAction()
    {
        return boolAction;
    }
    public void setboolAction(boolean input)
    {
        boolAction = input;
    }
    private boolean boolHorror;
    public boolean getboolHorror()
    {
        return boolHorror;
    }
    public void setboolHorror(boolean input)
    {
        boolHorror = input;
    }
    private boolean boolThriller;
    public boolean getboolThriller()
    {
        return boolThriller;
    }
    public void setboolThriller(boolean input)
    {
        boolThriller = input;
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
    private boolean boolDocumentary;
    public boolean getboolDocumentary()
    {
        return boolDocumentary;
    }
    public void setboolDocumentary(boolean input)
    {
        boolDocumentary = input;
    }
    
    //Settings
    private boolean boolScienceFiction;
    public boolean getboolScienceFiction()
    {
        return boolScienceFiction;
    }
    public void setboolScienceFiction(boolean input)
    {
        boolScienceFiction = input;
    }
    private boolean boolFantasy;
    public boolean getboolFantasy()
    {
        return boolFantasy;
    }
    public void setboolFantasy(boolean input)
    {
        boolFantasy = input;
    }
    private boolean boolWestern;
    public boolean getboolWestern()
    {
        return boolWestern;
    }
    public void setboolWestern(boolean input)
    {
        boolWestern = input;
    }
    private boolean boolMartialArts;
    public boolean getboolMartialArts()
    {
        return boolMartialArts;
    }
    public void setboolMartialArts(boolean input)
    {
        boolMartialArts = input;
    }
    private boolean boolModern;
    public boolean getboolModern()
    {
        return boolModern;
    }
    public void setboolModern(boolean input)
    {
        boolModern = input;
    }
    private boolean boolHistoric;
    public boolean getboolHistoric()
    {
        return boolHistoric;
    }
    public void setboolHistoric(boolean input)
    {
        boolHistoric = input;
    }
    private boolean boolPrehistoric;
    public boolean getboolPrehistoric()
    {
        return boolPrehistoric;
    }
    public void setboolPrehistoric(boolean input)
    {
        boolPrehistoric = input;
    }
    private boolean boolComics;
    public boolean getboolComics()
    {
        return boolComics;
    }
    public void setboolComics(boolean input)
    {
        boolComics = input;
    }
    private boolean boolPeriod;
    public boolean getboolPeriod()
    {
        return boolPeriod;
    }
    public void setboolPeriod(boolean input)
    {
        boolPeriod = input;
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
        boolComedy = false;
        boolDrama = false;
        boolAction = false;
        boolHorror = false;
        boolThriller = false;
        boolMystery = false;
        boolDocumentary = false;
        //Settings
        boolScienceFiction = false;
        boolFantasy = false;
        boolWestern = false;
        boolMartialArts = false;
        boolModern = false;
        boolHistoric = false;
        boolPrehistoric = false;
        boolComics = false;
        boolPeriod = false;
        
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
                !boolComedy &&
                !boolDrama &&
                !boolAction &&
                !boolHorror &&
                !boolThriller &&
                !boolMystery &&
                !boolDocumentary &&
                //Settings
                !boolScienceFiction &&
                !boolFantasy &&
                !boolWestern &&
                !boolMartialArts &&
                !boolModern &&
                !boolHistoric &&
                !boolPrehistoric &&
                !boolComics &&
                !boolPeriod
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
                    boolComedy,
                    boolDrama,
                    boolAction,
                    boolHorror,
                    boolThriller,
                    boolMystery,
                    boolDocumentary,
                    //Settings
                    boolScienceFiction,
                    boolFantasy,
                    boolWestern,
                    boolMartialArts,
                    boolModern,
                    boolHistoric,
                    boolPrehistoric,
                    boolComics,
                    boolPeriod
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
