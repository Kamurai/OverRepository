/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Main;

/**
 * @author Kamurai
 */
public class User 
{
    private int UserIndex;
    public int getUserIndex()
    {
        return UserIndex;
    }
    public void setUserIndex(int input)
    {
        UserIndex = input;
    }
    private String Username;
    public String getUsername()
    {
        return Username;
    }
    public void setUsername(String input)
    {
        Username = input;
    }
    private String Email;
    public String getEmail()
    {
        return Email;
    }
    public void setEmail(String input)
    {
        Email = input;
    }
    private int AdminLevel;
    public int getAdminLevel()
    {
        return AdminLevel;
    }
    public void setAdminLevel(int input)
    {
        AdminLevel = input;
    }
    
    private boolean LoggedOn;
    public boolean getLoggedOn()
    {
        return LoggedOn;
    }
    public void setLoggedOn(boolean input)
    {
        LoggedOn = input;
    }
    
    
    public User(int intUserIndex, String strUsername, String strEmail, int intAdminLevel, boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        
        LoggedOn = boolLoggedOn;
    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        
        LoggedOn = newUser.LoggedOn;
    }    
}
