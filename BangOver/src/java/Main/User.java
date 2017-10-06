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
    
    private boolean Women;
    public boolean getWomen()
    {
        return Women;
    }
    public void setWomen(boolean input)
    {
        Women = input;
    }
    private boolean Men;
    public boolean getMen()
    {
        return Men;
    }
    public void setMen(boolean input)
    {
        Men = input;
    }
    private boolean TransWomen;
    public boolean getTransWomen()
    {
        return TransWomen;
    }
    public void setTransWomen(boolean input)
    {
        TransWomen = input;
    }
    private boolean TransMen;
    public boolean getTransMen()
    {
        return TransMen;
    }
    public void setTransMen(boolean input)
    {
        TransMen = input;
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
    
    
    public User(int intUserIndex, String strUsername, String strEmail, int intAdminLevel, boolean boolWomen, boolean boolMen, boolean boolTransWomen, boolean boolTransMen, boolean boolLoggedOn)
    {
        UserIndex = intUserIndex;
        Username = strUsername;
        Email = strEmail;
        AdminLevel = intAdminLevel;
        
        Women = boolWomen;
        Men = boolMen;
        TransWomen = boolTransWomen;
        TransMen = boolTransMen;
        
        LoggedOn = boolLoggedOn;

    }
    
    public User(User newUser)
    {
        UserIndex = newUser.UserIndex;
        Username = newUser.Username;
        Email = newUser.Email;
        AdminLevel = newUser.AdminLevel;
        
        Women = newUser.Women;
        Men = newUser.Men;
        TransWomen = newUser.TransWomen;
        TransMen = newUser.TransMen;
        
        LoggedOn = newUser.LoggedOn;

    }
    
}
