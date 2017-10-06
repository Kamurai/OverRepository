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
import javax.faces.bean.ViewScoped;
import java.util.ArrayList;
import java.util.List;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.ListDataModel;
import javax.faces.model.DataModel;

/**
 * @author Kamurai
 */
@ManagedBean(name="ManagementBean")
@ViewScoped
public class ManagementBean implements Serializable
{
    private Connection connect;
    private DbInfo dbi;
    private String error;
    public String geterror()
    {
        return error;
    }
    public void seterror(String input)
    {
        error = input;
    }
    private List<User> userList;
    public List<User> getuserList()
    {
        return userList;
    }
     public void setUserDataList() //set User Data Model
    {
        userList = new ArrayList<User>(PullUserDataModel());
    }
    public int getuserListSize()
    {
        int monkey = userList.size();
        return monkey;
    }
    private ArrayList<ArrayList<String>> ul;
    public ArrayList<ArrayList<String>> getul()
    {
        return ul;
    }
    public void setul() //set User List
    {
        ul = PullUserList();
        //dataModel = new ListDataModel<User>(ul);
    }
    public int getULSize()
    {
        int monkey = ul.size();
        return monkey;
    }
    private ArrayList<ArrayList<String>> uc;
    public ArrayList<ArrayList<String>> getuc()
    {
        return uc;
    }
    public int getUCSize()
    {
        int monkey = uc.size();
        return monkey;
    }
    public void setUserCounts()//set User Counts
    {
        uc = PullUserCounts();
    }
    private String ManagementTargetUsername;
    public void setManagementTargetUsername(String userName)
    {
        ManagementTargetUsername = userName;
    }
    public String getManagementTargetUsername()
    {
        return ManagementTargetUsername;
    }
    private DataModel<User> dataModel;
    public DataModel<User> getdataModel()
    {
        return dataModel;
    }
    
    
    public ManagementBean()
    {
        connect = null;
        dbi = new DbInfo();
        error = "";
        
        userList = new ArrayList<User>(PullUserDataModel());
        ul = new ArrayList<ArrayList<String>>(PullUserList());
        uc = new ArrayList<ArrayList<String>>(PullUserCounts());
        
        ManagementTargetUsername = "";
        dataModel = new ListDataModel<User>(PullUserDataModel());
    }
    
    public void UpdateUser(ValueChangeEvent e)
    {
        String sqlQuery = "";
        //String userName = ManagementTargetUsername;
        String adminLevel = e.getNewValue().toString();
        
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
        
        sqlQuery = "AllOverUpdateUser " + getManagementTargetUsername() + ", " + adminLevel + ";";
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        
        dbi.closeConnection(connect);
    }
    
    //Pull User Data Model
    public List<User> PullUserDataModel()
    {
        List<User> ResultList = new ArrayList<User>();
        User tempUser;
        ArrayList<String> Sub = new ArrayList<String>();
        
        String sqlQuery = "BangOverPullUserList";
        
        try
        {
            //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            return null;
        }
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        int rows = -1;
        
        try
        {
            rs.last();
            rows = rs.getRow();
            rs.beforeFirst();
            while(rs.next())
            {
                tempUser = new User(
                        rs.getInt("Indext"), 
                        rs.getString("Username"), 
                        rs.getString("Email"), 
                        rs.getInt("AdminLevel"),
                        rs.getBoolean("Women"), 
                        rs.getBoolean("Men"), 
                        rs.getBoolean("TransWomen"), 
                        rs.getBoolean("TransMen"), 
                        rs.getBoolean("LoggedOn") 
                );
                
                ResultList.add(new User(tempUser));
                //ResultList.add(new ArrayList<String>(Sub));
                Sub.clear();
            }
            
        }
        catch(Exception ex)
        {
            //close connection
            dbi.closeConnection();
        }
        
        return ResultList;
    }
    
    //Pull User List
    public ArrayList<ArrayList<String>> PullUserList()
    {
        ArrayList<ArrayList<String>> ResultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> Sub = new ArrayList<String>();
        
        String sqlQuery = "BangOverPullUserList";
        
        try
        {
            //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            return null;
        }
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        int rows = -1;
        
        try
        {
            rs.last();
            rows = rs.getRow();
            rs.beforeFirst();
            while(rs.next())
            {
                Sub.add(rs.getString("Username"));
                Sub.add(rs.getString("Email"));
                Sub.add(Integer.toString(rs.getInt("AdminLevel")));
                Sub.add(Integer.toString(rs.getInt("Women")));
                Sub.add(Integer.toString(rs.getInt("Men")));
                Sub.add(Integer.toString(rs.getInt("TransWomen")));
                Sub.add(Integer.toString(rs.getInt("TransMen")));
                Sub.add(Integer.toString(rs.getInt("LoggedOn")));
                
                ResultList.add(new ArrayList<String>(Sub));
                Sub.clear();
            }
            
        }
        catch(Exception ex)
        {
            //close connection
            dbi.closeConnection();
        }
        
        return ResultList;
    }
    
    //Pull User Counts
    public ArrayList<ArrayList<String>> PullUserCounts()
    {
        ArrayList<ArrayList<String>> ResultList = new ArrayList<ArrayList<String>>();
        ArrayList<String> Sub = new ArrayList<String>();
        
        String sqlQuery = "BangOverPullUserCounts";
        
        try
        {
            //open connection
            connect = dbi.openConnection();
        }
        catch(Exception ex)
        {
            return null;
        }
        
        ResultSet rs = dbi.executeStatement(sqlQuery);
        int rows = -1;
        
        try
        {
            rs.last();
            rows = rs.getRow();
            rs.beforeFirst();
            while(rs.next())
            {
                Sub.add(Integer.toString(rs.getInt("Retnum")));
                
                ResultList.add(new ArrayList<String>(Sub));
                Sub.clear();
            }
            
        }
        catch(Exception ex)
        {
            //close connection
            dbi.closeConnection();
        }
        
        return ResultList;
    }
    
}   
