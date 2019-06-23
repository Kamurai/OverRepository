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
        }else if(
                //Genres
                !boolComedyM &&
                !boolDramaM &&
                !boolActionM &&
                !boolHorrorM &&
                !boolThrillerM &&
                !boolMysteryM &&
                !boolDocumentaryM &&
                //Settings
                !boolScienceFictionM &&
                !boolFantasyM &&
                !boolWesternM &&
                !boolMartialArtsM &&
                !boolModernM &&
                !boolHistoricM &&
                !boolPrehistoricM &&
                !boolComicsM &&
                !boolPeriodM
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
                    boolComedyM,
                    boolDramaM,
                    boolActionM,
                    boolHorrorM,
                    boolThrillerM,
                    boolMysteryM,
                    boolDocumentaryM,
                    //Settings
                    boolScienceFictionM,
                    boolFantasyM,
                    boolWesternM,
                    boolMartialArtsM,
                    boolModernM,
                    boolHistoricM,
                    boolPrehistoricM,
                    boolComicsM,
                    boolPeriodM
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
