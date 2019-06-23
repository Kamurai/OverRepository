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
    
    public LoginBean()
    {
        connect = null;
        dao = new LoginDAO();
        validate = new Validator();

        DefaultUser = new User(
        -1,
        "",
        "",
        0,
        false
        );
        CurrentUser = new User(DefaultUser);
        
        //SignUp Page variables
        username = "";
        password = "";
        confirmPassword = "";
        email = "";
        error = "";
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
    
    public String SignUp(){
        String result = "SignUp";
        
        if( password.compareTo(confirmPassword) != 0 )
        {
            //Return error for passwords not matching
            error = "Passwords do not match.";
            result = "SignUp";
        }else if( !validate.ValidateEmail(email) )
        {
            error = "You didn't enter a valid e-mail.";
            result = "SignUp";
        }else{
            if(dao.callableSignUp(username,
                    email,
                    password
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
