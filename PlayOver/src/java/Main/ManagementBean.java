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
        
        String sqlQuery = "PlayOverPullUserList";
        
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
                        //Genres
                        rs.getBoolean("TwoDP"), 
                        rs.getBoolean("ThreeDP"), 
                        rs.getBoolean("FPS"), 
                        rs.getBoolean("FPP"), 
                        rs.getBoolean("VPuzzle"), 
                        rs.getBoolean("Bulletstorm"), 
                        rs.getBoolean("Fighting"), 
                        rs.getBoolean("Stealth"), 
                        rs.getBoolean("Survival"), 
                        rs.getBoolean("VN"), 
                        rs.getBoolean("IM"), 
                        rs.getBoolean("RPG"), 
                        rs.getBoolean("TRPG"), 
                        rs.getBoolean("ARPG"), 
                        rs.getBoolean("Sports"), 
                        rs.getBoolean("Racing"), 
                        rs.getBoolean("RTS"), 
                        rs.getBoolean("TBS"), 
                        rs.getBoolean("VE"), 
                        rs.getBoolean("MMO"), 
                        rs.getBoolean("MOBA"),
                        //Platforms
                        rs.getBoolean("PC"),
                        rs.getBoolean("Atari"),
                        rs.getBoolean("Commodore64"),
                        rs.getBoolean("FAMICOM"),
                        rs.getBoolean("NES"),
                        rs.getBoolean("SNES"),
                        rs.getBoolean("N64"),
                        rs.getBoolean("Gamecube"),
                        rs.getBoolean("Wii"),
                        rs.getBoolean("WiiU"),
                        rs.getBoolean("NintendoSwitch"),
                        rs.getBoolean("Gameboy"),
                        rs.getBoolean("VirtualBoy"),
                        rs.getBoolean("GBA"),
                        rs.getBoolean("DS"),
                        rs.getBoolean("ThreeDS"),
                        rs.getBoolean("SegaGenesis"),
                        rs.getBoolean("SegaCD"),
                        rs.getBoolean("SegaDreamcast"),
                        rs.getBoolean("PS1"),
                        rs.getBoolean("PS2"),
                        rs.getBoolean("PS3"),
                        rs.getBoolean("PS4"),
                        rs.getBoolean("PSP"),
                        rs.getBoolean("PSVita"),
                        rs.getBoolean("Xbox"),
                        rs.getBoolean("Xbox360"),
                        rs.getBoolean("XboxOne"),
                        rs.getBoolean("Ouya"),
                        rs.getBoolean("OculusRift"),
                        rs.getBoolean("Vive"),
                        rs.getBoolean("PSVR"),
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
        
        String sqlQuery = "PlayOverPullUserList";
        
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
                //Genres
                Sub.add(Integer.toString(rs.getInt("TwoDP")));
                Sub.add(Integer.toString(rs.getInt("ThreeDP")));
                Sub.add(Integer.toString(rs.getInt("FPS")));
                Sub.add(Integer.toString(rs.getInt("FPP")));
                Sub.add(Integer.toString(rs.getInt("VPuzzle")));
                Sub.add(Integer.toString(rs.getInt("Bulletstorm")));
                Sub.add(Integer.toString(rs.getInt("Fighting")));
                Sub.add(Integer.toString(rs.getInt("Stealth")));
                Sub.add(Integer.toString(rs.getInt("Survival")));
                Sub.add(Integer.toString(rs.getInt("VN")));
                Sub.add(Integer.toString(rs.getInt("IM")));
                Sub.add(Integer.toString(rs.getInt("RPG")));
                Sub.add(Integer.toString(rs.getInt("TRPG")));
                Sub.add(Integer.toString(rs.getInt("ARPG")));
                Sub.add(Integer.toString(rs.getInt("Sports")));
                Sub.add(Integer.toString(rs.getInt("Racing")));
                Sub.add(Integer.toString(rs.getInt("RTS")));
                Sub.add(Integer.toString(rs.getInt("TBS")));
                Sub.add(Integer.toString(rs.getInt("VE")));
                Sub.add(Integer.toString(rs.getInt("MMO")));
                Sub.add(Integer.toString(rs.getInt("Moba")));
                //Platforms
                Sub.add(Integer.toString(rs.getInt("PC")));
                Sub.add(Integer.toString(rs.getInt("Atari")));
                Sub.add(Integer.toString(rs.getInt("Commodore64")));
                Sub.add(Integer.toString(rs.getInt("FAMICOM")));
                Sub.add(Integer.toString(rs.getInt("NES")));
                Sub.add(Integer.toString(rs.getInt("SNES")));
                Sub.add(Integer.toString(rs.getInt("N64")));
                Sub.add(Integer.toString(rs.getInt("Gamecube")));
                Sub.add(Integer.toString(rs.getInt("Wii")));
                Sub.add(Integer.toString(rs.getInt("WiiU")));
                Sub.add(Integer.toString(rs.getInt("NintendoSwitch")));
                Sub.add(Integer.toString(rs.getInt("Gameboy")));
                Sub.add(Integer.toString(rs.getInt("VirtualBoy")));
                Sub.add(Integer.toString(rs.getInt("GBA")));
                Sub.add(Integer.toString(rs.getInt("DS")));
                Sub.add(Integer.toString(rs.getInt("ThreeDS")));
                Sub.add(Integer.toString(rs.getInt("SegaGenesis")));
                Sub.add(Integer.toString(rs.getInt("SegaCD")));
                Sub.add(Integer.toString(rs.getInt("SegaDreamcast")));
                Sub.add(Integer.toString(rs.getInt("PS1")));
                Sub.add(Integer.toString(rs.getInt("PS2")));
                Sub.add(Integer.toString(rs.getInt("PS3")));
                Sub.add(Integer.toString(rs.getInt("PS4")));
                Sub.add(Integer.toString(rs.getInt("PSP")));
                Sub.add(Integer.toString(rs.getInt("PSVita")));
                Sub.add(Integer.toString(rs.getInt("Xbox")));
                Sub.add(Integer.toString(rs.getInt("Xbox360")));
                Sub.add(Integer.toString(rs.getInt("XboxOne")));
                Sub.add(Integer.toString(rs.getInt("Ouya")));
                Sub.add(Integer.toString(rs.getInt("OculusRift")));
                Sub.add(Integer.toString(rs.getInt("Vive")));
                Sub.add(Integer.toString(rs.getInt("PSVR")));
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
        
        String sqlQuery = "PlayOverPullUserCounts";
        
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
